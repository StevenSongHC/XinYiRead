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
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-tabdrop.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/writer-index.css">
<script type="text/javascript">
$(function() {
	$('.nav-pills, .nav-tabs').tabdrop();
	var ic = ${incompletedCount};
	var uc = ${uncheckedCount};
	var cc = ${checkedCount};
	var fc = ${failedCount};
	var order = ic > 0 ? 1 : uc > 0 ? 2 : cc > 0 ? 3 : fc > 0 ? 4 : 1;
	$("#list-sort>li[order='" + order + "']").addClass("active");
	$("#list-content>div[order='" + order + "']").addClass("active");
});
</script>
<title>我的写作空间</title>
</head>
<body>
<div id="main">
	<div class="header-link">
		<a href="<%=basepath%>/writer/i/${writer.penName}" class="btn btn-default btn-lg">我的写手主页&nbsp;<span class="glyphicon glyphicon-log-in"></span></a>
		<a href="<%=basepath%>/article/draft/new" class="btn btn-default btn-lg">新文章&nbsp;<span class="glyphicon glyphicon-edit"></span></a>
	</div>
	<hr>
	<div class="content-container">
		<ul class="nav nav-pills" id="list-sort">
			<li order="1" role="presentation"><a href="#incompleted" data-toggle="tab">写作中</a></li>
			<li order="2" role="presentation"><a href="#unchecked" data-toggle="tab">待审核</a></li>
			<li order="3" role="presentation"><a href="#checked" data-toggle="tab">已上线</a></li>
			<li order="4" role="presentation"><a href="#failed" data-toggle="tab">未通过审核</a></li>
		</ul>
		<div class="tab-content" id="list-content">
			<hr>
			<div order="1" class="tab-pane" id="incompleted">
				<c:choose>
					<c:when test="${empty incompletedList}">
						<div class="empty-list">暂无记录</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${incompletedList}" var="a">
							<div class="item">
								<a href="<%=basepath%>/article/draft/${a.id}" style="color: #333;"><b>${a.title}</b></a><span class="datetime">最后修改于&nbsp;${a.publish_date}</span>
							</div>
							<hr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div order="2" class="tab-pane" id="unchecked">
				<c:choose>
					<c:when test="${empty uncheckedList}">
						<div class="empty-list">暂无记录</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${uncheckedList}" var="a">
							<div class="item">
								<a href="<%=basepath%>/article/draft/${a.id}"><b>${a.title}</b></a><span class="datetime">提交于&nbsp;${a.publish_date}</span>
							</div>
							<hr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div order="3" class="tab-pane" id="checked">
				<c:choose>
					<c:when test="${empty checkedList}">
						<div class="empty-list">暂无记录</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${checkedList}" var="a">
							<div class="item">
								<a href="<%=basepath%>/article/${a.id}" style="color: #ff5c00;" target="_blank"><b>${a.title}</b></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=basepath%>/article/draft/${a.id}"><span class="glyphicon glyphicon-pencil"></span></a><span class="datetime">通过于&nbsp;${a.publish_date}</span>
							</div>
							<hr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div order="4" class="tab-pane" id="failed">
				<c:choose>
					<c:when test="${empty failedList}">
						<div class="empty-list">暂无记录</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${failedList}" var="a">
							<div class="item">
								<a href="<%=basepath%>/article/draft/${a.id}"><b>${a.title}</b></a><span class="datetime">审核于&nbsp;${a.publish_date}</span>
							</div>
							<hr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
</body>
</html>