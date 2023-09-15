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
    	<style>
		.formWrap {
		  max-width: 400px;
		  margin: 0 auto;
		  padding: 20px;
		  border: 1px solid #ccc;
		  border-radius: 5px;
		}
		
		.formRow {
		  margin-bottom: 20px;
		}
		
		.formRow input[type="text"],
		.formRow input[type="date"] {
		  width: 100%;
		  padding: 10px;
		  border: 1px solid #ccc;
		  border-radius: 5px;
		}
		
		.formRow button {
		  padding: 10px 20px;
		  background-color: #007bff;
		  color: white;
		  border: none;
		  border-radius: 5px;
		  cursor: pointer;
		}
		
		#idMsg {
		  color: #007bff;
		}
		
		.formRow select {
		  width: 100%;
		  padding: 10px;
		  border: 1px solid #ccc;
		  border-radius: 5px;
		}
		
		.formRow input[type="submit"] {
		  padding: 10px 20px;
		  background-color: #007bff;
		  color: white;
		  border: none;
		  border-radius: 5px;
		  cursor: pointer;
		  font-weight: bold;
		}
		
		.formWrap h4 {
		  font-size: 24px;
		  text-align: center;
		  margin-bottom: 20px;
		}
		
		.formRow .email-input {
	    display: flex;
	    align-items: center;
	    width: 100%;
		}
		
		.formRow .email-input input[type="text"] {
		    flex: 1;
		    padding: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}
		
		.formRow .email-input input[type="text"]#eDomain {
		    width: 50%;
		    margin-left: 10px;
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
                    <h1 class="fw-bolder">회원가입 페이지</h1>
                    <p class="lead mb-0">views/member/MemberJoinForm.jsp</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container" style="background-image: url('')">
        
            <!-- 컨텐츠 시작 -->
            
            <div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberJoin" method="post" enctype="multipart/form-data"
				onsubmit="return formCheck(this)">
				
					<div class="formRow">
						<input type="text" id="inputId" name="mid" onkeyup="idCheck(this)" placeholder="아이디">
					</div>
					
					<p id="idMsg">중복확인 해주세요!</p>
					
					<div class="formRow">
						<input type="text" name="mpw" placeholder="비밀번호">
					</div>
					
					<div class="formRow">
						<input type="text" name="mname" placeholder="이름">
					</div>
					
					<div class="formRow">
						<input type="date" name="mbirth">
					</div>
					<div class="formRow">
						<div>프로필 등록</div>
						<input type="file" name="bfile">
					</div>
					<div class="formRow">
						<input type="text" id="memailId" name="memailId" placeholder="이메일 아이디">
						<input type="text" id="eDomain" name="memailDomain" placeholder="이메일 도메인">
					
						<select onchange="selectDomain(this)">
							<option value="">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="daum.net">다음</option>
							<option value="google.com">구글</option>
						</select>
						
					</div>
					
					<div class="formRow">
						<input type="submit" value="가입">
					</div>
					
				</form>
			</div>
            <br>
            <!-- 컨텐츠 끝 -->    
            
        </div>
        
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    
    	<!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    	
    	<!-- 아이디 중복 체크 -->
    	<script type="text/javascript">
    	
    	let idChecked = false; // 아이디 중복확인 
    	
    	function idCheck(inputId){
			// 중복 확인할 아이디 VALUE 확인
			let idEl = document.querySelector('#inputId');
			console.log(idEl.value);
			
			// ajax - 아이디 중복 확인요청(memberIdCheck)
			$.ajax( { type: "get", // 전송 방식
					  url: "memberIdCheck", // 전송 URL
					  data: { "inputId" : idEl.value }, // 전송 파라메터
					  success: function(re){ // 전송에 성공했을 경우
						  // re : 응답받은 데이터
						  console.log("확인결과 : " + re);
		                    if(re == "Y"){
		                    	/* 사용 가능한 아이디입니다. 출력 */
		                    	let msgEl = document.getElementById('idMsg');
		                    	msgEl.innerText = '사용 가능한 아이디입니다.';
		                    	idChecked = true;
		                    	// document.querySelector('#idmsg').innerText = '사용 가능한 아이디입니다.';
		                        // $("#idMsg").css("color", 'green').text("사용 가능한 아이디입니다.");
		                    }
		                    
		                    else{
		                    	/* 중복된 아이디입니다. 출력 */
		                    	let msgEl = document.getElementById('idMsg');
		                    	msgEl.innerText = '이미 가입된 아이디입니다.';
		                    	idChecked = false;
		                    	// document.querySelector('#idmsg').innerText = '이미 가입된 아이디입니다.';
		                        // $("#idMsg").css("color", 'red').text("이미 가입된 아이디입니다.");
		                    }
		                    
		                    
		                }
				 });
		}
    	</script>
    	
    	<script type="text/javascript">
		function selectDomain(selObj){
			document.getElementById('eDomain').value = selObj.value;
		}
		</script>
		
		
		<script type="text/javascript">
		function formCheck(formObj) {
    		console.log("formCheck() 호출")
    		let idEl = formObj.mid; //아이디 input 태그
    	    let pwEl = formObj.mpw; //비밀번호 input 태그
    	    let nmEl = formObj.mname; //이름 input 태그
    	    
    		//아이디가 입력되지 않았으면 false;
    	    if(idEl.value.length == 0){
    	        alert("아이디를 입력해주세요!");
    	        idEl.focus();
    	        return false;
    	    }
    	    //아이디 길이 체크 false;
    	    if(idEl.value.length > 21){
    	    	alret("아이디 20글자 이내로 입력해주세요!");
    	    	idEl.focus();
    	    	return false;
    	    }
    	    //이름이 입력되지 않았으면 false;
    	    if(nmEl.value.length == 0){
    	    	alert("이름을 입력해주세요!");
    	        nmEl.focus();
    	        return false;	
    	    }
    	    if(!idChecked){
    	    	alert('아이디를 중복확인 해주세요!');
    	    	inputId.focus();
    	    	return false;
    	    }
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

