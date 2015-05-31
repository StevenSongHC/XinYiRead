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
<link rel="shortcut icon" href="<%=basepath%>/images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/article-style.css">
<title>${article.title} - 新意阅读</title>
</head>
<body>
<div id="main">
	<ol class="breadcrumb">
		<li><a href="#">主页</a></li>
		<li><a href="#">${article.category_name}</a></li>
		<li class="active">${article.title}</li>
	</ol>
	<h1>${article.title}</h1>
	作者：<a href="<%=basepath%>/writer/i/${article.writer_name}" target=_blank title="访问${article.writer_name}的个人主页">${article.writer_name}</a>
	发布时间：${article.publish_date}
	阅读量：${article.read_count}
	<div class="content">
		${article.content}
	</div>
</div>
</body>
</html>