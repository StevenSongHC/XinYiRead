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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/setting-style.css">
<script type="text/javascript">
$(document).ready(function() {
	$("input:radio[name='nav-btn']").change(function() {
		window.location.href="<%=basepath%>/user/setting";
	});
});
</script>
<title>个人信息设置</title>
</head>
<body>
<div id="main">
	<div class="user-head-wrapper">
		<div class="row">
			<div class="col-md-8">
				<div class="media">
					<a class="pull-left" href="<%=basepath%>/writer/i/${writer.penName}">
						<img class="media-object img-rounded" alt="${writer.penName}的头像" title="${writer.penName}" src="<%=basepath%>/${writer.user.portrait}">
					</a>
					<div class="media-body">
						<p class="date">注册于${writer.user.joinDate}</p>
						<h3 class="media-heading"><a href="<%=basepath%>/writer/i/${writer.penName}">${writer.penName}</a></h3>
						<p class="date">
							<address>
								<abbr title="Contact">联系方式：</address></abbr>${writer.contact}
							</address>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
			<c:if test="${!empty sessionScope.WRITER_SESSION}">
				<div class="btn-group nav-btn" data-toggle="buttons">
					<label class="btn btn-primary btn-lg">
						<input type="radio" name="nav-btn">基本
					</label>
					<label class="btn btn-primary btn-lg active">
						<input type="radio" name="nav-btn" checked="checked">写手
					</label>
				</div>
			</c:if>
			</div>
		</div>
	</div>
	<hr>
</div>
</body>
</html>