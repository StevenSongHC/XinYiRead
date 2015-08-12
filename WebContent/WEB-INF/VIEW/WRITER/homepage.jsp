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
${writer.penName}
<div>
	<button type="button" class="btn btn-success" onclick="javascript:commendWriter()"><span class="glyphicon glyphicon-thumbs-up"></span> 给作者点个赞 <span class="badge">${writer.likeCount}</span></button>
</div>
</body>
</html>