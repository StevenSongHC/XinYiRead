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
<script type="text/javascript">
$(document).ready(function() {
	$("#menu-nav ul>li[menu='user']").addClass("active");
	$("#submenu-nav ul[parent='user']").show();
	$("#submenu-nav ul[parent='user']>li[submenu='list']").addClass("active");
});
</script>
</head>
<body>
<table class="table table-hover" style="text-align: center;">
		<tr>
			<td width="10%">ID</td>
			<td width="20%">用户名</td>
			<td width="30%">邮箱</td>
			<td width="8%">邮箱是否可见</td>
			<td width="21%">注册日期</td>
			<td width="21%">最后登录日期</td>
		</tr>
	<c:forEach items="${userList}" var="u">
		<tr>
			<td>${u.id}</td>
			<td>${u.name}</td>
			<td>${u.email}</td>
			<td>${u.isEmailShow}</td>
			<td>${u.joinDate}</td>
			<td>${u.lastLoginDate}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>