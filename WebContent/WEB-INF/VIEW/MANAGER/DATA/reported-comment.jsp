<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {

	/*
	 * parse roleArr into array
	 * display menu item base on roleArr
	 */
	var roleArr = $("#hidden-roles").val();
	roleArr = roleArr.substr(1, roleArr.length-2).split(",");
	$.each(roleArr, function(i, n) {
		$(".nav-menu-item[role-id=" + n + "]").show();
	});
	// active current menu item
	$("#reported-comment").children("a").addClass("active");
	
});

function handleReport(cmtid, isBlock) {
	$.ajax( {
		url: "<%=basepath%>/manager/handleCommentReport",
		type: "POST",
		dataType: "JSON",
		data: {
			cmtid: cmtid,
			isBlock: isBlock
		}
	}).done(function(json) {
		switch (json.status) {
			case -1:
				alert("参数非法");
				break;
			case 0:
				alert("举报的评论不存在！！");
				break;
			case 1:
				// block the comment
				if (isBlock == 1) {
					$(".content-item .action[cmtid=" + cmtid + "]").html("<button type='button' class='btn btn-success' disabled='disabled'>该评论已被屏蔽</button>");
				}
				// ingore the report
				else {
					$(".content-item .action[cmtid=" + cmtid + "]").html("<button type='button' class='btn btn-warning' disabled='disabled'>该举报已被忽略</button>");
				}
				break;
			default:
				alert("通信失败");
		}
	}).fail(function() {
		alert("通信失败");
	});
}
</script>
<div class="content-list" role-id=4>
	<c:forEach items="${reportList}" var="r">
	<div class="content-item">
		<h4>
			${r.submit_date}
			&nbsp;&nbsp;&nbsp;
			<small>
				<a href="<%=basepath%>/user/i/${r.reporter_username}" target="_blank">${r.reporter_username}</a>
				举报了该评论
				（<a href="<%=basepath%>/article/${r.articleid}#comments" target="_blank">原文</a>）
			</small>
		</h4>
		<hr />
		<div class="left-wrapper">
			<span class="publisher-info">
				发布者：<a href="<%=basepath%>/user/i/${r.publisher_username}" target="_blank">${r.publisher_username}</a>
				<c:if test="${r.is_anonymous == 1}">
					（匿名）
				</c:if>
			</span>
			<span class="brief-content">
				${r.word}
			</span>
		</div>
		<div class="right-wrapper">
			<span class="action" cmtid="${r.cmtid}">
				<button type="button" class="btn btn-success btn-sm" onclick="javascrip:handleReport(${r.cmtid},1)">删除（隐藏）该评论</button>
				<button type="button" class="btn btn-warning btn-sm" onclick="javascrip:handleReport(${r.cmtid},0)">保留该评论</button>
			</span>
		</div>
		<div style="clear: both;"></div>
	</div>
	</c:forEach>
</div>