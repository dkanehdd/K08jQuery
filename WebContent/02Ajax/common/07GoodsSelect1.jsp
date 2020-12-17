<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일명 : 07GoodsSelect1.jsp --%>
<%
request.setCharacterEncoding("UTF-8");
String gName = request.getParameter("goodsOptionName");
String idx = request.getParameter("tableIdx");
if(gName.equals("op01")){
%>
	<table class="table table-bordered" id="<%=idx%>">
		<tr>
			<td>옵션명:</td>
			<td>옵션선택1(AAA추가)</td>
		</tr>
		<tr>
			<td colspan="2" class="table-danger">추가비용
				: +5,000원 <button type="button" class="close" value="<%=idx%>" id="remove<%=idx%>" name="5000">&times;</button></td>
		</tr>
	</table>
<%} else if(gName.equals("op02")) {%>
	<table class="table table-bordered" id="<%=idx%>">
		<tr>
			<td>옵션명:</td>
			<td>옵션선택2(BBB추가)</td>
		</tr>
		<tr>
			<td colspan="2" class="table-info">추가비용
				: +7,000원 <button type="button" class="close" value="<%=idx%>" id="remove<%=idx%>" name="7000">&times;</button></td>
		</tr>
	</table>
<%} else if(gName.equals("op03")) {%>
	<table class="table table-bordered" id="<%=idx%>">
		<tr>
			<td>옵션명:</td>
			<td>옵션선택3(CCC추가)</td>
		</tr>
		<tr>
			<td colspan="2" class="table-success">추가비용
				: +10,000원 <button type="button" class="close" value="<%=idx%>" id="remove<%=idx%>" name="10000">&times;</button></td>
		</tr>
	</table>
<%} %>
<script>
$(function() {
	   $("#remove"+<%=idx%>).click(function(){
	      $.ajax({
	         url : "./JQ07ShoppingCart.jsp",
	         type : "get",
	         dataType : "html", //콜백데이터의 타입
	         contentType : "text/html;charset:utf-8",
	         success : function (d) {
	        	var idx = $("#remove"+<%=idx%>).val();
	        	console.log(idx);
	        	var price = $("#remove"+<%=idx%>).get(0).name;
	        	console.log(price);
	        	var totalPrice = parseInt($('#totalPrice').val());
	        	console.log(totalPrice);
	        	totalPrice -= price;
	        	$('#totalPrice').val(totalPrice);
				$('#priceDisplay').html("총상품금액:"+totalPrice);
	            $('#'+idx).empty();
	         },
	         error : function(e) {
	            alert("실패" + e.status);
	         }
	      });
	   });
	});
</script>
