<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>게시판 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
		
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
		
		div>ul{
			display: flex;
			list-style-type: none;
			padding: 0;
			justify-content: flex-end;
			text-decoration: none;
			align-items: center;
		}
		
		#boardInfo>ul>li{
			padding: 8px;
			margin: 0 5px;
			font-weight: bold;
		}
		
		.menuButton{
			border: 1px solid black;
			border-radius: 15px;
			padding: 8px;
			margin: 0 5px;
			font-weight: bold;
			cursor: pointer;
		}
		
		.commdelButton{
			border: 1px solid black;
			border-radius: 10px;
			margin-left: 5px;
			cursor: pointer;
		}
		
		#btitle{
			height: 60px;
			padding: 5px;
			border: 1px solid black;
			border-radius: 7px;
			display: flex;
			align-items: center;
		}
		
		.inputcomm{
			margin-top: 5px;
			border-radius: 7px;
			width: 96%;
			min-height: 70px;
			font-family: auto;
			resize: none;
			padding: 8px;
		}
		
		.reply{
			display: flex;
		}
		.reply>p{
			padding: 0;
			margin: 3px;
		}
		.recomm{
			margin-top: 5px;
			margin-bottom: 10px;
			border-radius: 7px;
			width: 96%;
			min-height: 70px;
			font-family: auto;
			resize: none;
			padding: 8px;
			text-align: center;
		}
		
	</style>
	
	<style type="text/css">
		.replyArea{
			border: 3px solid black;
			border-radius: 10px;
			width: 570px;
			margin: 0 auto;
			padding: 15px;
		}
		
		.replyWrite{
			border-radius: 7px;
			width: 100%;
			min-height: 70px;
			font-family: auto;
			resize: none;
			padding: 8px;
		}
		
		.replyWrite button{
			width: 100%;
			margin-top: 5px;
			cursor: pointer;
			padding: 5px;
			border-radius: 7px;
		}
		
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>글 상세보기 페이지 - views/board/BoardView.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호 -->
			
			<div class="formWrap">
			
				<h2>글 상세보기</h2>
				
				<div id="btitle">
					<h3>${board.btitle }</h3>
				</div>
				
				<div id="boardInfo" class="formRow">
					<ul>
						<li>작성자 : ${board.bwriter }</li>
						<li>${board.bdate }</li>
						<li>조회수 : ${board.bhits }</li>
					</ul>
				</div>
					
				<div style="border: none" class="formRow">
					<img alt="" src="${pageContext.request.contextPath }/resources/boardUpload/${board.bfilename }">
				</div>
				
				<div class="formRow" style="min-height: 300px; align-items: flex-start;">
					<p style="">${board.bcontents }</p>
				</div>
					
				<div class="formRow" style="border: none">
					<ul>
						<li class="menuButton">글목록</li>
						<c:if test="${sessionScope.loginMemberId == board.bwriter }">
							<li class="menuButton">글수정</li>
							<li class="menuButton">글삭제</li>
						</c:if>
					</ul>
				</div>
				
				<hr>
				
				<%-- 댓글 관련 시작 --%>
				<div class="replyArea">
				
					<c:if test="${sessionScope.loginMemberId != null }">
						<div class="replyWrite">
							<h3>댓글 작성 양식 - 로그인한 경우 출력</h3>
							<form onsubmit="return replyWrite(this)">
								<input type="hidden" name="rebno" value="${board.bno }">
								<input type="hidden" name="bwriter" value="${board.bwriter }">
								<textarea class="inputcomm" name="recomment" placeholder="댓글 내용 작성"></textarea>
								<button type="submit">댓글 등록</button>
							</form>
						</div>
						<hr>
					</c:if>
					
					
					<h3>댓글 출력</h3>
					<div id="replyList">
						
					</div>
					
				</div>
				
				
				<%-- 댓글 관련 끝 --%>
				
			</div> <%-- div.contents 끝 --%>
			
		</div> <%-- div.mainWrap 끝 --%>
		
	</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }'
		if(msg.length > 0){
			alert(msg);
		}
	</script>
	
	<script type="text/javascript">
		function replyWrite(formObj) {
			console.log("replyWrite 호출 : " + formObj.rebno.value);
			/* ajax 댓글 등록 요청 전송 */
			$.ajax({
				type: "get",
				url: "replyWrite",
				data: {"rebno" : formObj.rebno.value, "recomment" : formObj.recomment.value },
				success: function(result){
					console.log("result : " + result);
					if(result == "1"){
						alert("댓글이 등록 되었습니다.");
						formObj.recomment.value = ""; // 댓글 내용 작성 textarea 초기화
						// 댓글 목록 갱신
						getReplyList(bno);
						
						let noticeObj = {"noticeType" : "reply", "noticeMsg" : formObj.rebno.value, "receiveId" : formObj.bwriter.value };
						
						// 공지타입, 글번호, 작성자 >> JSON
						noticeSock.send( JSON.stringify(noticeObj) );
						
					}
					else{
						alert("댓글 등록에 실패했습니다.");
					}
				}
			});
			
			return false;
		}
		
		// 댓글 목록 조회
		function getReplyList(rebno) {
			console.log("getReplyList() 호출");
			console.log("댓글 조회할 글번호 : " + rebno);
			
			<%-- SELECT * FROM REPLYS WHERE REBNO = #{rebno } AND RESTATE = '1' ORDER BY REDATE
			   >> ArrayList<Reply> >> JSON 변환 >> 페이지로 응답 --%>
			$.ajax({
				type: "get",
				url: "replyList",
				data: {"rebno" : rebno},
				dataType: "json", 
				success: function(reList){
					printReplyList(reList); // 댓글 출력 기능 호출
				}
			});
		}
	</script>
	
	<%--
		<div id="replyList">
			
			<div class="reply">
				<p>작성자 출력</p>
				<p>작성일 출력</p>
				<button>댓글삭제</button>
			</div>
			
			<div>
			<textarea class="recomm" disabled="disabled">댓글내용 출력</textarea>
			</div>
			
			<hr>
						
		</div>
	--%>
	
	<script type="text/javascript">
	
		let loginId = '${sessionScope.loginMemberId }';
		console.log("로그인된 아이디 : " + loginId);
	
		// 댓글 출력 기능
		function printReplyList(reList){
			let reListDiv = document.querySelector('#replyList');
			reListDiv.innerHTML = ""; // 댓글을 출력할 DIV 자식요소 초기화
			
			for(let reInfo of reList){ // let i=0; i<reList.length; i++
				
			let replyDiv = document.createElement('div'); // <div></div>
			replyDiv.classList.add('reply'); // <div class="reply"></div>
			
			let replyCommDiv = document.createElement('div'); // <div></div>
			
			let reWriter = document.createElement('p'); // <p></p>
			reWriter.innerText = reInfo.remid; // <p>작성자</p>
			replyDiv.appendChild(reWriter); // <div class="reply"> <p>작성자</p> </div>
			
			let reDate = document.createElement('p'); // <p></p>
			reDate.innerText = reInfo.redate; // <p>작성일</p>
			replyDiv.appendChild(reDate); // <div class="reply"> <p>작성일</p> </div>
			
			// 댓글 작성자와 로그인된 아이디가 같을 경우에 실행
			// <button onclick="delReply()">삭제</button>
			if(reInfo.remid == loginId && reInfo.restate == '1'){
				let rebtn = document.createElement('button'); // <button></button>
				rebtn.innerText = "삭제"; // <button>삭제</button>
				rebtn.classList.add('commdelButton');
				rebtn.setAttribute("onclick", "delReply('"+reInfo.renum+"')");
				replyDiv.appendChild(rebtn); // <div class="reply"> <button>삭제</button> </div>
			}
			
			reListDiv.appendChild(replyDiv);
			/* <div class="reply">
				 <p>작성자</p>
				 <p>작성일</p>
				 <button>삭제</button>
			   </div> 추가 */
			
			let recomment = document.createElement('textarea'); // <textarea></textarea>
			
			if(reInfo.restate == '0'){
				recomment.value = "삭제된 댓글입니다.";
			}
			else{
				recomment.value = reInfo.recomment; // <textarea>댓글내용</textarea>
			}
			
			recomment.classList.add('recomm'); // <textarea class="recomm">댓글내용</textarea>
			recomment.setAttribute("disabled", "disabled"); // <textarea class="recomm" disabled = "disabled">댓글내용</textarea>
			
			replyCommDiv.appendChild(recomment); // <div> <textarea class="recomm" disabled = "disabled">댓글내용</textarea> </div>
			
			reListDiv.appendChild(replyCommDiv);
			// <div>
			//	 <textarea class="recomm" disabled = "disabled">댓글내용</textarea>
			// </div> 추가
			
			}
			
		}
	</script>
	
	<script type="text/javascript">
		function delReply(delrenum){
			console.log("삭제할 댓글 번호 : " + delrenum);
			let confirmVal = confirm('댓글을 삭제 하시겠습니까?');
			if(confirmVal){
				$.ajax({
					type : "get",
					url : "deleteReply",
					data : {"renum" : delrenum},
					success : function(result){
						if(result == '1'){
							alert("댓글이 삭제 되었습니다.");
							getReplyList(bno);
						}
						else{
							alert("댓글 삭제 처리를 실패하였습니다.");
							getReplyList(bno);
						}
					}
				});
			}
		}
	</script>
	
	<script type="text/javascript">
		let bno = '${board.bno }'; // 현재 글번호
	
		$(document).ready(function(){
			getReplyList(bno);
		})
	</script>
	

</html>