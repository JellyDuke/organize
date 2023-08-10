	
	
	
	
	var noticeSock = new SockJS('noticeSocket');
	noticeSock.onopen = function() {
	     console.log('open');
	     noticeCheck();
	 };

	 noticeSock.onmessage = function(e) {
		 noticeAlert(e.data);
	 };

	 noticeSock.onclose = function() {
	     console.log('close');

	 };
	 
	 function noticeAlert(msgObj) {
			toastr.info('새 글이 등록 되었습니다.')
	}