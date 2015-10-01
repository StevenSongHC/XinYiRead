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
<script type="text/javascript">
$(function() {
	/* BootstrapDialog.show({
		type: BootstrapDialog.TYPE_INFO,
		title: "Greeting",
		message: "欢迎访问 新意阅读网"
	 */
	});
</script>
<title>新意阅读网</title>
</head>
<body>
<h1>Hello World</h1>
<h5><a href="user/list">data test</a></h5>

</body>
</html>