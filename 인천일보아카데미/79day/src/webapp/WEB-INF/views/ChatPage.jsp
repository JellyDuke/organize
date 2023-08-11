<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style type="text/css">
	
		#chatContents {
			display: flex;
			width: 900px;
		}
		
		#leftContent {
			margin: 5px;
		}
		
		#rightContent {
			margin: 5px;
			width: 230px;
		}
		
		#connMembersArea {
			border: 3px solid black;
			border-radius: 10px;
			padding: 7px;
			box-sizing: border-box;
			height: 639px;
			overflow: scroll;
		}
		
		.connMember {
			border: 2px solid black;
			border-radius: 7px;
			padding: 5px;
			margin: 5px 0;
		}
	
		#chatArea {
			box-sizing: border-box;
			border: 3px solid black;
			border-radius: 10px;
			margin-left: 10px;
			padding: 5px;
			width: 500px;
			height: 600px;
			overflow: scroll;
			background-color: lightgrey;
		}
		
		.conMsg {
			border: 1px solid black;
			border-radius: 15px;
			background-color: grey;
			text-align: center;
			display: flex;
			justify-content: center;
			width: 300px;
			max-width: 400px;
			margin: 5px auto;
		}
		
		.sendMsgDiv {
			display: flex;
			justify-content: flex-end;
			margin: 10px;
			padding: 5px;
		}
		
		.sendMsg {
			border: 1px solid black;
			border-radius: 7px;
			padding: 5px;
			background-color: yellow;
			text-align: center;
			max-width: 300px;
		}
		
		.receiveMsg {
			margin: 10px;
			padding: 5px;
		}
		
		.receiveMsgId {
			text-align: left;
		}
		
		.receiveMsgComm {
			background-color: white;
			border: 1px solid black;
			border-radius: 7px;
			max-width: 300px;
			padding: 4px;
			display: inline-block;
		}
		
		#inputDiv {
			border: 3px solid black;
			border-radius: 10px;
			box-sizing: border-box;
			width: 500px;
			display: flex;
			margin-left: 10px;
		}
		
		#inputDiv>input {
			width: 100%;
			padding: 5px;
		}
		
		#inputDiv>button {
			width: 100px;
			padding: 5px;
		}
		
	</style>
	
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>채팅 페이지 - views/ChatPage.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				
				<div id="chatContents">
				
					<div id="leftContent">
						<%-- <h1>1. pom.xml > spring-websocket, jackson databind 추가</h1>
						<h1>2. com.spring_memberBoard.sockUtil 패키지에 ChatHandler 클래스 생성</h1>
						<h1>3. servlet-context.xml websocket 설정 추가</h1>
						<h1>4. ChatPage.jsp에 sockjs 추가</h1>
						<h1>5. ChatPage.jsp에 채팅 기능 구현</h1>
						
						<hr> --%>
						
						<div id="chatArea">
						
						</div>
						<div id="inputDiv">
							<input type="text" id="msgInput">
							<button onclick="sendMsg()">전송</button>
						</div>
					
					</div> <%-- leftContent 끝 --%>
					
					<div id="rightContent">
						<div id="connMembersArea">
						
						</div>
					
					</div> <%-- rightContent 끝 --%>
				
				</div> <%-- chatContents 끝 --%>
				
				
			</div> <%-- contents 끝 --%>
			
		</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>
	
	<script type="text/javascript">
		 var sock = new SockJS('memChatSocket');
		 sock.onopen = function() {
		     console.log('open');
		     // sock.send('test');
		 };
		 
		 sock.onmessage = function(e) {
		     console.log('받은 메시지 : ', e.data);
		     // sock.close();
		     
		     let msgObj = JSON.parse(e.data)
		     
		     switch(msgObj.msgType){
		     
		     	case "m":
		     		printMsg(msgObj);
			     	break;
			     
		     	case "c":
		     		
			     
		     	case "d":
		     		printConn(msgObj);
		     		break;
		     		
		     }
		     
		 };
	
		 sock.onclose = function() {
		     console.log('close');
		 };

	</script>
	
	<script type="text/javascript">
		
		let chatAreaDiv = document.querySelector('#chatArea');
	
		/* <div id="chatArea">
				<div class="conMsg">입장 메세지</div>
				<div class="sendMsg">보낸 메세지</div>
				<div class="receiveMsg">
					<div>
						아이디
					</div>
					<div class="receiveMsgComm">
						받은 메세지
					</div>
				</div>
				<div class="conMsg">퇴장 메세지</div>
			</div> */
		
		function sendMsg(){
			let msg = document.querySelector('#msgInput');
			sock.send(msg.value);
			
			let sendMsgDiv = document.createElement('div');
			sendMsgDiv.classList.add('sendMsgDiv');
			
			let sendMsg = document.createElement('div');
			sendMsg.classList.add('sendMsg');
			sendMsg.innerText = msg.value;
			sendMsgDiv.appendChild(sendMsg);
			
			chatAreaDiv.appendChild(sendMsgDiv);
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
			
			msg.value = "";
		}
			
		function printConn(msgObj){
			
			// 접속 정보 >> 채팅창에 출력
			let conMsgDiv = document.createElement('div');
			conMsgDiv.classList.add('conMsg');
			conMsgDiv.innerText = msgObj.msgId + msgObj.msgComm;
			
			chatAreaDiv.appendChild(conMsgDiv);
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
			   
			
			
			let connMembersAreaDiv = document.querySelector('#connMembersArea');
			
			// 접속 정보 >> 접속자 목록(id="connMembersArea")
			if(msgObj.msgType == 'c'){
				
				// msgType == 'c' >> 접속자 목록에 추가
				let connMemberDiv = document.createElement('div');
				connMemberDiv.classList.add('connMember');
				connMemberDiv.innerText = msgObj.msgId;
				
				connMemberDiv.setAttribute("id", msgObj.msgId);
				
				connMembersAreaDiv.appendChild(connMemberDiv);
			}
			else{
				// msgType == 'd' >> 접속자 목록에서 삭제
				// msgObj.msgId >> 접속을 해제한 아이디
				// Element.remove();
				
				document.querySelector("#" + msgObj.msgId).remove();
				
				/* let idList = document.querySelectorAll('.connMember');
				for(let i=0;i<idList.length;i++){
					if(idList[i].innerText == msgObj.msgId){
						idList[i].remove();
					}
				} */
			}
			
			
		}
		
		function printMsg(msgObj){
			let receiveMsgDiv = document.createElement('div');
			receiveMsgDiv.classList.add('receiveMsg')
			
			let receiveMsgId = document.createElement('div');
			receiveMsgId.classList.add('receiveMsgId');
			receiveMsgId.innerText = msgObj.msgId;
			
			let receiveMsgComm = document.createElement('div');
			receiveMsgComm.classList.add('receiveMsgComm');
			receiveMsgComm.innerText = msgObj.msgComm;
			
			receiveMsgDiv.appendChild(receiveMsgId);
			receiveMsgDiv.appendChild(receiveMsgComm);
			
			chatAreaDiv.appendChild(receiveMsgDiv);
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
		}
	</script>
	
	<script type="text/javascript">
		let msgInputTag = document.querySelector('#msgInput');
		msgInputTag.addEventListener('keyup', function(e){
			if(e.keyCode == 13){
				sendMsg();
			}
		});
	</script>

</html>