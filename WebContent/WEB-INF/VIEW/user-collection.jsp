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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/user-collection.css">
<script type="text/javascript">
$(document).ready(function() {
	
});

function toggleDetails(id) {
	var clcItem = $(".article-collection .item[data-id=" + id + "]");
	var dsp = $(clcItem).find(".view-zone a.h");
	$(clcItem).find(".view-zone a").addClass("h");
	$(dsp).removeClass("h");
	$(clcItem).children(".details").toggle("fast");
}

function removeCollection(id, aid) {
	if (confirm("确定删除？")) {
		$.ajax( {
			url: "<%=basepath%>/article/remove_collection",
			type: "POST",
			dataType: "JSON",
			data: {
				aid: aid
			}
		}).done(function(json) {
			switch (json.status) {
				case -2:
					alert("删除失败\n重载入页面");
					window.location.reload();
					break;
				case -1:
					alert("登录信息失效，请重新登陆");
					window.location.href = "<%=basepath%>/login";
					break;
				case 0:
					alert("收藏的文章不存在\n页面将会重新载入");
					window.location.reload();
					break;
				case 1:
					$(".article-collection .item[data-id=" + id + "]").remove();
					break;
				default:
					alert("删除失败");
			}
		}).fail(function() {
			alert("删除失败");
		});
	}
}
</script>
<title>${user.name}的收藏</title>
</head>
<body>
<div id="main">
	<div class="nav-bar col-md-2 col-md-offset-1">
		<div class="nav nav-pills nav-stacked">
			<li role="presentation" class="active"><a href="javascript:void(0)">文章</a></li>
		</div>
	</div>
	<div class="article-collection col-md-4 col-md-offset-1">
		<c:forEach items="${articleCollection}" var="ac">
			<div class="item well" data-id="${ac.id}">
				<div class="operation-bar">
					<a href="javascript:removeCollection(${ac.id}, ${ac.aid})" title="删除该收藏" style="color: #d9534f;"><span class="glyphicon glyphicon-minus-sign"></span></a>
				</div>
				<blockquote>
					<h4><a href="<%=basepath%>/article/${ac.aid}" target="_blank">${ac.title}</a></h4>
					<footer>收藏于&nbsp;<b>${ac.create_date}</b></footer>
				</blockquote>
				<div class="view-zone">
					<a href="javascript:toggleDetails(${ac.id})" title="展开" style="color: #000;"><span class="glyphicon glyphicon-chevron-down"></span></a>
					<a href="javascript:toggleDetails(${ac.id})" title="收起" style="color: #000;" class="h"><span class="glyphicon glyphicon-chevron-up"></span></a>
				</div>
				<div class="details">
					<div class="info">
						<span>文章发布日期：<b>${ac.publish_date}</b></span>
						<span>文章作者：<b>${ac.writer_name}</b></span>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							文章简介
						</div>
						<div class="panel-body">
							<c:if test="${empty ac.intro}">
								<span class="empty-intro">暂无简介</span>
							</c:if>
							${ac.intro}
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div class="col-md-3 col-md-offset-1">
		recommendations
	</div>
</div>
</body>
</html>