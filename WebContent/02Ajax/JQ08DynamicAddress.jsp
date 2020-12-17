<%@page import="java.util.ArrayList"%>
<%@page import="controller.ZipcodeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
ZipcodeDAO dao = new ZipcodeDAO();
//zipcode테이블에서 sido를 중복을 제거하여 가져온다.
ArrayList<String> sidoList = dao.getSido();
//페이지 영역에 sido리스트를 저장한다. 
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
			url : "./common/08GugunOption.jsp",
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : {
				//select에서 선택한 시도를 파라미터로 전송
				sido : $("#sido option:selected").val()
			},
			dataType : "json",
			success : function(d) {
				//console.log(d);
				/*
		                위 url로 요청을 하면 아래와 같은 결과가 콜백된다.
		         JSON배열이므로 요소의 갯수만큼 반복하는 파싱작업이 필요하다.
		         
	            ["중랑구","중구","종로구","은평구","용산구","영등포구","양천구","송파구",
	               "성북구","성동구","서초구","서대문구","마포구","동작구",
	               "동대문구","도봉구","노원구","금천구","구로구","광진구",
	               "관악구","강서구","강북구","강동구","강남구"]
	            */
				var optionStr ="";
				optionStr += "<option value=''>";
				optionStr += "-구군을 선택하세요-";
				optionStr += "</option>";
				//$.each()통해 반복되는 요소의 인덱스와 요소값을 매개변수로 받을수있다.
				$.each(d, function(index, data){
					optionStr += '<option value="'+data+'">';
					optionStr += data;
					optionStr += '</option>';
				});
				
				$('#gugun').html(optionStr);
				$('#dong').html("<option value=''>-동선택하삼-</option>");
			},
			error : function(e){
				alert("오류발생:"+ e.status+":"+e.statusText);
			}
		});
	});
	$('#gugun').change(function(){
		
		//alert($('#sido').val()+" 선택됨");
		$.ajax({
			url : "./common/08DongOption.jsp",
			type : "get",
			contentType : "text/html;charset:utf-8",
			data : {
				sido : $("#sido option:selected").val(),
				gugun : $("#gugun option:selected").val()
			},
			dataType : "json",
			success : function(d) {
				//console.log(d);
				var optionStr ="";
				optionStr += "<option value=''>";
				optionStr += "-동을 선택하세요-";
				optionStr += "</option>";
				$.each(d, function(index, data){
					optionStr += '<option value="'+data+'">';
					optionStr += data;
					optionStr += '</option>';
				});
				
				$('#dong').html(optionStr);
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
		<div class="col-4">
			구/군:
			<select id="gugun" class="form-control">
				<option value="">-구/군선택하삼-</option>
			</select>
		</div>	
		<div class="col-4">
			면/읍/리/동:
			<select id="dong" class="form-control">
				<option value="">-동선택하삼-</option>
			</select>
		</div>	
	</div>
	</form>
</div>
	
</body>
</html>