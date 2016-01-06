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
	 // index starts with 0
	 $("#latest-category-articles>.category-item:odd").css("float", "right");
	 $("#latest-category-articles>.category-item:even").css("float", "left");
	});
</script>
<title>新意阅读网</title>
</head>
<body>
<div id="main">
	<div id="sidenav">
		<div id="categories">
			<div class="row">
			<c:forEach items="${categories}" var="cat">
				<span class="item"><a href="<%=basepath%>/search?category=${cat.name}">${cat.name}</a></span>
			</c:forEach>
			</div>
		</div>
	</div>
	<div id="article-list">
		<div id="latest">
			<div class="head-marker"><a href="<%=basepath%>/" title="更多" target="_blank">最新发布的文章</a></div>
		<c:forEach items="${latestPublishedArticleList}" var="a">
			<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
		</c:forEach>
		</div>
		<div id="recently-commented">
			<div class="head-marker"><a href="<%=basepath%>/" title="更多" target="_blank">最近被评论的文章</a></div>
		<c:forEach items="${latestCommentedArticleList}" var="a">
			<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
		</c:forEach>
		</div>
		<div id="recently-liked">
			<div class="head-marker"><a href="<%=basepath%>/" title="更多" target="_blank">最近被点赞的文章</a></div>
		<c:forEach items="${latestLikedArticleList}" var="a">
			<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
		</c:forEach>
		</div>
		<div style="clear: both;"></div>
		<div id="latest-category-articles">
		<c:forEach items="${categoryArticleList}" var="cal">
			<div class="category-item">
				<div class="head-marker"><a href="<%=basepath%>/search?category=${cal.categoryName}" title="更多" target="_blank">${cal.categoryName}</a></div>
				<c:forEach items="${cal.articles}" var="cala">
					<div class="item"><a href="<%=basepath%>/article/${cala.id}" target="_blank">${cala.title}</a></div>
				</c:forEach>
			</div>
		</c:forEach>
		</div>
	</div>
	<div id="special">
		<div id="search-box">
			<form class="form-inline" action="<%=basepath%>/search" target="_blank">
				<input type="text" name="keyword" class="form-control" placeholder="输入关键字">
				<button type="submit" class="btn btn-default"><img src="<%=basepath%>/images/search_icon.png" width="20" height="20"/></button>
			</form>
		</div>
	</div>
	<div style="clear: both;"></div>
</div>
</body>
</html>