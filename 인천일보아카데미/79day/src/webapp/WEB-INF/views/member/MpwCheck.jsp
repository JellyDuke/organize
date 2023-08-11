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
		
		.formWrap{
			margin-left: auto;
			margin-right: auto;
			border: 3px solid black;
			border-radius: 14px;
			width: 600px;
			padding: 20px;
		}
		
		h2, h4{
			text-align: center;
		}
		
		.formRow>input{
			outline: none;
			box-sizing: border-box;
			border: none;
			height: 30px;
			padding: 3px;
			font-size: 15px;
		}
		
		.formRow>button{
			width: 100%;
			cursor: pointer;
			border: 1px solid black;
			border-radius: 15px;
			height: 40px;
			margin-left: 10px;
		}
		
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>비밀번호 확인 페이지 - views/member/mpwCheck.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberPwCheck" method="post">
					<h2>비밀번호 확인 페이지</h2>

					<h4>개인정보 보호를 위해 비밀번호를 한 번 더 확인합니다.</h4>

					<div class="formRow">
						<input type="password" name="inputPw" placeholder="비밀번호">
					</div>
					
					<div class="formRow" style="border: none;">
						<button type="submit">확인</button>
					</div>
					
				</form>
			</div>
			
		</div>
	</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>

</html>