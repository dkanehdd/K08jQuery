<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JQ03Post.jsp</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
<script>
$(function(){	
	$('#btnLogin2').click(function(){
		//요청할 서버의 URL
		var s_url = "./common/03PostLoginOracle.jsp";
 		/*
 			serialize()
 			: <form> 태그의 하위태그들을 "name"속성을 통해 JSON으로
 		 	조립해준다. 전송할 폼값이 많을경우 주로 사용한다. 
 		*/
		var s_params = $('#loginFrm').serialize();
		
		$.post(
			s_url,
			s_params,			
			function(resData){
				var d = JSON.parse(resData);
				if(d.result==1){
					console.log(d.message);
					//JSON에 포함된 HTML값을 얻어와서 삽입
					$('#loginFrm').html(d.html);
					//로그인 버튼은 숨김처리
					/*
					#btnLogin2의 경우 loginFrm 하위에 있는 태그이므로
					위에 html()함수로 초기화를 시켰기때문에 hide()하지 않아도 
					없어지는데.....
					*/
					$('#btnLogin2').hide();
				}
				else{
					/*
					로그인실패시 JSON에 저장되있던 
					message키값을 얻어와 경고창에 띄워줌
					*/
					alert(d.message);
				}
				
				//콜백된 데이터를 Text형태로 출력한다. 
				$('#jsonDisplay').text(resData);
			}
		);		
	});
});

function checkFrm(){
	 
	var f = document.getElementById("loginFrm");
	 
	f.method = "post";
	f.action = "./common/03PostLoginOracle.jsp";
}
</script>
</head>
<body>
<div class="container">
	<h2>$.post() 메소드 사용하기</h2>	
	<h3>로그인 구현하기 - JDBC연동O(오라클사용)</h3>
	<div class="row" id="loginTable">
		<form id="loginFrm" onsubmit="return checkFrm();">
			<table class="table table-bordered">
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="user_id" value="ko1" />
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" name="user_pw" value="1234" />
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-danger" 
				id="btnLogin1">
				로그인하기(HTML의submit사용)</button>
			<button type="button" class="btn btn-success" 
				id="btnLogin2">
				로그인하기(jQuery의 $.post()사용)</button>			 
		</form>
	</div>
	<br/>
	<div class="row" id="jsonDisplay">
		JSON 데이터를 뿌려봅시다
	</div>
</div>	
</body>
</html>