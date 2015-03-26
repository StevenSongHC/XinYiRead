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
<script type="text/javascript">
$(document).ready(function() {
	$("#load-more").click(function() {
		$(this).slideUp();
		$("#writer-form").slideDown();
	});
	$("#load-terms").click(function() {
		

		if ($("#form-container #input-username").val().trim() !== "") {
			var legalNameReg = /^[a-zA-Z]{1}[a-zA-Z0-9_]{3,14}$/;
			if (legalNameReg.test($("#form-container #input-username").val().trim())) {
				if ($("#form-container #input-password").val() !== "") {
					if ($("#form-container #input-password").val().length > 5) {
						if ($("#form-container #input-password").val() === $("#form-container #input-repeat-password").val()) {
							if (isUsernameExisted()) {
								alert("existed username");
								$("#form-container #input-username").focus();
								return;
							}
							// 邮箱和笔名都在确认不为空后才进行更近的一步验证
							if ($("#form-container #input-email").val().trim() !== "") {
								if (validateEmail()) {
									if (isEmailExisted()) {
										alert("existed email");
										$("#form-container #input-email").focus();
										return;
									}
								}
								else {
									alert("illegal email");
									$("#form-container #input-email").focus();
									return;
								}
							}
							if ($("#form-container #input-pen-name").val().trim() !== "") {
								if (legalNameReg.test($("#form-container #input-pen-name").val().trim())) {
									if (isPenNameExisted()) {
										alert("existed pen name");
										$("#form-container #pen-name").focus();
										return;
									}
								}
								else {
									alert("illegal pen name");
									$("#form-container #pen-name").focus();
									return;
								}
							}
							
							BootstrapDialog.show({
								type: BootstrapDialog.TYPE_INFO,
								title: "服务条款",
								message: $("<div></div>").load("<%=basepath%>/getTerms"),
								buttons:[{
									label: "我同意并注册",
									cssClass: "btn-primary",
									action: function() {
										submitForm();
									}
								},{
									label: "取消",
									action: function(dialog) {
										dialog.close();
									}
								}]
							});
							
						}
						else {
							alert("different password");
							$("#form-container #input-repeat-password").focus();
							return;
						}
					}
					else {
						alert("short password");
						$("#form-container #input-password").focus();
						return;
					}
				}
				else {
					alert("empty password");
					$("#form-container #input-password").focus();
					return;
				}
			}
			else {
				alert("illegal username");
				$("#form-container #input-username").focus();
				return;
			}
		}
		else {
			alert("empty username");
			$("#form-container #input-username").focus();
			return;
		}
	});
	
	$("#input-pen-name").keyup(function() {
		if ($(this).val().trim() !== "") {
			$("#load-terms").html("提交");
		}
		else
			$("#load-terms").html("就先提交这些吧");
	});
	
	// bind "enter" pressed event
	var pressAmount = 0;
	$("#form-container").keydown(function(e) {
		if (e.keyCode == 13) {
			pressAmount++;
			if (pressAmount === 1)
				$("#load-more").click();
			else
				$("#load-terms").click();
		}
	});
});

function validateEmail() {
	var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	return reg.test($("#form-container #input-email").val().trim());
}

function isUsernameExisted() {
	var isExisted;
	$.ajax( {
		async: false,
		url: "<%=basepath%>/ajax/checkUsername",
		type: "POST",
		dataType: "JSON",
		data: {
			username: $("#form-container #input-username").val().trim()
		}
	}).done(function(json) {
		isExisted = json.isExisted;
	}).fail(function() {
		isExisted = true;
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		isExisted = true;
	});
	return isExisted;
};

function isEmailExisted() {
	var isExisted;
	$.ajax( {
		async: false,
		url: "<%=basepath%>/ajax/checkEmail",
		type: "POST",
		dataType: "JSON",
		data: {
			email: $("#form-container #input-email").val().trim()
		}
	}).done(function(json) {
		isExisted = json.isExisted;
	}).fail(function() {
		isExisted = true;
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		isExisted = true;
	});
	return isExisted;
};

function isPenNameExisted() {
	var isExisted;
	$.ajax( {
		async: false,
		url: "<%=basepath%>/ajax/checkPenName",
		type: "POST",
		dataType: "JSON",
		data: {
			penName: $("#form-container #input-pen-name").val().trim()
		}
	}).done(function(json) {
		isExisted = json.isExisted;
	}).fail(function() {
		isExisted = true;
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		isExisted = true;
	});
	return isExisted;
};

function submitForm() {
	$.ajax( {
		url: "<%=basepath%>/join/do",
		type: "POST",
		dataType: "JSON",
		data: {
			name: $("#form-container #input-username").val().trim(),
			password: $("#form-container #input-password").val(),
			email: $("#form-container #input-email").val().trim(),
			penName: $("#form-container #input-pen-name").val().trim()
		}
	}).done(function(json) {
		switch (json.code) {
			case -1:
				alert("在注册作者信息时出错，可以以后再做尝试");
				break;
			case 0:
				alert("注册失败，请再尝试");
				break;
			case 1:
				alert("Congratulations!!!");
				window.location.href="<%=basepath%>/user/i/" + json.username;
				break;
			default:
				alert("通信失败");
		}
	}).fail(function() {
		alert("FAIL");
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		$("body").append(XMLHttpRequest.responseText);
	});
}
</script>
<link rel="stylesheet" href="<%=basepath%>/css/join.css" type="text/css" />
<title>注册</title>
</head>
<body>
<div id="form-container">
	<div id="user-form">
		<a href="<%=basepath%>/login" class="btn btn-lg" role="button">使用已有账号登陆</a>
		<div class="input-group">
			<span class="input-group-addon"><strong>* 用户名</strong></span>
			<input id="input-username" type="text" class="form-control" placeholder="username">
		</div>
		<div class="input-group">
			<span class="input-group-addon"><strong>* 密码</strong></span>
			<input id="input-password" type="password" class="form-control" placeholder="不小于6位">
		</div>
		<div class="input-group">
			<span class="input-group-addon"><strong>* 重复密码</strong></span>
			<input id="input-repeat-password" type="password" class="form-control" placeholder="······">
		</div>
		<div class="input-group">
			<span class="input-group-addon"><strong>邮箱</strong></span>
			<input id="input-email" type="text" class="form-control" placeholder="@@@@@">
		</div>
		<button id="load-more" class="btn btn-default btn-sm btn-block"><span class="glyphicon glyphicon-chevron-down"></span></button>
	</div>
	<div id="writer-form">
		<div class="well well-sm">每人都能成为一名作者</div>
		<div class="input-group">
			<span class="input-group-addon"><strong>笔名</strong></span>
			<input id="input-pen-name" type="text" class="form-control" placeholder="pen name">
		</div>
		<button id="load-terms" class="btn btn-default btn-block">就先提交这些吧</button>
	</div>
</div>
</body>
</html>