<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>영화예매프로젝트 - MOVIESPROJECT</title>
        <!-- Favicon-->
     	   <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/users/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath }/resources/users/css/styles.css" rel="stylesheet" />
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
		  background-image: url("https://cdn.pixabay.com/photo/2016/08/02/07/45/the-polygon-1562743_640.jpg");
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
        <%@ include file="/WEB-INF/views/include/menu.jsp" %>
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
            	<div class="card mb-4 mx-auto" style = "width: 500px">
	            	<div class="card-body">
        	    		<div class="card-title">
							<h4 class="login">로그인</h4>    	        			
            			</div>
            			
            			<form action="">
            				<div class="input-group">
            				<label for="userId">아이디</label>
            				<input type="text" name="userId" id="userId">
            				</div>
            				<div class="input-group">
            				<label for="userPw">비밀번호</label>
            				<input type="text" name="userPw" id="userPw">
            				</div>
            				<input type ="submit" value="로그인">
            			</form>
            				<div class="row m-1">
            					<button onclick="memberLogin_kakao()" class="btn btn-warning">카카오 로그인</button>
            				</div>
            				<a id="kakao-login-btn" href="javascript:memberLogin_kakao()">
							  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
							    alt="카카오 로그인 버튼" />
							</a>
            		</div>
            	</div>
            <!-- 컨텐츠 끝 -->    
            
        </div>
        
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    	<!-- 카카오로그인 JS -->
    	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
    
    	<script type="text/javascript">
	    	Kakao.init('6419d68cc08de2e99f500a34b40bcf0e');
	    	Kakao.isInitialized();
    	</script>	
    	
    	<script type="text/javascript">
    		function memberLogin_kakao() {
				console.log('카카오 로드인 호출()')
				
				Kakao.Auth.authorize({
			      redirectUri: 'http://localhost:8080/memberLoginForm',
			    });
							
				
				Kakao.API.request({
				  url: '/v2/user/me', // 사용자 정보 가져오기
				})
				
				  .then(function(response) {
				    console.log(response)
				  })
				  .catch(function(error) {
				    console.error(error)
				  })
				
			}
    	</script>
    </body>
</html>

