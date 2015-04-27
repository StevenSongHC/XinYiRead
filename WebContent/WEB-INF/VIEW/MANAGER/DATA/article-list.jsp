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
	
	$(".sp").each(function() {
		$(this).prop("title", $(this).text());
	});
	$(".ml").each(function() {
		$(this).html($(this).text());
		$(this).prop("title", $(this).html());
	});
});
</script>
<style type="text/css">
.sp {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 100%;
	cursor: pointer;
}
</style>
</head>
<body>
<table class="table table-hover" style="text-align: center; table-layout: fixed;">
		<tr>
			<td width="7%">ID</td>
			<td width="7%">作者</td>
			<td width="8%">标题</td>
			<td width="6%">类别</td>
			<td width="6%">标签</td>
			<td width="10%">介绍</td>
			<td width="12%">内容</td>
			<td width="12%">推荐语</td>
			<td width="6%">阅读量</td>
			<td width="5%">喜欢数</td>
			<td width="5%">消极数</td>
			<td width="10%">发布（最后更新）日期</td>
			<td width="2%">是否完成</td>
			<td width="2%">匿名发表</td>
			<td width="2%">是否审核</td>
		</tr>
	<c:forEach items="${articleList}" var="a">
		<tr>
			<td>${a.id}</td>
			<td class="sp"><a href="">${a.writer_name}</a></td>
			<td class="sp"><a href="">${a.title}</a></td>
			<td class="sp"><a href="">${a.category_name}</a></td>
			<td class="sp">
			<c:forEach items="${a.tags}" var="tag">
				[${tag.name}]
			</c:forEach>
			</td>
			<td class="sp ml">${a.intro}</td>
			<td class="sp ml">${a.content}</td>
			<td class="sp ml">${a.recommand}</td>
			<td class="sp">${a.read_count}</td>
			<td class="sp">${a.like_count}</td>
			<td class="sp">${a.dislike_count}</td>
			<td>${a.publish_date}</td>
			<td>${a.is_complete}</td>
			<td>${a.is_writer_show}</td>
			<td>${a.is_censored}</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>