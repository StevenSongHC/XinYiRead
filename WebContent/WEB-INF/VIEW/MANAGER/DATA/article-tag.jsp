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
	$("#submenu-nav ul[parent='article']>li[submenu='tag']").addClass("active");
});
</script>
<style type="text/css">

</style>
</head>
<body>
<table class="table table-hover" style="text-align: center; font-size: 18px;">
		<tr>
			<td width="20%">ID</td>
			<td width="45%">标签名</td>
			<td width="35%">相关文章数量</td>
		</tr>
	<c:forEach items="${tagList}" var="tag">
		<tr>
			<td>${tag.id}</td>
			<td>${tag.name}</td>
			<td><a href="<%=basepath%>/manager?menu=article&submenu=list&tagid=${tag.id}">${tag.article_count}</a></td>
		</tr>
	</c:forEach>
</table>
</body>
</html>