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
	
	/*
	 * make every editable element uneditable
	 * when artivle was published
	 */
	if ($("#hidden-complete-flag").length > 0) {
		$("#btn-save").attr("disabled", "disabled");
		$("#btn-submit").attr("disabled", "disabled");
		$("#article-category").attr("disabled", "disabled");
		$("#article-title").attr("readOnly", true);
		$("#add-tag").hide();
		$("#draft-stage").removeAttr("contenteditable");
		if ($("#hidden-not-anonymous").val() == 1)
			$("#anonymous-label").attr("disabled", "disabled");
		else
			$("#pen-name-label").attr("disabled", "disabled");
		$(".tag-item").children("span:not(.tag-name)").remove();
	}
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

function submitArticle(isComplete) {
	if ($("#article-title").val().trim() != "") {
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
		if (isComplete == 1) {
			var msg = "";
			if ($("input[type='radio'][name='showWriter']:checked").val() == 0)
				msg += "你将以 [匿名（管理员可见）] 方式发表！";
			if ($("#article-category").children("option:selected").val() == 0)
				msg += "\n该篇文章未分类，不利于读者根据兴趣看到这篇文章！";
			if (tagArr.length == 0)
				msg += "\n未添加任何标签，将使本文章难以根据关键字被检索到！";
			msg += "\n\n确定继续？";
	
			if (msg == "\n\n确定继续？")
				msg = "确定提交文章？";
			
			if (confirm(msg)) {
				doSubmit(isComplete, tagArr);
			};
		}
		else
			doSubmit(isComplete, tagArr);
	}
	else
		alert("标题不得为空");
}

function doSubmit(isComplete, tagArr) {
	$.ajax( {
		url: "<%=basepath%>/article/draft/submit",
		type: "POST",
		dataType: "JSON",
		data: {
			aid: $("#article-aid").val(),
			title: $("#article-title").val().trim(),
			content: $("#draft-stage").html().trim(),
			isWriterShow: $("input[type='radio'][name='showWriter']:checked").val(),
			catid: $("#article-category").children("option:selected").val(),
			isComplete: isComplete,
			"tags[]": tagArr
		}
	}).done(function(json) {
		switch (json.status) {
			case -5:
				alert("您已提交该文章，请再成功撤回提交后再保存");
				break;
			case -4:
				alert("保存的文章不存在！！！");
				window.location.href="<%=basepath%>/writer";
				break;
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
				window.location.href="<%=basepath%>/article/draft/" + json.addr;
				break;
			case 1:
				console.log("saved succeed");
				break;
			case 2:
				window.location.href="<%=basepath%>/writer";
				break;
			default:
				alert("未知错误");
		}
	}).fail(function() {
		alert("failed to save");
	});
}

function cancelPublish() {
	if (confirm("确定继续？")) {
		$.ajax( {
			url: "<%=basepath%>/article/cancel_publish",
			type: "POST",
			dataType: "JSON",
			data: {
				aid: $("#article-aid").val()
			}
		}).done(function(json) {
			switch (json.status) {
				case -4:
					alert("文章状态更改失败，请重新操作");
					window.location.reload();
					break;
				case -3:
					window.location.href="<%=basepath%>/no_permission";
					break;
				case -2:
					alert("该文章审核中，暂时无法撤销！");
					$("#cp-block").html("<button class='btn btn-primary btn-lg' disabled='disabled'>不可用</button>");
					break;
				case -1:
					alert("登陆信息已失效，请重新登陆");
					window.location.href="<%=basepath%>/login";
					break;
				case 0:
					alert("文章不存在？！");
					window.location.reload();
					break;
				case 1:
					alert("提交成功");
					window.location.reload();
					break;
				default:
					alert("未知错误");
			}
		}).fail(function() {
			alert("failed to apply");
		});
	}
}
</script>
<title>Draft here</title>
</head>
<body>
<div id="main">
<c:if test="${article.is_complete == 1}">
	<div class="jumbotron">
	<c:choose>
		<c:when test="${article.is_censored == 0}">
			<p>您已提交本文章，在成功撤回文章发布申请后，才可进行进一步的编辑</p>
			<p id="cp-block"><button class="btn btn-primary btn-lg" onclick="javascript:cancelPublish()">撤销发布</button></p>
		</c:when>
		<c:otherwise>
			<c:if test="${article.is_censored == 1}">
			<p>本文章已通过审核，并与读者见面啦，点<a href="<%=basepath%>/article/${article.id}">此处</a>转到文章阅读页</p>
			<p id="cp-block">或者你想&nbsp;&nbsp;<button class="btn btn-primary btn-lg" onclick="javascript:cancelPublish()">继续完善</button></p>
			</c:if>
			<c:if test="${article.is_censored == -1}">
			<p>很遗憾，本文章并未通过审核，点击下方按钮即可重新编辑并重新提交</p>
			<p id="cp-block"><button class="btn btn-primary btn-lg" onclick="javascript:cancelPublish()">重新修改</button></p>
			</c:if>
		</c:otherwise>
	</c:choose>
	</div>
	<input type="hidden" id="hidden-complete-flag">
	<input type="hidden" id="hidden-not-anonymous" value="${article.is_writer_show}">
</c:if>
	<div class="btn-group" data-toggle="buttons">
		<label id="pen-name-label" class="btn btn-info">
			<input type="radio" name="showWriter" value=1>以 [${sessionScope.WRITER_SESSION.penName}] 发表
		</label>
		<label id="anonymous-label" class="btn btn-info">
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
			<button id="add-tag" class="btn btn-default btn-sm" onclick="addTag()"><img src="<%=basepath%>/images/add.png" alt="添加标签" title="添加标签"></button>
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
	<button id="btn-save" class="btn btn-default fl-l" onclick="submitArticle(0)">Save</button>
	<button id="btn-submit" class="btn btn-default fl-r" onclick="submitArticle(1)">Submit</button>
</div>
</body>
</html>