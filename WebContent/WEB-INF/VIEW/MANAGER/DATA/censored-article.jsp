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
	$("#censored-article").children("a").addClass("active");
	
	$(".content-item").each(function() {
		var bc = $(this).find(".brief-content").text();
		bc = bc.substr(0,110);
		bc += "<span class='preview-content' title='" + $(this).find(".brief-content").text() + "'>...</span>";
		$(this).find(".brief-content").html("").html(bc);
	});
});

function recensor(aid) {
	if (confirm("确定继续？")) {
		$.ajax( {
			url: "<%=basepath%>/manager/docensor/article",
			type: "POST",
			dataType: "JSON",
			data: {
				aid: aid,
				isPass: 0
			}
		}).done(function(json) {
			switch (json.status) {
				case -1:
					alert("无此权限");
					window.location.href="<%=basepath%>";
					break;
				case 0:
					alert("检索文章失效，请重新尝试");
					break;
				case 1:
					alert("操作成功");
					$(".content-item .action[aid=" + aid + "]").html("<button type='button' class='btn btn-info btn-sm' disabled='disabled'>已移入未审核列表</button>");
					break;
				default:
					alert("通信失败");
			}
			// prevent restore
			$("#hidden-current-article").val("");
		}).fail(function() {
			alert("通信失败");
		});
	}
}
</script>
<div class="content-list" role-id=3>
	<c:forEach items="${articleList}" var="a">
	<div class="content-item">
		<div class="left-wrapper">
			<h4 title="[${a.id}]">
				${a.title}
				<c:choose>
				<c:when test="${a.is_censored == 1}">
					<span class="label label-success">通过</span>
				</c:when>
				<c:otherwise>
					<span class="label label-warning">未通过</span>
				</c:otherwise>
				</c:choose>
			</h4>
			<span class="brief-content">${a.content}</span>
			<span class="submit-date">${a.publish_date}</span>
		</div>
		<div class="right-wrapper">
			<span class="writer-title">
			<c:choose>
			<c:when test="${a.is_writer_show == 1}">
				<a href="<%=basepath%>/writer/i/${a.writer_name}" target=_blank>${a.writer_name}</a>
			</c:when>
			<c:otherwise>
				* 匿名 *
			</c:otherwise>
			</c:choose>
			</span>
			<span class="action" aid="${a.id}">
				<button type="button" class="btn btn-info btn-sm" onclick="javascrip:recensor(${a.id})">重新审核</button>
			</span>
		</div>
		<div style="clear: both;"></div>
	</div>
	</c:forEach>
</div>