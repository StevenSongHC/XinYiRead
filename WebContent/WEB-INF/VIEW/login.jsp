<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="include.jsp" flush="true" />
<script type="text/javascript">
$(document).ready(function() {
	$("#form-container").keydown(function(e) {
		if (e.keyCode == 13) {
			login();
		}
	});
});

function login() {
	if ($("#login-account").val().trim() === "") {
		alert("用户名或邮箱不得为空");
		$("#login-account").focus();
		return;
	}
	if ($("#login-password").val().trim() === "") {
		alert("登陆密码不得为空");
		$("#login-password").focus();
		return;
	}
	$.ajax( {
		url: "<%=basepath%>/login/do",
		type: "POST",
		dataType: "JSON",
		data: {
			account: $("#login-account").val().trim(),
			password: $("#login-password").val(),
			rememberme: $("#rememberme:checked").val()
		}
	}).done(function(json) {
		switch (json.code) {
			case -1:
				alert("密码错误");
				$("#login-password").focus();
				break;
			case 0:
				alert("用户不存在");
				$("#login-account").focus();
				break;
			case 1:
				window.location.href="<%=basepath%>";
				break
			default:
				alert("登陆时发生未知错误");
		}
	}).fail(function() {
		alert("failed to login");
	});
}
</script>
<link rel="stylesheet" href="<%=basepath%>/css/login.css" type="text/css" />
<title>用户登陆</title>
</head>
<body>
<div id="form-container">
	<div class="input-group">
		<span class="input-group-addon"><strong>用户名或邮箱</strong></span>
		<input id="login-account" type="text" class="form-control" placeholder="username or email">
	</div>
	<div class="input-group">
		<span class="input-group-addon"><strong>密码</strong></span>
		<input id="login-password" type="password" class="form-control" placeholder="......">
	</div>
	<div class="check-option">
		<label>
			<input type="checkbox" id="rememberme"> 记住我
		</label>
	</div>
	<button id="login-button" class="btn btn-default" onclick="login()">登陆</button>
	<a href="<%=basepath%>/join">注册新账号</a>
</div>
</body>
</html>