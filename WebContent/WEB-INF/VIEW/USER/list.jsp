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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/bootstrap.min.css">
<script type="text/javascript"	src="<%=basepath%>/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap.min.js"></script>
<title>用户列表测试</title>
</head>
<body style="margin: auto;">
<table class="table table-hover" style="text-align: center;">
		<tr>
			<td width="40%">id</td>
			<td width="60%">name</td>
		</tr>
	<c:forEach items="${userList}" var="u">
		<tr>
			<td>${u.id}</td>
			<td>${u.name}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>