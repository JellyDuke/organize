<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>내 정보 확인 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
		form>p{
			margin: 0 5px;
			font-size: 13px;
		}

		
		.formRow {
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
		
		h2{
			text-align: center;
		}
		
		p{
			margin: 5px 0;
		}
		
		.formRow>button{
			width: 20%;
			cursor: pointer;
			border: 1px solid black;
			border-radius: 15px;
			height: 40px;
			margin-left: 10px;
		}
		
		.bInfo{
			border: 1px solid black;
			display: flex;
            align-items: center;
            justify-content: flex-start;
            border-radius: 7px;
            padding: 5px;
            flex-wrap: wrap;
		}
		
		.bInfo>p{
			margin: 5px 20px;
			cursor: pointer;
		}
		
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>내 정보 확인 페이지 - views/member/MyInfo.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			
			<div class="formWrap">
			
				<h2>내 정보 확인</h2>
				
				<div class="formRow">
					<p>아이디 : ${mem.mid }</p>
				</div>
					
				<div class="formRow">
					<p>비밀번호 : ${mem.mpw }</p>
				</div>
					
				<div class="formRow">
					<p>이름 : ${mem.mname }</p>
				</div>
					
				<div class="formRow">
					<p>생년월일 : ${mem.mbirth }</p>
				</div>
					
				<div class="formRow">
					<p>이메일 : ${mem.memail }</p>
				</div>
					
				<div class="formRow" style="border: none;">
					<button type="button" onclick="pwCheck(${mem.mpw })">수정하기</button>
				</div>
				
				<hr>
				
				<div class="bInfo">
				<p onclick="location.href='${pageContext.request.contextPath }/boardList?mid=${mem.mid }'">작성한 글 : ${totalBoard.size() }개</p>
				<p>작성한 댓글 : ${totalReply.size() }개</p>
				</div>
				
			</div>
			
			
		</div>
	</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		function pwCheck(mpw){
			let inputpw = prompt("비밀번호 입력");
			if(mpw == inputpw){
				location.href = "memberModifyForm";
			}
			else{
				alert('비밀번호를 다시 확인 해주세요!');
			}
		}
	</script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>

</html>