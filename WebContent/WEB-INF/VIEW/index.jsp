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
<script type="text/javascript"	src="<%=basepath%>/js/bootstrap-my-pagination.js"></script>
<script type="text/javascript">
	$(function() {
		/* BootstrapDialog.show({
			type: BootstrapDialog.TYPE_INFO,
			title: "Greeting",
			message: "欢迎访问 新意阅读网"
		}); */
		
		$(".item-list").pagination( {
			style: 3
		}).css({"width": "50%"});
	});
	
	function ajaxGreeting() {
		$.ajax( {
			url: "<%=basepath%>/ajax/greeting",
			type: "POST",
			dataType: "JSON",
			data: {
				data: "hello there"
			}
		}).done(function( json ) {
			BootstrapDialog.show({
				title: "Message",
				message: json.msg
			});
		}).fail(function() {
			alert("FAIL");
		}).error(function (XMLHttpRequest, textStatus, errorThrown) {
			$("body").append(XMLHttpRequest.responseText);
		});
	}
</script>
<title>新意阅读网</title>
</head>
<body>
<h1>Hello World</h1>
<h5><a href="user/list">data test</a></h5>
<button type="button" class="btn btn-default" onclick="ajaxGreeting()">ajax test</button>
<a href="<%=basepath%>/join">注册</a>
<div class="item-list">
	<div class="item">
		<div class="well">
			<a href="#">item1</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item2</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item3</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item4</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item5</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item6</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item7</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item8</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item9</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item10</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item11</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item12</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item13</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item14</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item15</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item16</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item17</a>
		</div>
	</div>
</div><div class="item-list">
	<div class="item">
		<div class="well">
			<a href="#">item1</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item2</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item3</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item4</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item5</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item6</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item7</a>
		</div>
	</div>
	<div class="item">
		<div class="well">
			<a href="#">item8</a>
		</div>
	</div>
</div>
</body>
</html>