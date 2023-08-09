<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅페이지</title>
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
		background-image: url(https://cdn.pixabay.com/photo/2022/08/24/11/10/autumn-7407475_640.jpg);
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
		color: white;
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
		color: black;
		font-weight: bold;
		margin-bottom: 2px;
	}
</style>
</head>
<body>
	
	<h1>ChatPage.jsp - ${sessionScope.loginId }</h1>
	<hr>
	<div id="chatArea">
		
	</div>
	<div id="inputMsg">
		<input type = "text" id = "sendMsg">
		<button  onclick="sendMsg()">전송</button>
	</div>

</body>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script type="text/javascript">
	
	var sock = new SockJS('chatPage');
	sock.onopen = function() {
	    console.log('open');
	  //  sock.send('test');
	};
	
	sock.onmessage = function(e) { //{"msgtype" : "c" , "msgid" : loginId , "msgcomm" : "접속 했습니다."} 
	    // console.log('message', e.data); //{"sendid":"abcd","message":"화요일"}
		
	    // console.log("msgtype : " + msgObj.msgtype); // "c","d","m"
	    // console.log("msgid : " + msgObj.msgid);
	    // console.log("msgcomm : " + msgObj.msgcomm);
		
	    let msgObj = JSON.parse(e.data); //"안내 메세지"
		let mtype = msgObj.msgtype;
		switch(mtype){
			case "m":
				printMessage(msgObj); //메세지 출력기능
				break;
			case "c":
			case "d":
				printConnect(msgObj); //접속 정보 출력 기능
		break;
					};
	//    sock.close();
};

	sock.onclose = function() {
		console.log('close');
	};
</script>
	<script type="text/javascript">
		let chatAreaDiv = document.querySelector('#chatArea');

		function sendMsg() {
			let msgInput = document.querySelector("#sendMsg");
			sock.send(msgInput.value);

			let sendMsgDiv = document.createElement('div');
			sendMsgDiv.classList.add('sendMsg');

			let msgCommDiv = document.createElement('div');
			msgCommDiv.classList.add('msgComment');
			msgCommDiv.innerText = msgInput.value;

			sendMsgDiv.appendChild(msgCommDiv);
			chatAreaDiv.appendChild(sendMsgDiv);

			msgInput.value= "";
		}
	</script>
	
	<script>
		
		function printMessage(msgObj){
			let receiveMsgDiv = document.createElement('div');
			receiveMsgDiv.classList.add('receiveMsgDidv');

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
			let connectDiv = document.createElement('div');
			connectDiv.classList.add('connMsg');
			connectDiv.innerText = msgObj.msgid + "님이 " +msgObj.msgcomm;
			chatAreaDiv.appendChild(connectDiv);
		}
	</script>
</html>