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
	$("#menu-nav ul>li[menu='article']").addClass("active");
	$("#submenu-nav ul[parent='article']").show();
	$("#submenu-nav ul[parent='article']>li[submenu='list']").addClass("active");
});
</script>
</head>
<body>
article list
</body>
</html>