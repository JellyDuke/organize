<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>영화예매프로젝트 - MOVIESPROJECT</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/users/assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="${pageContext.request.contextPath }/resources/users/css/styles.css"
	rel="stylesheet" />
<style type="text/css">
.card {
	background-color: #f7f7f7;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	width: 500px;
	margin: 20px auto;
}

.card-body {
	padding: 20px;
	background-image:
		url("https://cdn.pixabay.com/photo/2016/08/02/07/45/the-polygon-1562743_640.jpg");
}

.card-title h4.login {
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
	text-transform: uppercase;
	text-align: center;
}

form {
	display: flex;
	flex-direction: column;
}

form .input-group {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

form .input-group label {
	width: 70px;
	margin-right: 15px;
	font-weight: bold;
}

form input[type="text"], form input[type="password"] {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	flex: 1;
}

form input[type="submit"] {
	background-color: #007bff;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
}
</style>
</head>
<body>
	<!-- 메뉴시작 -->
	<!-- Responsive navbar-->
	<%@ include file="/WEB-INF/views/include/menu.jsp"%>
	<!-- 메뉴 끝 -->

	<!-- Page header with logo and tagline-->
	<header class="py-5 bg-light border-bottom mb-4">
		<div class="container">
			<div class="text-center my-5">
				<h1 class="fw-bolder">로그인 페이지</h1>
				<p class="lead mb-0">로그인을 위한 아이디, 비밀번호 입력 페이지</p>
			</div>
		</div>
	</header>

	<!-- Page content-->
	<div class="container">

		<!-- 컨텐츠 시작 -->
		<div class="card mb-4 mx-auto" style="width: 500px">
			<div class="card-body">
				<div class="card-title">
					<h4 class="login">로그인</h4>
				</div>

				<form action="/memberLogin" method="post" onsubmit="return formCheck(this)">
					<div class="input-group">
						<label for="userId">아이디</label> <input type="text" name="userId"
							id="userId" ><%--required="required" --%>
					</div>
					<div class="input-group">
						<label for="userPw">비밀번호</label> <input type="text" name="userPw"
							id="userPw"><%--required="required" --%>
					</div>
					<input type="submit" value="로그인">
				</form>

				<br>

				<div class="row">
					<button onclick="memberLogin_kakao()"
						class="btn btn-warning col-lg-5" style="margin-left: 10px">카카오	로그인</button>
				</div>
				<a href="/memberJoinForm">회원가입</a>
			</div>
		</div>
		<!-- 컨텐츠 끝 -->

	</div>


	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>

	<!-- JQUERY -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- 카카오로그인 JS -->
	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"
		integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh"
		crossorigin="anonymous"></script>

	<script type="text/javascript">
	    	Kakao.init('6419d68cc08de2e99f500a34b40bcf0e');
	    	Kakao.isInitialized();
    </script>
    	
    <script type="text/javascript">
    	function formCheck(formObj) {
    		console.log("formCheck() 호출")
    		let idEl = formObj.userId; //아이디 input 태그
    	    let pwEl = formObj.userPw; //비밀번호 input 태그
    	    
    		//아이디가 입력되지 않았으면 false;
    	    if(idEl.value.length == 0){
    	        alert("아이디를 입력해주세요!");
    	        idEl.focus();
    	        return false;
    	    }
    		//비밀번호가 입력되지 않았으면 false;
    	    if(pwEl.value.length == 0){
    	        alert("비밀번호를 입력해주세요!");
    	        pwEl.focus();
    	        return false;
    	    }
		}
    </script>	

	<script type="text/javascript">
    		function memberLogin_kakao() {
				console.log('카카오 로드인 호출()')
				
				Kakao.Auth.authorize({
			      redirectUri: 'http://localhost:8080/memberLoginForm',
			    });
    		}
    		
				let authCode = '${param.code}';
				console.log("auth.code: " + authCode);

				if(authCode.length > 0){
					console.log("카카오_인가코드 있음");
					console.log("인증토큰 요청");
					$.ajax({
						type : 'post',
						url : 'https://kauth.kakao.com/oauth/token',
						contentType : 'application/x-www-form-urlencoded;charset=utf-8',
						data: { 'grant_type' : 'authorization_code',
								'client_id' : '69ddafeea26c535a91f7fb998765c687',
								'redirect_uri' : 'http://localhost:8080/memberLoginForm',
								'code' : authCode
								},
						success : function(response){
							console.log("인증토큰" + response.access_token);
							Kakao.Auth.setAccessToken(response.access_token);
							
							Kakao.API.request({
								  url: '/v2/user/me',
								})
								  .then(function(response) {
									console.log('카카오 계정 정보');
								    console.log("id: "+ response.id);
								    console.log("email: "+ response.kakao_account.email);
								    console.log("nickname: "+ response.properties.nickname);
								    console.log("profile_image: "+ response.properties.profile_image);
									
								    //데이터 보내기
								    //location.href = ""
								    //$.ajax({})
								    
								    $.ajax({
								    	type : 'get',
								    	url : 'memberLogin_kakao',
								    	data : { 'id' : response.id, 'profile' : response.properties.profile_image},
								  		success : function(checkMember_kakao){
								  			
								    		if(checkMember_kakao == 'Y'){
								    			
										   		alert('로그인 되었습니다.');
										   		location.href="/";
										   		
											}else{
												
												let check = confirm('가입된 정보가 없습니다\n 카카오 계정으로 가입하시겠습니까?');

												if(check){
													
													console.log('카카오 회원가입 기능 호출');		
													memberJoin_kakao(response);
												}
											}
								    	}
								    });
								  })
								  .catch(function(error) {
								    console.log(error);
								  });
							}
						});	
				}
    	</script>
		<script>
			function memberJoin_kakao(res){
				console.log('memberJoin_kakao() 호출');
				$.ajax({
					type : 'get',
			    	url : 'memberJoin_kakao',
					data : { 'mid' : res.id,
							'mname' : res.properties.nickname,
							'memail' : res.kakao_account.email,
							'mprofile' : res.properties.profile_image		
				},
					success : function(joinResult){
						alert('카카오 계정으로 회원가입되었습니다. \n다시 로그인 해주세요!');
						location.href = "/memberLoginForm";
					} 
			});
		}
		</script>
		
		<script type="text/javascript">
		let msg = '${msg}';
		if(msg.length > 0){
			alert(msg);
		}
		</script>
</body>
</html>