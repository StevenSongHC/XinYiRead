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
	var menu = $("#hidden-menu").val();
	var submenu = $("#hidden-submenu").val();
	/**$("#menu-nav ul>li[menu='" + menu + "']").addClass("active");
	$("#submenu-nav ul[parent='" + menu + "']").show();
	$("#submenu-nav ul[parent='" + menu + "']>li[submenu='" + submenu + "']").addClass("active");8**/
	
	$("#main-content").load("<%=basepath%>/manager/load/" + menu + "_" + submenu);
});
</script>
<link rel="stylesheet" href="<%=basepath%>/css/manager-style.css" type="text/css" />
<title>管理页面</title>
</head>
<body>
<hr>
<input id="hidden-menu" type="hidden" value="${menu}">
<input id="hidden-submenu" type="hidden" value="${submenu}">
<div id="menu-nav">
	<ul class="nav nav-tabs">
		<li menu="user" role="presentation"><a href="<%=basepath%>/manager?menu=user&submenu=list">用户</a></li>
		<li menu="article" role="presentation"><a href="<%=basepath%>/manager?menu=article&submenu=list">文章</a></li>
		<li menu="novel" role="presentation" class="disabled"><a href="">小说</a></li>
		<li menu="message" role="presentation"><a href="<%=basepath%>/manager?menu=message&submenu=list">消息</a></li>
		<li menu="comment" role="presentation"><a href="<%=basepath%>/manager?menu=comment&submenu=list">评论</a></li>
		<li menu="permission" role="presentation"><a href="<%=basepath%>/manager?menu=permission&submenu=user_role">权限</a></li>
		<li menu="more" role="presentation"><a href="<%=basepath%>/manager?menu=more&submenu=modify_password">更多</a></li>
	</ul>
</div>
<div id="container">
	<div id="submenu-nav">
		<ul parent="user" class="nav nav-pills nav-stacked">
			<li submenu="list" role="presentation"><a href="<%=basepath%>/manager?menu=user&submenu=list">列表</a></li>
			<li submenu="writer" role="presentation"><a href="<%=basepath%>/manager?menu=user&submenu=writer">作者</a></li>
			<li submenu="history" role="presentation"><a href="<%=basepath%>/manager?menu=user&submenu=history">历史</a></li>
			<li submenu="bookmark" role="presentation"><a href="<%=basepath%>/manager?menu=user&submenu=bookmark">书签</a></li>
			<li submenu="collection" role="presentation"><a href="<%=basepath%>/manager?menu=user&submenu=collection">收藏</a></li>
		</ul>
		<ul parent="article" class="nav nav-pills nav-stacked">
			<li submenu="list" role="presentation"><a href="<%=basepath%>/manager?menu=article&submenu=list">列表</a></li>
			<li submenu="category" role="presentation"><a href="<%=basepath%>/manager?menu=article&submenu=category">分类</a></li>
			<li submenu="tag" role="presentation"><a href="<%=basepath%>/manager?menu=article&submenu=tag">标签</a></li>
		</ul>
		<ul parent="message" class="nav nav-pills nav-stacked">
			<li submenu="list" role="presentation"><a href="<%=basepath%>/manager?menu=message&submenu=list">全部</a></li>
		</ul>
		<ul parent="comment" class="nav nav-pills nav-stacked">
			<li submenu="list" role="presentation"><a href="<%=basepath%>/manager?menu=comment&submenu=list">列表</a></li>
			<li submenu="unhandled-list" role="presentation"><a href="<%=basepath%>/manager?menu=comment&submenu=unhandled_list">未处理的举报</a></li>
			<li submenu="handled-list" role="presentation"><a href="<%=basepath%>/manager?menu=acomment&submenu=handled_list">已处理的举报</a></li>
		</ul>
		<ul parent="permission" class="nav nav-pills nav-stacked">
			<li submenu="user-role" role="presentation"><a href="<%=basepath%>/manager?menu=permission&submenu=user_role">用户角色</a></li>
			<li submenu="role-privilege" role="presentation"><a href="<%=basepath%>/manager?menu=permission&submenu=role_privilege">角色权限</a></li>
			<li submenu="role-list" role="presentation"><a href="<%=basepath%>/manager?menu=permission&submenu=role_list">角色列表</a></li>
			<li submenu="privilege-list" role="presentation"><a href="<%=basepath%>/manager?menu=permission&submenu=privilege_list">权限列表</a></li>
		</ul>
		<ul parent="more" class="nav nav-pills nav-stacked">
			<li submenu="modify-password" role="presentation"><a href="<%=basepath%>/manager?menu=more&submenu=modify_password">修改用户密码</a></li>
		</ul>
	</div>
	<div id="main-content">
	
	</div>
</div>
</body>
</html>