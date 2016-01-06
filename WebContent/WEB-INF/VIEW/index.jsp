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
<jsp:include page="include.jsp" flush="true" />
<jsp:include page="top-bar.jsp" flush="true" />
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-my-pagination.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/index-style.css">
<script type="text/javascript">
$(function() {
	/* BootstrapDialog.show({
		type: BootstrapDialog.TYPE_INFO,
		title: "Greeting",
		message: "欢迎访问 新意阅读网"
	 */
	});
</script>
<title>新意阅读网</title>
</head>
<body>
<div id="main">
	<div id="categories">
		<div class="row">
		<c:forEach items="${categories}" var="cat">
			<span class="item"><a href="<%=basepath%>/category/${cat.name}">${cat.name}</a></span>
		</c:forEach>
		</div>
	</div>
	<div id="article-list">
		<div id="latest">
			<div class="head-marker">最新发布的文章</div>
		<c:forEach items="${latestArticleList}" var="a">
			<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
		</c:forEach>
		</div>
		<div id="recently-commented">
			<div class="head-marker">最新被评论的文章</div>
		<c:forEach items="${latestArticleList}" var="a">
			<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
		</c:forEach>
		</div>
		<div id="recently-liked">
			<div class="head-marker">最新被点赞的文章</div>
		<c:forEach items="${latestArticleList}" var="a">
			<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
		</c:forEach>
		</div>
		<div style="clear: both;"></div>
		<div id="latest-category-articles">
			latest
		</div>
	</div>
	<div id="special">
		special
	</div>
	<div style="clear: both;"></div>
</div>
</body>
</html>