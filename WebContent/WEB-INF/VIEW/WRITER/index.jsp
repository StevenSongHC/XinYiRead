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
<jsp:include page="../include.jsp" flush="true" />
<jsp:include page="../top-bar.jsp" flush="true" />
<title>我的写作空间</title>
</head>
<body>
<a href="<%=basepath%>/writer/i/${writer.penName}" class="btn btn-default btn-lg">我的写手主页</a>
<a href="<%=basepath%>/article/draft/new" class="btn btn-default btn-lg">写文章</a>
</body>
</html>