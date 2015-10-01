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
<link rel="stylesheet" type="text/css" href="<%=basepath%>/css/writer-homepage.css">
<script type="text/javascript">
$(function() {
	$("[data-toggle='tooltip']").tooltip();
});

function commendWriter() {
	$.ajax( {
		url: "<%=basepath%>/writer/commend_writer",
		type: "POST",
		dataType: "JSON",
		data: {
			wid: ${writer.id}
		}
	}).done(function(json) {
		switch (json.status) {
			case -1:
				alert("请先登录再进行评价");
				$("body").animate({scrollTop: $("#top-bar").offset().top}, 500);
				$("#top-bar #login-account").focus();
				break;
			case 0:
				alert("评价的作者不存在！？");
				window.location.reload();
				break;
			case 1:
				alert("感谢您的赞 ;)");
				window.location.reload();
				break;
			case 2:
				alert("您已赞过该作者了哦");
				break;
			default:
				alert("评价失败！");
		}
	}).fail(function() {
		alert("评价失败");
	});
}
</script>
<title>${writer.penName}的主页 | 新意阅读</title>
</head>
<body>
<div id="main">
	<div class="writer-info">
		<div class="left-wrapper">
				<img src="<%=basepath%>/${writer.user.portrait}" class="img-rounded" />
				<button type="button" class="btn btn-success" onclick="javascript:commendWriter()"><span class="glyphicon glyphicon-thumbs-up"></span> 给作者点个赞 <span class="badge">${writer.likeCount}</span></button>
		</div>
		<div class="right-wrapper">
			<span class="pen-name">${writer.penName}</span>
			<span class="join-date">于&nbsp;${writer.user.joinDate}加入</span>
		</div>
	</div>
	<div class="writer-activity">
		<div class="panel-group" id="accordion">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#current-project">
							当前项目
						</a>
					</h4>
				</div>
				<div id="current-project" class="panel-collapse collapse">
					<div class="panel-body">
						<c:choose>
							<c:when test="${empty currentProject}">
								<span class="empty">暂无数据</span>
							</c:when>
							<c:otherwise>
								<h3 data-toggle="tooltip" data-placement="left" title="当前项目代表作者正在努力完成中的文章，故仍无法与读者见面">${currentProject.title}</h3>
								<div class="well">
									<c:if test="${empty currentProject.intro}">
										<span class="empty">暂无简介</span>
									</c:if>
									${currentProject.intro}
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a data-toggle="collapse" data-parent="#accordion" href="#published-article">
							发表的文章
						</a>
					</h4>
				</div>
				<div id="published-article" class="panel-collapse collapse in">
					<div class="panel-body">
						<c:choose>
							<c:when test="${empty articleList}">
								<span class="empty">暂无数据</span>
							</c:when>
							<c:otherwise>
								<c:forEach items="${articleList}" var="a">
									<div class="item">
										<a href="<%=basepath%>/article/${a.id}" target="_blank">${a.title}</a>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>