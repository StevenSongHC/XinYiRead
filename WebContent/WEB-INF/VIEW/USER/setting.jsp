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
<script type="text/javascript"	src="<%=basepath%>/js/jquery.form.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("input:radio[name='nav-btn']").change(function() {
		window.location.href="<%=basepath%>/writer/setting";
	});
	
	$("form#photo-form").ajaxForm({
		beforeSerialize: function() {
			$("#upload-progress-bar").html(0).width(0);
			var filePath = $("form#photo-form #photo").val();
			var fileType = filePath.substring(filePath.lastIndexOf("."), filePath.length).toUpperCase();
			if(fileType != ".BMP" && fileType != ".PNG" && fileType != ".GIF" && fileType != ".JPG" && fileType != ".JPEG") {
				BootstrapDialog.show({
					type: BootstrapDialog.TYPE_WARNING,
					message: "请选择图片文件"
				});
				return false;
			}
			$("form#photo-form #fileType").val(fileType);
			$("#upload-progress-bar").addClass("active");
		},
		uploadProgress: function(event, position, total, percentComplete) {
			var percentVal = percentComplete + "%";
			$("#upload-progress-bar").html(percentVal).width(percentVal);
		},
		success: function(json) {
			switch (json.code) {
				case -1:
					BootstrapDialog.show({
						type: BootstrapDialog.TYPE_WRANING,
						message: "无登陆信息"
					});
					break;
				case 0:
					BootstrapDialog.show({
						type: BootstrapDialog.TYPE_DANGER,
						message: "上传新头像失败"
					});
					break;
				case 1:
					// refresh user portrait
					$("#photo-preview").attr("src", "<%=basepath%>/" + json.newPhoto);
					$("#top-bar #user-token img").attr("src", "<%=basepath%>/" + json.newPhoto);
					$("form#photo-form").resetForm();
					BootstrapDialog.show({
						type: BootstrapDialog.TYPE_PRIMARY,
						message: "新头像保存成功！"
					});
					break;
				default:
					BootstrapDialog.show({
						type: BootstrapDialog.TYPE_DANGER,
						message: "未知错误"
					});
			}
			$("#upload-progress-bar").removeClass("active");
		}
	});
});

function submitUpdate() {
	var email = $("input#input-email").val().trim();
	var isEmailShow = $("input#is-email-show:checked").val() == undefined? 0 : 1;
	var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	if (email.length > 0 && !reg.test(email)) {
		BootstrapDialog.show({
			type: BootstrapDialog.TYPE_DANGER,
			message: "邮箱格式非法"
		});
		return;
	}
	
	$.ajax( {
		url: "<%=basepath%>/user/setting/update",
		type: "POST",
		dataType: "JSON",
		data: {
			email: email,
			isEmailShow: isEmailShow
		}
	}).done(function(json) {
		switch (json.status) {
			case -1:
				BootstrapDialog.show({
					type: BootstrapDialog.TYPE_WARNING,
					message: "登陆信息失效"
				});
				break;
			case 1:
				BootstrapDialog.show({
					type: BootstrapDialog.TYPE_SUCCESS,
					message: "保存成功"
				});
				break;
			default:
				BootstrapDialog.show({
					type: BootstrapDialog.TYPE_DANGER,
					message: "保存失效"
				});
		}
	}).fail(function() {
		BootstrapDialog.show({
			type: BootstrapDialog.TYPE_DANGER,
			message: "发生错误"
		});
	});
}
</script>
<title>个人信息设置</title>
</head>
<body>
<div id="main">
	<div class="user-head-wrapper">
		<div class="row">
			<div class="col-md-8">
				<div class="media">
					<a class="pull-left" href="<%=basepath%>/user/i/${user.name}">
						<img id="photo-preview" class="media-object img-rounded" alt="${user.name}的头像" title="${user.name}" src="<%=basepath%>/${user.portrait}">
					</a>
					<div class="media-body">
						<p class="date">注册于${user.joinDate}</p>
						<h3 class="media-heading"><a href="<%=basepath%>/user/i/${user.name}">${user.name}</a></h3>
					</div>
				</div>
			</div>
			<div class="col-md-4">
			<c:if test="${!empty sessionScope.WRITER_SESSION}">
				<div class="btn-group nav-btn" data-toggle="buttons">
					<label class="btn btn-primary btn-lg active">
						<input type="radio" name="nav-btn" checked="checked">基本
					</label>
					<label class="btn btn-primary btn-lg">
						<input type="radio" name="nav-btn">写手
					</label>
				</div>
			</c:if>
			</div>
		</div>
	</div>
	<div id="photo-uploader">
		<form action="<%=basepath%>/ajax/ajaxFormSubmit" id="photo-form" method="post" enctype="multipart/form-data">
			<input type="file" name="uploadFile" id="photo" />
			<input type="hidden" name="type" value="userPortrait" />
			<input type="hidden" name="fileType" id="fileType" />
			<input type="submit" value="上传并保存头像" class="btn btn-default" style="margin-top: 10px;" />
		</form>
		<div class="progress">
		  <div id="upload-progress-bar" class="progress-bar progress-bar-striped" role="progressbar" style="width: 0%">
		    <span></span>
		  </div>
		</div>
	</div>
	<hr>
	<div class="user-info-wrapper">
		<form class="form-horizontal">
			<div class="form-group">
				<label for="input-email" class="col-sm-2 control-label">邮箱</label>
				<div class="col-sm-10">
					<input type="email" class="form-control" id="input-email" placeholder="填入有效的邮箱" value="${user.email}">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						<label>
							<input id="is-email-show" type="checkbox"
							<c:if test="${user.isEmailShow == 1}">
								checked="checked"
							</c:if>
							> 是否设置为他人可见
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-10 col-sm-2">
					<button type="button" class="btn btn-success btn-lg" onclick="javascript:submitUpdate()">保存</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>