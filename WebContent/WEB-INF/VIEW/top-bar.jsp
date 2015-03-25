<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
	$("#top-bar").keyup(function(e) {
		if (e.keyCode == 13) {
			login();
		}
	});
});

function login() {
	if ($("#top-bar #login-account").val().trim() === "") {
		alert("用户名或邮箱不得为空");
		$("#top-bar #login-account").focus();
		return;
	}
	if ($("#top-bar #login-password").val().trim() === "") {
		alert("登陆密码不得为空");
		$("#top-bar #login-password").focus();
		return;
	}
	$.ajax( {
		url: "<%=basepath%>/login/do",
		type: "POST",
		dataType: "JSON",
		data: {
			account: $("#top-bar #login-account").val().trim(),
			password: $("#top-bar #login-password").val(),
			rememberme: $("#top-bar #rememberme:checked").val()
		}
	}).done(function(json) {
		switch (json.code) {
			case -1:
				alert("密码错误");
				$("#top-bar #login-password").focus();
				break;
			case 0:
				alert("用户不存在");
				$("#top-bar #login-account").focus();
				break;
			case 1:
				window.location.reload();
				break
			default:
				alert("登陆时发生未知错误");
		}
	}).fail(function() {
		alert("failed to login");
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		alert("failed to login");
	});
}
function logout() {
	$.ajax( {
		async: false,
		url: "<%=basepath%>/logout",
		type: "POST",
		dataType: "JSON",
	}).done(function(json) {
	}).fail(function() {
		alert("failed to logout");
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		alert("failed to logout");
	});
	window.location.reload();
}
</script>
<style type="text/css">
body {
	margin-top: 37px;
}
#top-bar {
	position: absolute;
	top: 2px;
	padding-right: 35px;
	width: 100%;
}
#top-bar div {
	display: inline-block;
}
.right-wrapper {
	float: right;
}
</style>
<div id="top-bar">
	<div class="right-wrapper">
	<c:choose>
	<c:when test="${empty sessionScope.USER_SESSION}">
		<div>
			<input type="text" class="form-control" id="login-account" placeholder="输入用户名或邮箱">
		</div>
		<div>	
			<input type="password" class="form-control" id="login-password" placeholder="登陆密码">
		</div>
		<div>
			<label>
				<input type="checkbox" id="rememberme"> 记住我
			</label>
		</div>
		<button id="login-button" class="btn btn-default" onclick="login()">登陆</button>
		|
		<a href="<%=basepath%>/join" class="btn btn-default">注册</a>
	</c:when>
	<c:otherwise>
		<div>
			${sessionScope.USER_SESSION.name}
		</div>
		<div>
			<button class="btn btn-default" onclick="logout()">登出</button>
		</div>
	</c:otherwise>
	</c:choose>
	</div>
</div>