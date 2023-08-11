<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>메인 페이지 - views/MainPage.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				
				<button onclick="sendTest()">클릭!</button>
				
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
	
	<script type="text/javascript">
		function sendTest(){
			
			let noticeObj = { "noticeType" : "board" };
			
			noticeSock.send(JSON.stringify(noticeObj));
		}
	</script>
	

</html>