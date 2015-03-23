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
<title>HELLO</title>
</head>
<body>
<h1>list1</h1>
<ul>
<c:forEach items="${list1}" var="l1">
	<li>${l1}</li>
</c:forEach>
</ul>
<h1>list2</h1>
<ul>
<c:forEach items="${list2}" var="l2">
	<li>${l2}</li>
</c:forEach>
</ul>
</body>
</html>