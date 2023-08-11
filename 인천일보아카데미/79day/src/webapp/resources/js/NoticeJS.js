/**
 * 
 */
 		 function connectNotice(noticeMsg){
	 		 var noticeSock = new SockJS('noticeSocket');
	 		 
			 noticeSock.onopen = function() {
				 console.log('noticeSocket 접속');
				 if(noticeMsg.length > 0){
				 	noticeSock.send(noticeMsg);
				 }
			 };
			 
			 noticeSock.onmessage = function(e) {
			     noticeAlert(e.data);
			 };
		
			 noticeSock.onclose = function() {
			     console.log('noticeSocket 접속해제');
			 };
			 
			 return noticeSock;
		}
		
		function noticeAlert(msgjson){
			 let msgObj = JSON.parse(msgjson);
			 let mtype = msgObj.msgtype;
			 
		     switch(mtype){
			    case "reply":
			    
			    	 toastr.options.onclick = function() {
			    	 	location.href='/controller/boardView?bno=' + msgObj.msgcomm;
			    	 }
			    	 
			    	 toastr.success(msgObj.msgcomm + "번 글에 댓글이 등록되었습니다.");
			    	 break;
		     
		     	case "board":
		     	
		     		 toastr.options.onclick = function() {
			    	 	location.href='/controller/boardList';
			    	 }
		     	
		     		 toastr.info(msgObj.msgcomm);
		     		 break;
		     		
		     }
		}