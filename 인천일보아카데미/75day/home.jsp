<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
	#chatArea{
		border: 2px solid black;
		width: 500px;
		padding: 10px;
		margin-left: auto;
		margin-right: auto;
	}
	.receiveMsg{
		margin-bottom: 3px;
	}
	.sendMsg{
		text-align: right;
	}
	#sendMsg{
		overflow: scroll;
		width: 94%;
		height: 100px;
	}
	#sendMsg::-webkit-scrollbar{
		 width: 4px;
		}
	</style>
	
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
	<div id="chatArea">
		<input type="text" id = "sendMsg">
		<button onclick="msgSend()">전송</button>
		<hr>
		<div class="receiveMsg">
			<!-- 받은 메세지 -->
			받은 메세지 출력
		</div>
		
		<div class="sendMsg">
			<!-- 보낸 메세지 -->
			보낸 메세지 출력
		</div>
	</div>
	
	
	
	
</body>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	
	<script type="text/javascript">
		let chatAreaDiv = document.querySelector('#chatArea');
		
		var sock = new SockJS('chatSocket');
		sock.onopen = function() {
	     console.log('open');
	    // sock.send('test'); 서버로 메세지 전송
	 };

	 sock.onmessage = function(e) {
		 console.log('받은 메세지 : ', e.data);
		 //  sock.close();
	   
		 let receiveMsgDiv = document.createElement('div');
		 receiveMsgDiv.classList.add('receiveMsg');
		 receiveMsgDiv.innerText = e.data;
		 chatAreaDiv.appendChild(receiveMsgDiv);
		};
		
		sock.onclose = function() {
			console.log('close');
		};
		</script>
	
	<script type="text/javascript">
		
		function msgSend() {
			let msgInput = document.querySelector("#sendMsg");
			//console.log("보낸 메세지 : " +msgInput.value);
			sock.send(msgInput.value); //chat 서버로 전송
			
			let sendDiv = document.createElement('div');
			sendDiv.classList.add('sendMsg');
			sendDiv.innerText = msgInput.value;

			chatAreaDiv.appendChild(sendDiv);
			
			msgInput.value = "";//input태그 초기화
		}
		
	</script>
</html>
