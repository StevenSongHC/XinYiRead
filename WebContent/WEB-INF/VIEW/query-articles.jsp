<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="include.jsp" flush="true" />
<jsp:include page="top-bar.jsp" flush="true" />
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/index-style.css"><script type="text/javascript">
$(function() {
	$("#categories .item[cat-name='${categoryName}']").children("a").css({"color": "#fff", "background-color" : "#ff5c00"});
	$("#orderby-func p[order='${orderBy}']").wrap("<blockquote></blockquote>");
});
</script>
<title>所有 ${categoryName} 的文章 | 新意阅读网</title>
</head>
<body>
<div id="main">
	<div id="sidenav">
		<div id="categories">
			<div class="row">
			<c:forEach items="${categories}" var="cat">
				<span class="item" cat-name="${cat.name}"><a href="<%=basepath%>/search?category=${cat.name}&keyword=${keyword}&order_by=${orderBy}">${cat.name}</a></span>
			</c:forEach>
			</div>
		</div>
		<div id="orderby-func">
			<p order="latest_published"><a href="<%=basepath%>/search?category=${categoryName}&keyword=${keyword}&order_by=latest_published">按发布时间排序</a></p>
			<p order="most_read"><a href="<%=basepath%>/search?category=${categoryName}&keyword=${keyword}&order_by=most_read">按阅读人数排序</a></p>
			<p order="most_like"><a href="<%=basepath%>/search?category=${categoryName}&keyword=${keyword}&order_by=most_like">按喜欢人数排序</a></p>
		</div>
	</div>
	<div id="article-list">
	<c:if test="${empty articleList}">
		<div class="empty">*&nbsp;未返回任何搜索结果&nbsp;*</div>
	</c:if>
	<c:forEach items="${articleList}" var="a">
		<div class="item well">
			<h4><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></h4>
			<div class="intro">
				${a.intro}
			</div>
			<div class="basic-info">
				发布日期：<fmt:formatDate pattern="yyyy-MM-dd" value="${a.update_time}"/>&nbsp;&nbsp;&nbsp;&nbsp;阅读量：${a.read_count}
			</div>
		</div>
	</c:forEach>
	</div>
	<div id="special">
		<div id="search-box">
			<form class="form-inline" action="<%=basepath%>/search">
				<input type="text" name="keyword" class="form-control" placeholder="输入关键字" value="${keyword}">
				<input type="hidden" name="category" value="${categoryName}">
				<input type="hidden" name="order_by" value="${orderBy}">
				<button type="submit" class="btn btn-default"><img src="<%=basepath%>/images/search_icon.png" width="20" height="20"/></button>
			</form>
		</div>
	</div>
</div>
</body>
</html>