<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function() {
	
	// unlock article locker b4 leave this page if any article censorship opened
	// only work normally on Chrome, refresh doesn't work on Firefox, and IE such pain in the arse
	window.onbeforeunload = function() {
		restoreArticleLocker();
	};
	
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
	$("#uncensored-article").children("a").addClass("active");
	
	$(".content-item").each(function() {
		var bc = $(this).find(".brief-content").text();
		bc = bc.substr(0,110);
		bc += "<span class='preview-content' title='" + $(this).find(".brief-content").text() + "'>...</span>";
		$(this).find(".brief-content").html("").html(bc);
	});
});

function startCensor(aid) {
	$.ajax( {
		url: "<%=basepath%>/manager/precensor/article",
		type: "POST",
		dataType: "JSON",
		data: {
			aid: aid
		}
	}).done(function(json) {
		switch (json.code) {
			case -3:
				alert("无此权限");
				window.location.href="<%=basepath%>";
				break;
			case -2:
				$(".content-item .action[aid=" + aid + "]").html("<button type='button' class='btn btn-default btn-lg' disabled='disabled'>已上锁</button>");
				alert("该文章已被上锁");
				break;
			case -1:
				alert("请重新登陆");
				window.location.href="<%=basepath%>/login";
				break;
			case 0:
				alert("检索文章失效，请重新尝试");
				break;
			case 1:
				$("#hidden-current-article").val(aid);
				openCensorTab(aid);
				break;
			case 2:
				alert("该文章已被审核");
				$(".content-item .action[aid=" + aid + "]").html("<button type='button' class='btn btn-info btn-lg' disabled='disabled'>" + json.result + "审核</button>");
				break;
			default:
				alert("通信失败");
		}
	}).fail(function() {
		alert("通信失败");
	});
}
function openCensorTab(aid) {
	
	// main dialog
	BootstrapDialog.show({
		size: BootstrapDialog.SIZE_LARGE,
        title: '审核文章',
        message: $("<div></div>").load("<%=basepath%>/manager/censorship/article/" + aid),
        closable: false,
        buttons: [{
            label: '通过',
            cssClass: 'btn-success',
            action: function(dialogRef){
                doCensor(aid, 1);
                dialogRef.close();
            }
        }, {
            label: '不通过',
            cssClass: 'btn-warning',
            action: function(dialogRef){
                doCensor(aid, -1);
                dialogRef.close();
            }
        }, {
            label: '取消',
            action: function(dialogRef){
            	restoreArticleLocker(aid);
                dialogRef.close();
            }
        }]
    });
	
	var msg = "";
	msg += "<p>";
	msg += "各位大哥大姐大爷大婶，小弟能力有限，所以请不要使用非最【较】新的Chrome浏览器（不懂百度之），包括各种如360浏览器等chromium内核的浏览器来审核文章。";
	msg += "要是打开了了也请一定要完成审核，‘通过’、‘不通过’或者‘取消’都行。";
	msg += "<b>不要在打开了审核框的情况下进行关闭或刷新本页面等作死行为（好吧，我死），因为这会造成未完成正常审核流程文章的‘锁死’";
	msg += "（不做锁死功能更简单，相信我，你不会想看到在你给你认为不通过的文章‘判死刑’后，发现它竟然复活了），";
	msg += "就是无法再正常打开那个文章的审核页面了（当然除了超级管理员）。</b>";
	msg += "当然要是你跟我一样机智地用Chrome，随你玩！";
	msg += "</p>";
	msg += "<p style='color: #f00;font-weight: bold;'>当然单你看到这些字时，游戏已经开始了。 Just Do Your Job!</p>";
	// kindly warning dialog
	BootstrapDialog.show({
		type: BootstrapDialog.TYPE_WARNING,
        title: 'WAARNING',
        message: msg
    });
	
}
function doCensor(aid, isPass) {
	$.ajax( {
		url: "<%=basepath%>/manager/docensor/article",
		type: "POST",
		dataType: "JSON",
		data: {
			aid: aid,
			isPass: isPass
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
				var res = isPass == 1 ? "通过" : "未通过";
				$(".content-item .action[aid=" + aid + "]").html("<button type='button' class='btn btn-info btn-lg' disabled='disabled'>" + res + "审核</button>");
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

function restoreArticleLocker(aid) {
	// closing tab or refreshing action
	// check if any article is locked
	if (aid == null)
		aid =  $("#hidden-current-article").val();
	
	if (aid != "") {
		$.ajax( {
			url: "<%=basepath%>/manager/setArticleLocker",
			type: "POST",
			dataType: "JSON",
			data: {
				aid: aid,
				censorStatus: 0
			}
		});
		$("#hidden-current-article").val("");
	}
}
</script>
<input id="hidden-current-article" type="hidden" />
<div class="content-list" role-id=3>
	<c:forEach items="${articleList}" var="a">
	<div class="content-item">
		<div class="left-wrapper">
			<h4 title="[${a.id}]">${a.title}</h4>
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
				<button class="btn btn-info btn-lg" onclick="javascript:startCensor(${a.id})">开始审核</button>
			</span>
		</div>
		<div style="clear: both;"></div>
	</div>
	</c:forEach>
</div>