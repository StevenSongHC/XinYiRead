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
<script type="text/javascript"	src="<%=basepath%>/js/jquery.cookie.js"></script>
<link rel="shortcut icon" href="<%=basepath%>/images/favicon.ico" />
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/article-style.css">
<script type="text/javascript">
$(document).ready(function() {
	// fill comment input box by related cookie
	if ($.cookie("ARTICLE_${article.id}_" + $.cookie("USER_COOKIE").split(",")[1] + "_COMMENT_WORD")) {
		$("#input-comment").val($.cookie("ARTICLE_${article.id}_" + $.cookie("USER_COOKIE").split(",")[1] + "_COMMENT_WORD"));
	}
	
	// hover effect for report-comment link
	$(".comment-list .report-comment a").hover(function() {
		$(this).parent().prev().animate({borderWidth: "2px"}, "fast");
	}, function() {
		$(this).parent().prev().animate({borderWidth: "0"}, "fast");
	});
});

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
				goLogin();
				break;
			case 0:
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
		alert("评价失败！");
	});
}

function goLogin() {
	$("body").animate({scrollTop: $("#top-bar").offset().top}, 500);
	$("#top-bar #login-account").focus();
}

function toggleAnonymous(e) {
	var daddy = e.parent();
	$(daddy).children(":not(.yep)").addClass("yep");
	$(e).removeClass("yep");
	// display warning message when anonoymous comment is enabled
	if ($(daddy).children(".yep").attr("is-anonymous") == 1)
		$("#warning-message").show();
	else
		$("#warning-message").hide();
}

function submitComment() {
	if ($("#input-comment").val().trim().length > 5) {
		$.ajax( {
			url: "<%=basepath%>/article/comment_article",
			type: "POST",
			dataType: "JSON",
			data: {
				aid: ${article.id},
				word: $("#input-comment").val().trim(),
				isAnonymous: $("#anonymous-option>span.yep").attr("is-anonymous")
			}
		}).done(function(json) {
			switch (json.status) {
				case -1:
					alert("请先登录再进行评论！");
					goLogin();
					storeCommentToCookie();
					break;
				case 0:
					alert("评论的文章不存在！？");
					window.location.reload();
					break;
				case 1:
					alert("感谢您参与评论");
					removeCommentCookie();
					<%-- window.location.href = "<%=basepath%>/article/${article.id}/#comment"; --%>
					window.location.reload();
					break;
				default:
					alert("评论失败！您所输入的评论仍会保存30天，不用担心 :)");
					storeCommentToCookie();
			}
		}).fail(function() {
			alert("评论失败！您所输入的评论仍会保存30天，不用担心 :)");
			storeCommentToCookie();
		});
	}
	else {
		alert("字数太少！！！");
		$("#input-comment").focus();
	}
}

function storeCommentToCookie() {
	// last 30 days
	$.cookie("ARTICLE_${article.id}_" + $.cookie("USER_COOKIE").split(",")[1] + "_COMMENT_WORD", $("#input-comment").val().trim(), {expires: 30, path: "/"});
}
function removeCommentCookie() {
	$.removeCookie("ARTICLE_${article.id}_" + $.cookie("USER_COOKIE").split(",")[1] + "_COMMENT_WORD", {path: "/"});
}

function reportComment(cmtid) {
	$.ajax( {
		url: "<%=basepath%>/article/report_comment",
		type: "POST",
		dataType: "JSON",
		data: {
			cmtid: cmtid
		}
	}).done(function(json) {
		switch (json.status) {
			case -2:
				alert("该评论已被举报过，非常感谢:)");
				break;
			case -1:
				alert("请先登录再举报\n若右上角显示你已登录，则有可能登陆信息已过期，请重新刷新页面再登陆");
				goLogin();
				break;
			case 0:
				alert("你所举报的评论不存在？！");
				break;
			case 1:
				alert("你的举报已提交。在举报被处理前，该评论仍会显示，请耐心等待。感谢对新意阅读的支持 ;P");
				break;
			default:
				alert("举报失败！");
		}
	}).fail(function() {
		alert("举报失败！");
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
<div id="comments" class="comment panel panel-default">
	<div class="panel-heading">
		<h2 class="panel-title"><b>评论</b></h2>
	</div>
	<div class="panel-body">
		<div id="comment">
		<c:choose>
		<c:when test="${not empty requestScope.commentList}">
			<div class="comment-list">
			<c:forEach items="${commentList}" var="cmt">
				<div class="item">
				<c:choose>
				<c:when test="${cmt.is_anonymous == 0}">
					<div class="media">
						<a class="pull-left" href="<%=basepath%>/user/i/${cmt.username}" target="_blank">
							<img class="media-object img-rounded" alt="${cmt.username}" title="${cmt.username}" src="<%=basepath%>/${cmt.user_portrait}">
						</a>
						<div class="media-body">
							<h6 class="media-heading">
								<span class="username">
									${cmt.username}
									<c:if test="${cmt.uid == requestScope.article.writer_uid}">
										<span class="label label-default">作者</span>
									</c:if>
								</span>
								 <b>·</b> <span class="submit-date">${cmt.submit_date}</span></h6>
							<p>${cmt.word}<p>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="media">
						<a class="pull-left" href="javascript:void(0)">
							<img class="media-object img-rounded" alt="anonymous" title="匿名用户" src="<%=basepath%>/images/portrait/anonymous.png">
						</a>
						<div class="media-body">
							<h6 class="media-heading"><span class="username"><u>*匿名用户*</u></span> <b>·</b> <span class="submit-date">${cmt.submit_date}</span></h6>
							<p>${cmt.word}<p>
						</div>
					</div>
				</c:otherwise>
				</c:choose>
				</div>
				<c:if test="${not empty sessionScope.USER_SESSION}">
				<div class="report-comment">
					<a href="javascript:reportComment(${cmt.id})">举报</a>
				</div>
				</c:if>
			</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<div class="empty-comment">
				暂无评论
			</div>
		</c:otherwise>
		</c:choose>
		</div>
		<c:choose>
		<c:when test="${empty sessionScope.USER_SESSION}">
			<div class="comment-mask">
				<p><a href="javascript:goLogin()">登录</a>后才能发表评论</p>
				<p>没有账号要先<a href="<%=basepath%>/join" target="_blank">注册</a></p>
				<p>登陆后可<u>匿名评论</u></p>
			</div>
		</c:when>
		<c:otherwise>
			<textarea id="input-comment" class="form-control" rows="6" placeholder="在此输入评论"></textarea>
			<div class="submit-block">
				<span id="warning-message" class="alert alert-warning" role="alert">匿名发布后，管理员仍能查看评论发布者的信息，所以你懂的啦</span>
				<div id="anonymous-option">
					<span is-anonymous=0 class="glyphicon glyphicon-unchecked yep" onclick="javascript:toggleAnonymous($(this))"></span>
					<span is-anonymous=1 class="glyphicon glyphicon-check" onclick="javascript:toggleAnonymous($(this))"></span>
					匿名
				</div>
				<button type="button" class="btn btn-default" onclick="javascript:submitComment()">发表评论</button>
			</div>
		</c:otherwise>
		</c:choose>
	</div>
</div>
<div style="clear: both;"></div>
</body>
</html>