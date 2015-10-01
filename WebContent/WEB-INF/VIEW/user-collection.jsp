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
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
<title>${user.name}的收藏</title>
</head>
<body>
<div id="main">
	<c:forEach items="${articleCollection}" var="ac">
		<div>
			${ac.id}
		</div>
		<div>
			${ac.aid}
		</div>
		<div>
			${ac.create_date}
		</div>
		<div>
			${ac.title}
		</div>
		<div>
			${ac.intro}
		</div>
		<div>
			${ac.publish_date}
		</div>
		<div>
			${ac.writer_name}
		</div>
	</c:forEach>
</div>
</body>
</html>