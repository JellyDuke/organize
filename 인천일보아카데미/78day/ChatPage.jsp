<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
		#inputMsg>input{
			width: 100%;
			padding: 5px;
		}
		#inputMsg>button{
			width: 100px;
			padding: 5px;
		}
		#inputMsg{
			display: flex;
			box-sizing: border-box;
			border: 1px solid black;
			border-radius: 10px;
			width:450px;
			padding: 10px;
		}
	
		#chatArea{
			box-sizing: border-box;
			border: 1px solid rgb(0, 0, 0);
			border-radius: 10px;
			width: 450px;
			padding: 10px;
			height: 600px;
			overflow: scroll;
			background-image: url(https://cdn.pixabay.com/photo/2016/01/09/18/28/notepad-1130743_640.jpg);
		}
		#chatArea::-webkit-scrollbar{
			 width: 0px;
			}
		#sendMsg::-webkit-scrollbar{
			 width: 0px;
			}
		.sendMsg{
			text-align: right;	
			margin-bottom: 3px;
		}
		.connMsg{
			text-align: center;
			background-color: #000000b6;
			border-radius: 30px;
			color: rgb(255, 255, 255);
			margin-bottom: 3px;
		}
		.msgComment{
			color: black;
			padding: 7px;
			display: inline-block;
			border-radius: 16px;	
			background-color: white;
			border: 1px solid black;
		}
		.msgId{
			color: rgb(255, 255, 255);
			font-weight: bold;
			margin-bottom: 2px;
		}
		#chatContents{
			display: flex;
			
		}
		#leftContent{
			margin: 5px;
		}
		#rightContent{
			margin-left: 10px;
			margin-top: 105px;	
			width: 200px;
		}
		#connMembersArea{
			box-sizing: border-box;
			border: 1px solid black;
			border-radius: 10px;
			height: 600px;
			overflow: scroll;
			/* padding: 7px; */
		}
		#connMembersArea::-webkit-scrollbar{
			 width: 0px;
			}
		.connMember{
			border: 1px solid black;
			border-radius: 10px;
			padding: 5px;
			margin: 5px;
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
				<div id = "chatContents">
					<div id = "leftContent">
						<h1>로그인 아이디: ${sessionScope.loginMemberId}</h1>
						<hr>
						<div id="chatArea"></div>
						<div id="inputMsg">
							<input type = "text" id = "sendMsg">
							<button onclick="sendMsg()">전송</button>
						</div>
					</div>

					<div id="rightContent">
						<div id="connMembersArea">
							
						</div>
					</div>
				</div>

			</div>
			
		</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
	
	<script type="text/javascript">
	 var sock = new SockJS('chatPage');
	 sock.onopen = function() {
	     console.log('open');
	    //  sock.send('test');
	 };

	 sock.onmessage = function(e) {
	    // console.log('message', e.data);
		//  sock.close();
		let msgObj = JSON.parse(e.data);
		let mtype = msgObj.msgtype;
		switch(mtype){
			case "m":
				printMessage(msgObj);
				break;
			case "c":
			case "d":
				printConnect(msgObj);
				break;
		}
	 };

	 sock.onclose = function() {
	     console.log('close');
	 };

	</script>	
	<script>
		//엔터키로 메세지 보내기
		let msgInputTag = document.querySelector("#sendMsg");
		msgInputTag.addEventListener('keyup',function(e){
			if(e.keyCode == 13){
				sendMsg();
			}
		})
	</script>

	<script>
		let chatAreaDiv = document.querySelector('#chatArea');
		function sendMsg(){
			//보내는 메세지 출력
			let msgInput = document.querySelector("#sendMsg");
			sock.send(msgInput.value);

			let sendMsgDiv = document.createElement('div');
			sendMsgDiv.classList.add('sendMsg');

			let msgCommDiv = document.createElement('div');
			msgCommDiv.classList.add('msgComment');
			msgCommDiv.innerText = msgInput.value;

			sendMsgDiv.appendChild(msgCommDiv);
			chatAreaDiv.appendChild(sendMsgDiv);

			msgInput.value="";
		}
	</script>

	<script>
		function printMessage(msgObj){
			//받는 메세지 출력
			let receiveMsgDiv = document.createElement('div');
			receiveMsgDiv.classList.add('receiveMsgDiv');

			let msgIdDiv = document.createElement('div');
			msgIdDiv.classList.add('msgId');
			msgIdDiv.innerText = msgObj.msgid;

			receiveMsgDiv.appendChild(msgIdDiv);

			let msgCommentDiv = document.createElement('div');
			msgCommentDiv.classList.add('msgComment');
			msgCommentDiv.innerText = msgObj.msgcomm;
			receiveMsgDiv.appendChild(msgCommentDiv);

			chatAreaDiv.appendChild(receiveMsgDiv);

		}

		function printConnect(msgObj){
			//접속 정보 >> 채팅창에 출력
			let connectDiv = document.createElement('div');
			connectDiv.classList.add('connMsg');
			connectDiv.innerText = msgObj.msgid + "님이 " +msgObj.msgcomm;
			chatAreaDiv.appendChild(connectDiv);
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;

			// 접속 정보 >> 접속자 목록(id = "connMembersArea")
			let connMembersAreaDiv = document.querySelector("#connMembersArea");
			
			if(msgObj.msgtype == 'c'){
				//msgtype == 'c' >> 접속자 목록에 추가
				let connMemberDiv = document.createElement('div');
				connMemberDiv.classList.add('connMember');
				connMemberDiv.setAttribute('id',msgObj.msgid);

				connMemberDiv.innerText = msgObj.msgid;

				connMembersAreaDiv.appendChild(connMemberDiv);
				
			}else{
				//msgtype == 'd' >> 접속자 목록에서 삭제
				//msgObj.msgid >> 접속을 해제한 아이디
				//Element.remove();
				document.querySelector("#"+msgObj.msgid).remove();
			}

		}

	</script>
</html>