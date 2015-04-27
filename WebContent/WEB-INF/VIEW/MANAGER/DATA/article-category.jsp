<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String basepath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><script type="text/javascript">
$(document).ready(function() {
	$("#menu-nav ul>li[menu='article']").addClass("active");
	$("#submenu-nav ul[parent='article']").show();
	$("#submenu-nav ul[parent='article']>li[submenu='category']").addClass("active");
});

function editCategoryName(nomep) {
	var enRow = $("tr[nomep='" + nomep + "']");
	var editElement = $(enRow).children("td[data-row='name']");
	$(editElement).html("<input type='text' class='edit-property' value='" + $(editElement).html() + "'>");
	$(enRow).find(".action").hide();
	$(enRow).find(".option").show();
}
function confirmEdit(nomep) {
	if (confirm("确定要保存修改")) {
		var enRow = $("tr[nomep='" + nomep + "']");
		var editElement = $(enRow).children("td[data-row='name']");
		var name = $(editElement).children("input").val().trim();
		if (name !== "") {
			$.ajax( {
				url: "<%=basepath%>/manager/update/category",
				type: "POST",
				dataType: "JSON",
				data: {
					catid: nomep,
					name: name,
					oldName: $(editElement).attr("origin-name")
				}
			}).done(function( json ) {
				switch (json.code) {
					case 0:
						alert("该分类记录已存在");
						break;
					case 1:
						$(enRow).find(".action").show();
						$(enRow).find(".option").hide();
						$(editElement).html(name);
						$(editElement).attr("origin-name", name);
						break;
					default:
						alert("服务器未正常响应");
				}
			}).fail(function() {
				alert("更新时出错");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
		else
			alert("不能为空");
	}
}
function cancelEdit(nomep) {
	var enRow = $("tr[nomep='" + nomep + "']");
	var editElement = $(enRow).children("td[data-row='name']");
	$(editElement).html($(editElement).attr("origin-name"));
	$(enRow).find(".action").show();
	$(enRow).find(".option").hide();
}

function createCategory() {
	var enRow = $("tr[nomep='new']");
	$(enRow).append("<td><input type='text' class='edit-property'></td>");
	$(enRow).find("td:first .action").hide();
	$(enRow).find("td:first .option").show();
}
function confirmCreate() {
	if (confirm("确定要新建")) {
		var enRow = $("tr[nomep='new']");
		var name = $(enRow).find("td:last input").val().trim();
		if (name !== "") {
			$.ajax( {
				url: "<%=basepath%>/manager/insert/category",
				type: "POST",
				dataType: "JSON",
				data: {
					name: name
				}
			}).done(function( json ) {
				switch (json.code) {
					case 0:
						alert("该分类记录已存在");
						break;
					case 1:
						$(enRow).find("td:first .option").hide();
						$(enRow).find("td:first").html("NEW");
						$(enRow).find("td:last").html(name);
						break;
					default:
						alert("服务器未正常响应");
				}
			}).fail(function() {
				alert("新建时出错");
			}).error(function (XMLHttpRequest, textStatus, errorThrown) {
				$("body").append(XMLHttpRequest.responseText);
			});
		}
		else
			alert("不能为空");
	}
}
function cancelCreate() {
	var enRow = $("tr[nomep='new']");
	$(enRow).find("td:last").remove();
	$(enRow).find("td:first .action").show();
	$(enRow).find("td:first .option").hide();
}
</script>
<style type="text/css">
.edit-property {
	width: 150px;
}
td .option {
	display: none;
}
</style>
</head>
<body>
<table class="table table-hover" style="text-align: center; font-size: 18px;">
		<tr>
			<td width="20%">ID</td>
			<td width="30%">分类名</td>
			<td width="30%">相关文章数量</td>
			<td width="20%">操作</td>
		</tr>
	<c:forEach items="${categoryList}" var="cat">
		<tr nomep="${cat.id}">
			<td data-row="id">${cat.id}</td>
			<td data-row="name" origin-name="${cat.name}">${cat.name}</td>
			<td data-row="article-count"><a href="<%=basepath%>/manager?menu=article&submenu=list&catid=${cat.id}">${cat.article_count}</a></td>
			<td data-row="operation">
				<a href="javascript:editCategoryName(${cat.id})"><span class="glyphicon glyphicon-pencil action" title="编辑"></span></a>
				<a href="javascript:confirmEdit(${cat.id})"><span class="glyphicon glyphicon-ok option" title="确定"></span></a>
				<a href="javascript:cancelEdit(${cat.id})"><span class="glyphicon glyphicon-remove option" title="取消"></span></a>
			</td>
		</tr>
	</c:forEach>
	<tr nomep="new">
		<td>
			<a href="javascript:createCategory()"><span class="glyphicon glyphicon-plus action"></span></a>
			<a href="javascript:confirmCreate()"><span class="glyphicon glyphicon-ok option" title="确定"></span></a>
			<a href="javascript:cancelCreate()"><span class="glyphicon glyphicon-remove option" title="取消"></span></a>
		</td>
	</tr>
</table>
</body>
</html>