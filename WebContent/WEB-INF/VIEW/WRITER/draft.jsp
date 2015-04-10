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
	$("#article-category").find("option[value='" + ${article.catid} + "']").attr("selected", "selected");
	$("#article-category").selectpicker("refresh");
});


function saveArticle() {
	$.ajax( {
		url: "<%=basepath%>/article/draft/save",
		type: "POST",
		dataType: "JSON",
		data: {
			aid: $("#article-aid").val(),
			title: $("#article-title").val().trim(),
			content: $("#draft-stage").html().trim(),
			catid: $("#article-category").children("option:selected").val()
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
	
	console.log($("#tmp").val());
}

function clearContentStyle() {
	/* $("#tmp").val($("#draft-stage>p:last").html().trim());
	$("#draft-stage>p:last").html($("#tmp").val());
	console.log($("#draft-stage>p:last").html()); */
	$("#tmp").val($("#draft-stage>*:last").html().trim());
	$("#draft-stage>p:last").html($("#tmp").val().replace(/<[^>]+>/g, ""));
	console.log($("#draft-stage").html());
	//$("#draft-stage").html($("#tmp").val());
	//console.log($("#draft-stage").html().trim().replace(/<[^>]+>/g, ""));
}
</script>
<title>Draft here</title>
</head>
<body>
<div id="main">
	<div class="panel panel-default">
		<div class="panel-body">
			<select id="article-category" class="selectpicker" title="文章分类" data-live-search="true">
				<option value="0"></option>
			<c:forEach items="${categoryList}" var="cat">
				<option value="${cat.id}">${cat.name}</option>
			</c:forEach>
			</select>
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
		${article.content}
		<p><br></p>
	</div>
	<button class="btn btn-default" onclick="saveArticle()">Save</button>
	<textarea id="tmp" rows="4" cols="100"></textarea>
</div>
</body>
</html>