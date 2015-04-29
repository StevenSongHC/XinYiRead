<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../include.jsp" flush="true" />
<jsp:include page="../top-bar.jsp" flush="true" />
<link rel="stylesheet" href="<%=basepath%>/css/article-draft.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap-select.min.css">
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-select.min.js"></script>
<script type="text/javascript"	src="<%=basepath%>/js/draft-editor.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("select").selectpicker();
	
	if ($("#article-aid").val() != 0) {
		$("input[type='radio'][name='showWriter'][value=" + ${article.is_writer_show} + "]").attr("checked", "checked").parent().addClass("active");
		$("#article-category").find("option[value=" + ${article.catid} + "]").attr("selected", "selected");
	}
	else {
		$("input[type='radio'][name='showWriter'][value=1]").attr("checked", "checked").parent().addClass("active");
		$("#article-category").find("option[value=0]").attr("selected", "selected");
	}
	$("#article-category").selectpicker("refresh");
	
});

function addTag() {
	var newTag = "<div class='tag-item'>";
	newTag += "<img src='<%=basepath%>/images/tag.png'>";
	newTag += "<input type='text'>";
	newTag += "<span class='glyphicon glyphicon-ok' onclick='saveTag($(this))'></span>";
	newTag += "<span class='glyphicon glyphicon-trash' onclick='deleteTag($(this))'></span>";
	newTag += "</div>";
	$(".tag-block>.panel-body").prepend(newTag);
}
function saveTag(ele) {
	var tagName = ele.parent().children("input").val().trim();
	if (tagName != "") {
		if (tagName.length <= 10) {
			var newTag = "<img src='<%=basepath%>/images/tag.png'>";
			newTag += "<span class='tag-name'>" + tagName + "</span>";
			newTag += "<span class='glyphicon glyphicon-pencil' onclick='editTag($(this))'></span>";
			newTag += "<span class='glyphicon glyphicon-trash' onclick='deleteTag($(this))'></span>";
			ele.parent().html("").append(newTag);
		}
		else {
			alert("标签名必须小于10个汉字");
		}
	}
	else {
		alert("标签名不得为空");
	}
}
function editTag(ele) {
	var tagName = ele.parent().children(".tag-name").html();
	var newTag = "<img src='<%=basepath%>/images/tag.png'>";
	newTag += "<input type='text' value='" + tagName + "'>";
	newTag += "<span class='glyphicon glyphicon-ok' onclick='saveTag($(this))'></span>";
	newTag += "<span class='glyphicon glyphicon-trash' onclick='deleteTag($(this))'></span>";
	ele.parent().html("").append(newTag);
}
function deleteTag(ele) {
	if (confirm("确定要删除该标签 ？")) {
		ele.parent().remove();
	}
}

function saveArticle() {
	// parse tag into string array
	var tagArr = new Array();
	$(".tag-item").each(function(i, e) {
		var tag = $(this).children(".tag-name").html();
		if (tag != null) {
			// delete repeated tag
			if (tagArr.indexOf(tag) == -1)
				tagArr.push(tag);
			else
				$(this).remove();
		}
		else {
			alert("有未保存修改的标签，系统将不会提交未保存的标签！");
			$(this).children("input").focus();
		}
	});
	$.ajax( {
		url: "<%=basepath%>/article/draft/save",
		type: "POST",
		dataType: "JSON",
		data: {
			aid: $("#article-aid").val(),
			title: $("#article-title").val().trim(),
			content: $("#draft-stage").html().trim(),
			isWriterShow: $("input[type='radio'][name='showWriter']:checked").val(),
			catid: $("#article-category").children("option:selected").val(),
			"tags[]": tagArr
		}
	}).done(function(json) {
		switch (json.status) {
			case -3:
				alert("标题已存在，请更换");
				$("#article-title").focus();
				break;
			case -2:
				window.location.href="<%=basepath%>/login";
				break;
			case -1:
				alert("操作失败");
				break;
			case 0:
				console.log("saved succedd");
				break;
			case 1:
				window.location.href="<%=basepath%>/article/draft/" + json.addr;
				break;
			default:
				alert("未知错误");
		}
	}).fail(function() {
		alert("failed to save");
	});
}
</script>
<title>Draft here</title>
</head>
<body>
<div id="main">
	<div class="btn-group" data-toggle="buttons">
		<label class="btn btn-info">
			<input type="radio" name="showWriter" value=1>以 [${sessionScope.WRITER_SESSION.penName}] 发表
		</label>
		<label class="btn btn-info">
			<input type="radio" name="showWriter" value=0>匿名发表
		</label>
	</div>
	<div class="panel panel-default" style="margin-top: 40px;">
		<div class="panel-body">
			<select id="article-category" class="selectpicker" title="文章分类" data-live-search="true">
				<option value="0"></option>
			<c:forEach items="${categoryList}" var="cat">
				<option value="${cat.id}">${cat.name}</option>
			</c:forEach>
			</select>
		</div>
	</div>
	<div class="panel panel-default tag-block">
		<div class="panel-body">
		<c:forEach items="${article.tags}" var="tag">
			<div class="tag-item">
				<img src="<%=basepath%>/images/tag.png">
				<span class="tag-name">${tag.name}</span>
				<span class="glyphicon glyphicon-pencil" onclick="editTag($(this))"></span>
				<span class="glyphicon glyphicon-trash" onclick="deleteTag($(this))"></span>
			</div>
		</c:forEach>
			<button class="btn btn-default btn-sm" onclick="addTag()"><img src="<%=basepath%>/images/add.png" alt="添加标签" title="添加标签"></button>
		</div>
	</div>
	<c:choose>
	<c:when test="${empty requestScope.article}">
		<input type="hidden" id="article-aid" value="0">
	</c:when>
	<c:otherwise>
		<input type="hidden" id="article-aid" value="${article.id}">
	</c:otherwise>
	</c:choose>
	<input type="text" id="article-title" value="${article.title}">
	<div contentEditable="true" id="draft-stage">
	<c:choose>
	<c:when test="${empty requestScope.article.content}">
		<p><br></p>
	</c:when>
	<c:otherwise>
		${article.content}
	</c:otherwise>
	</c:choose>	
	</div>
	<button class="btn btn-default" onclick="saveArticle()">Save</button>
<c:if test="${not empty requestScope.article}">
	<button class="btn btn-default" onclick="submitArticle()">Submit</button>
</c:if>
</div>
</body>
</html>