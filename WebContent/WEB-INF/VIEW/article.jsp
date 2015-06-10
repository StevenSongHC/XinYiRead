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
<link rel="shortcut icon" href="<%=basepath%>/images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/article-style.css">
<script type="text/javascript">
function ratingArticle(rating) {
	$.ajax( {
		url: "<%=basepath%>/article/rating_article",
		type: "POST",
		dataType: "JSON",
		data: {
			aid: ${article.id},
			rating: rating
		}
	}).done(function(json) {
		switch (json.status) {
			case -2:
				alert("非法格式");
				window.location.reload();
				break;
			case -1:
				alert("请先登录再进行评价");
				$("body").animate({scrollTop: $("#top-bar").offset().top}, 500);
				$("#top-bar #login-account").focus();
				break;
			case -0:
				alert("评价的文章不存在！？");
				window.location.reload();
				break;
			case 1:
				alert("感谢您的评价 :)");
				window.location.reload();
				break;
			case 2:
				alert("您已评价过该文章哦");
				break;
			default:
				alert("评价失败！");
		}
	}).fail(function() {
		alert("评价失败");
	});
}
</script>
<title>${article.title} | 新意阅读</title>
</head>
<body>
<div id="main">
	<ol class="breadcrumb">
		<li><a href="#">主页</a></li>
		<li><a href="#">${article.category_name}</a></li>
		<li class="active">${article.title}</li>
	</ol>
	<h1>${article.title}</h1>
	<div class="info">
		<span>作者：<a href="<%=basepath%>/writer/i/${article.writer_name}" target=_blank title="访问${article.writer_name}的个人主页">${article.writer_name}</a></span>
		<span>发布时间：${article.publish_date}</span>
		<span>阅读量：${article.read_count}</span>
	</div>
	<div class="content">
		${article.content}
	</div>
	<div class="tags">
		<c:forEach items="${article.tags}" var="tag">
			<span class="item"><a href="#" title="${tag.id}">${tag.name}</a></span>
		</c:forEach>
	</div>
</div>
<div class="rating">
	<button type="button" class="btn btn-success" style="float: left;" onclick="javascript:ratingArticle('up')"><span class="glyphicon glyphicon-thumbs-up"></span> 写得不错 <span class="badge">${article.like_count}</span></button>
	<button type="button" class="btn btn-warning" style="float: right;" onclick="javascript:ratingArticle('down')"><span class="glyphicon glyphicon-thumbs-down"></span> 马马虎虎 <span class="badge">${article.dislike_count}</span></button>
	<div style="clear: both;"></div>
</div>
<div style="clear: both;"></div>
</body>
</html>