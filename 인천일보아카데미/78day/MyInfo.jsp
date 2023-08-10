<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>회원가입 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
		form>p{
			margin: 0 5px;
			font-size: 13px;
		}
		
		.colorGreen{
			color: green;
		}
		
		.colorRed{
			color: Red;
		}
		
		.formRow{
			border: 1px solid black;
		
			display: flex;
            align-items: center;
            
            justify-content: flex-start;

            margin: 10px 0;
            /* border: 1px solid black; */
            border-radius: 7px;
            padding: 5px;
            flex-wrap: wrap;
		}
		
		.formRow>button, .formRow>select{
			margin-left: 10px;
		}
		
		.formWrap{
			margin-left: auto;
			margin-right: auto;
			border: 3px solid black;
			border-radius: 14px;
			width: 600px;
			padding: 20px;
		}
		h2{
			text-align: center;
		}
		
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>내정보 페이지 - views/member/MemberLoginForm.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
						
			<div class="formWrap">
					<h2>내정보 확인</h2>
				
					<div class="formRow">
						<input type="text" name="mid" value="아이디: ${myInfo.mid }" disabled>
					</div>
					
					<div class="formRow">
						<input type="text" name="mpw" value="비밀번호 : ${myInfo.mpw }" disabled>
					</div>
					
					<div class="formRow">
						<input type="text" name="mname" value="이름: ${myInfo.mname }" disabled>
					</div>
					
					<div class="formRow">
						<input type="text" name="mbirth" value="생년월일: ${myInfo.mbirth }" disabled>
					</div>
					<div class="formRow">
						<input type="text" name="memail" value="이메일: ${myInfo.memail }" disabled>
					</div>
					<div>
						<button type = "button" class = "submitBtn" onclick="pwCheck('${myInfo.mpw}')">수정하기</button>
					</div>
			</div>
			<hr>
			작성한 글 : "${getTotalPost }"
			<hr>
			작성한 댓글: "${getTotalReply }"
		</div>
	</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
	let msg = '${msg}';
	if(msg.length > 0){
		alert(msg);
	}
	</script>
	<script type="text/javascript">
		function pwCheck(mpw) {
			let inputpw = prompt("비밀번호 입력");
			if(mpw == inputpw){
				location.href = "memberModifyForm";
			}else{
				alert('비밀번호를 다시 확인 해주세요!');
			}
		}
	</script>
</html>