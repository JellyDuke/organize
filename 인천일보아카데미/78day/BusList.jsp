<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>버스페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>버스 도착정보 페이지 - views/BusList.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>버스 도착정보</h2>
			<table>
				<tr>
					<th>정류소명</th>
					<th>버스번호</th>
					<th>남은 정류장</th>
					<th>도착 예정시간(초)</th>
				</tr>
				
				<c:forEach items="${busList }" var ="bus">
					<tr>
						<td>${bus.nodenm}</td>
						<td>${bus.routeid} 번</td>
						<td>${bus.arrprevstationcnt} 전</td>
						<td>${bus.arrtime} 초 후 도착예정</td>
					</tr>
				</c:forEach>
			</table>
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