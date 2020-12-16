<%@page import="java.util.ArrayList"%>
<%@page import="controller.ZipcodeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
ZipcodeDAO dao = new ZipcodeDAO();
ArrayList<String> sidoList = dao.getSido();
pageContext.setAttribute("sidoList", sidoList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JQ08DynamicAddress</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(function() {
	$('#sido').change(function(){
	
		//alert($('#sido').val()+" 선택됨");
		$.ajax({
			url : "./common/08GugumOption.jsp",
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : {
				sido : $("#sido option:selected").val()
			},
			dataType : "json",
			success : function(d) {
				//console.log(d);
				var optionStr ="";
				optionStr += "<option value=''>";
				optionStr += "-구군을 선택하세요-";
				optionStr += "</option>";
				$.each(d, function(index, data){
					optionStr += '<option value="'+data+'">';
					optionStr += data;
					optionStr += '</option>';
				});
				
				$('#gugun').html(optionStr);
			},
			error : function(e){
				alert("오류발생:"+ e.status+":"+e.statusText);
			}
		});
	});
});
</script>
</head>
<body>
	<div class="container">
	<div class="row">
		<h2>우편번호DB를 이용한 시도/구군 동적셀렉트 구현</h2>
	</div>
	<form id="zipFrm">
	<div class="row">		
		<div class="col-4">
			시/도:
			<select id="sido" class="form-control">
				<option value="">-시/도선택하삼-</option>
				<c:forEach items="${sidoList }" var="sidoStr">
					<option value="${sidoStr }">${sidoStr }</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-8">
			구/군:
			<select id="gugun" class="form-control">
				<option value="">-구/군선택하삼-</option>
			</select>
		</div>		
	</div>
	</form>
</div>
	
</body>
</html>