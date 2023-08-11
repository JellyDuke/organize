<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
		<meta charset="UTF-8">
		<title>버스 도착 정보 페이지</title>
		<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<style type="text/css">
		
			h2{
				text-align: center;
			}
		
			.mainTitle{
				border: 1px solid black;
				display: flex;
				align-items: flex-start;
				justify-content: center;
				margin: 10px;
				padding: 5px;
				padding-top: 10px;
				border-radius: 7px;
				text-align: center;
				min-height: 300px;
			}
			
			p{
				margin: 0 20px;
			}
			
		</style>
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>버스 도착 정보 페이지 - views/BusList.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>버스 도착 정보</h2>
				<%-- 정류소명, 노선번호, 남은정류장수, 도착예정시간 --%>
				<div class="mainTitle">
					<table>
						<div class="busTitle">
							<tr>
								<th><p>정류소명</p></th>
								<th><p>노선번호</p></th>
								<th><p>남은정류장수</p></th>
								<th><p>도착예정시간</p></th>
							</tr>
						</div>
					
					<c:forEach items="${busList }" var="bus">
						<div class="busContents">
							<tr>
								<td><p>${bus.nodenm }</p></td>
								<td><p>${bus.routeno }번</p></td>
								<td><p>${bus.arrprevstationcnt }전</p></td>
								<td><p>${bus.arrtime }초 후 도착예정</p></td>
							</tr>
						</div>
					</c:forEach>
					
					</table>
				
				</div>
				
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

</html>