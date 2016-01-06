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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/index-style.css"><script type="text/javascript">
$(function() {
	$("#categories .item[cat-name='${categoryName}']").children("a").css({"color": "#fff", "background-color" : "#ff5c00"});
});
</script>
<title>所有 ${categoryName} 的文章 | 新意阅读网</title>
</head>
<body>
<div id="main">
	<div id="categories">
		<div class="row">
		<c:forEach items="${categories}" var="cat">
			<span class="item" cat-name="${cat.name}"><a href="<%=basepath%>/category/${cat.name}">${cat.name}</a></span>
		</c:forEach>
		</div>
	</div>
	<div id="article-list">
	<c:forEach items="${articleList}" var="a">
		<div class="item"><a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a></div>
	</c:forEach>
	</div>
	<div id="special">
		
	</div>
</div>
</body>
</html>