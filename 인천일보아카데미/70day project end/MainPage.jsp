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
				<h2>컨텐츠 영역  ${sessionScope.loginMemberId}</h2>
				<img alt="" src="${pageContext.request.contextPath }/resources/boardUpload/a61e722b-703d-44a9-89c5-2d0a122524e5_다운로드.jpg">
		</div>
			
		</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<script type="text/javascript">
	let msg = '${msg}';
	if(msg.length > 0){
		alert(msg);
	}
	</script>
</html>