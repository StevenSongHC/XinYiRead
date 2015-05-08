<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript">
$(document).ready(function() {
	$("#menu-nav ul>li[menu='permission']").addClass("active");
	$("#submenu-nav ul[parent='permission']").show();
	$("#submenu-nav ul[parent='permission']>li[submenu='role-list']").addClass("active");
});
</script>
<style type="text/css">

</style>
</head>
<body>
<table class="table table-hover" style="text-align: center; font-size: 18px;">
	<tr>
		<td>ID</td>
		<td>TITLE</td>
		<td>REMARK</td>
	</tr>
<c:forEach items="${roleList}" var="r">
	<tr>
		<td>${r.id}</td>
		<td>${r.title}</td>
		<td>${r.remark}</td>
	</tr>
</c:forEach>
</table>
</body>
</html>