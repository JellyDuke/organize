<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>내 정보 수정 페이지</title>
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
		
		.formRow>input{
			outline: none;
			box-sizing: border-box;
			border: none;
			height: 30px;
			padding: 3px;
			font-size: 15px;
			width: 35%;
		}
		
		.formRow>input[type="submit"]{
			width: 100%;
			cursor: pointer;
			border: 1px solid black;
			border-radius: 15px;
			height: 40px;
		}
		
		.formRow>p{
			margin: 0;
		}
		
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>내 정보 수정 페이지 - views/member/MemberModifyForm.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberModify" method="post">
					<h2>내 정보 수정</h2>
				
					<div class="formRow">
						<p>아이디 : &nbsp;</p>
						<input type="text" name="mid" value="${mem.mid }" readonly="readonly">
					</div>
					
					<div class="formRow">
						<p>비밀번호 : &nbsp;</p>
						<input type="text" name="mpw" value="${mem.mpw }" placeholder="비밀번호">
					</div>
					
					<div class="formRow">
						<p>이름 : &nbsp;</p>
						<input type="text" name="mname" value="${mem.mname }" placeholder="이름">
					</div>
					
					<div class="formRow">
						<p>생년월일 : &nbsp;</p>
						<input type="date" name="mbirth" value="${mem.mbirth }">
					</div>
					
					<div class="formRow">
						<p>이메일 : &nbsp;</p>
						<input type="text" name="memail" value="${mem.memail }" placeholder="이메일">
					</div>
					
					<div class="formRow" style="border: none;">
						<input type="submit" value="수정">
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