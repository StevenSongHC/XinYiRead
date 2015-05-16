<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
<style type="text/css">
#censor-container p {
	text-indent: 2em;
}
#censor-container h3 {
	text-align: center;
	font-weight: bold;
	cursor: default;
}
#censor-container .header {
	text-align: center;
}
#censor-container .body {
	background-color: #ccc;
	padding: 15px;
}
#censor-container .footer {
	margin-top: 10px;
	font-size: 14px;
}
#censor-container .writer {
	font-weight: bold;
	cursor: default;
}
#censor-container .anonymous {
	color: #ccc;
}
#censor-container .publish-date {
	color: #808080;
	font-style: italic;
	font-size: 15px;
	margin-left: 10px;
}
#censor-container .footer img {
	width: 20px;
	height: 20px;
}
#censor-container .tag-item {
	margin: 0 5px;
}
</style>
<div id="censor-container">
	<h3>${article.title}</h3>
	<div class="header">
	<c:choose>
	<c:when test="${article.is_writer_show == 1}">
		<span class="writer">${article.writer_name}</span>
	</c:when>
	<c:otherwise>
		<span class="anonymous">* 匿名 *</span>
	</c:otherwise>
	</c:choose>
		<span class="publish-date">${article.publish_date}</span>
	</div>
	<div class="body">
		${article.content}
	</div>
	<div class="footer">
	<c:choose>
	<c:when test="${not empty article.tags}">
		<c:forEach items="${article.tags}" var="tag">
		<span class="tag-item">
			<img src="<%=basepath%>/images/tag.png">
			<span>${tag.name}</span>
		</span>
	</c:forEach>
	</c:when>
	<c:otherwise>
		无标签
	</c:otherwise>
	</c:choose>
	
	</div>
</div>