<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅페이지</title>
</head>
<body>
	<h1>ChatPage.jsp - ${sessionScope.loginId }</h1>
	<input type = "text" id = "sendMsg">
	<button onclick="sendMsg()">전송</button>
	<hr>
	
</body>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
	var sock = new SockJS('chatPage');
	sock.onopen = function() {
	    console.log('open');
	  //  sock.send('test');
	};
	
	sock.onmessage = function(e) {
	    console.log('message', e.data); //{"sendid":"abcd","message":"화요일"}
	    let msgObj = JSON.parse(e.data);
	    console.log("sendid : " + msgObj.sendid);
	    console.log("message : " + msgObj.message);
	  //  sock.close();
	};
	
	sock.onclose = function() {
	    console.log('close');
	};
</script>
	<script type="text/javascript">
		function sendMsg() {
			let msgInput = document.querySelector("#sendMsg");
			sock.send(msgInput.value);
		}
	</script>
</html>