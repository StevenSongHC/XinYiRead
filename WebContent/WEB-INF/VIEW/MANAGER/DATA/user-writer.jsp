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
	$("#submenu-nav ul[parent='user']>li[submenu='writer']").addClass("active");
});
</script>
</head>
<body>
<table class="table table-hover" style="text-align: center;">
		<tr>
			<td width="15%">UID</td>
			<td width="35%">用户名</td>
			<td width="35%">写手名</td>
			<td width="15%">WID</td>
		</tr>
	<c:forEach items="${writerList}" var="w">
		<tr>
			<td>${w.user.id}</td>
			<td><a href="">${w.user.name}</a></td>
			<td><a href="">${w.penName}</a></td>
			<td>${w.id}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>