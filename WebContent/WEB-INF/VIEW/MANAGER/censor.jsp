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
<script type="text/javascript">
$(document).ready(function() {
	
	var dataPage = $("#hidden-data-page").val();
	$("#main-content").load("<%=basepath%>/manager/load/" + dataPage);
});
</script>
<link rel="stylesheet" href="<%=basepath%>/css/censor-style.css" type="text/css" />
<title>审核页面</title>
</head>
<body>
<input id="hidden-data-page" type="hidden" value="${dataPage}">
<input id="hidden-roles" type="hidden" value="${userRoles}">
<div class="nav-menu">
	<div class="nav-menu-item" role-id=3>
		<div id="uncensored-article" class="list-group">
			<a href="<%=basepath%>/manager?query_data=uncensored_article" class="list-group-item">
				<h4 class="list-group-item-heading">未审核的文章 <span class="badge">${variesAmount.uncensored_article_amount}</span></h4>
				<p class="list-group-item-text">
					所有未审核的，包括被取消审核结果的文章都将被检索。选择列表上方的【文章分类】可以将不同分类的未审核文章分别列出
				</p>
			</a>
		</div>
		<div id="censored-article" class="list-group">
			<a href="<%=basepath%>/manager?query_data=censored_article" class="list-group-item">
				<h4 class="list-group-item-heading">已审核文章 <span class="badge">${variesAmount.censored_article_amount}</span></h4>
				<p class="list-group-item-text">
					所有经过审核的，包括通过与未通过审核的都将被显示。通过列表上方的过滤器可以筛选通过或为通过的文章
				</p>
			</a>
		</div>
	</div>
	<div class="nav-menu-item" role-id=4>
		<div id="reported-comment" class="list-group">
			<a href="<%=basepath%>/manager?query_data=reported_comment" class="list-group-item">
				<h4 class="list-group-item-heading">被举报的评论 <span class="badge">${variesAmount.reported_comment_amount}</span></h4>
				<p class="list-group-item-text">
					所有被举报的评论都将被检索。默认显示【未处理】的被举报评论，通过列表上方过滤器可检索到【已处理】的。
				</p>
			</a>
		</div>
	</div>
	<div class="nav-menu-item" role-id=5>
		<div id="message" class="list-group">
			<a href="<%=basepath%>/manager?query_data=message" class="list-group-item">
				<h4 class="list-group-item-heading">检索消息 </h4>
				<p class="list-group-item-text">
					你需要在列表上方选择检索的方式并键入相关搜索词。请记住，你的每一次操作都将被记录，请尊重用户隐私！
				</p>
			</a>
		</div>
	</div>
</div>
<div id="main-content">
	
</div>
</body>
</html>