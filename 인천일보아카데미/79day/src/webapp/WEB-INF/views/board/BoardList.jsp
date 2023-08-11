<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>글 목록 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
	
		.formWrap{
			margin-left: auto;
			margin-right: auto;
			border: 3px solid black;
			border-radius: 14px;
			width: 600px;
			padding: 20px;
		}
		
		h2{
			text-align: center;
		}
		
		.formRow{
			border: 1px solid black;
			display: flex;
			align-items: center;
			justify-content: center;
			margin: 10px;
			padding: 5px;
			border-radius: 7px;
			text-align: center;
		}
		
		.bwriter{
			width: 100px;
		}
		.btitle{
			width: 350px;
		}
		.bhits{
			width: 100px;
		}
		
		button{
			margin-left: 10px;
			margin-top: 5px;
			width: 100px;
			border-radius: 15px;
			cursor: pointer;
		}
		
	</style>
	
	<script src="https://kit.fontawesome.com/b213412e2c.js" crossorigin="anonymous"></script>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>글 목록 페이지 - views/board/BoardList.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호 -->
			
			<div class="formWrap">
			
				<div>
					<h2>게시판 페이지 - ${noticeMsg }</h2>
				</div>
			
				<div id="btitle" class="formRow">
					<table>
						<tr>
							<th class="bwriter">작성자</th>
							<th class="btitle">글제목</th>
							<th class="bhits">조회수</th>
						</tr>
					</table>
				</div>
				
				<div id="boardList" class="formRow">
					<table>
						<c:forEach items="${boardList }" var="board">
							<tr>
								<td class="bwriter">${board.bwriter }</td>
								<td class="btitle" onclick="location.href='${pageContext.request.contextPath }/boardView?bno=${board.bno }'" style="cursor: pointer;">
									${board.btitle }
									<c:if test="${board.bfilename != null }">
										<i class="fa-regular fa-image"></i>
									</c:if>
									<i class="fa-regular fa-comment-dots"></i>
									${board.recount }
								</td>
								<td class="bhits">${board.bhits }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				<c:if test="${sessionScope.loginMemberId != null }">
					<div>
						<button onclick="location.href='${pageContext.request.contextPath }/boardWriteForm'">글쓰기</button>
					</div>
				</c:if>
				
			</div>
			
		</div>
	</div>
	<%-- 
	<hr>
	
	<div class="mainWrap">
	
		<div class="header">
			<h1>글 목록 페이지 - views/board/BoardList.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호 -->
			
			<div class="formWrap">
			
				<div>
					<h2>게시판 페이지</h2>
				</div>
			
				<div id="btitle" class="formRow">
					<table>
						<tr>
							<th class="bwriter">작성자</th>
							<th class="btitle">글제목</th>
							<th class="bhits">조회수</th>
						</tr>
					</table>
				</div>
				
				<div id="boardList" class="formRow">
					<table>
						<c:forEach items="${boardList_Map }" var="boardMap">
							<tr>
								<td class="bwriter">${boardMap.BWRITER }</td>
								<td class="btitle" onclick="location.href='${pageContext.request.contextPath }/boardView?bno=${boardMap.BNO }'" style="cursor: pointer;">
									${boardMap.BTITLE }
									<c:if test="${boardMap.BFILENAME != null }">
										<i class="fa-regular fa-image"></i>
									</c:if>
									<i class="fa-regular fa-comment-dots"></i>
									${boardMap.RECOUNT }
								</td>
								<td class="bhits">${boardMap.BHITS }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				<c:if test="${sessionScope.loginMemberId != null }">
					<div>
						<button onclick="location.href='${pageContext.request.contextPath }/boardWriteForm'">글쓰기</button>
					</div>
				</c:if>
				
			</div>
			
		</div>
	</div> --%>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }'
		if(msg.length > 0){
			alert(msg);
		}
	</script>
	
	<script type="text/javascript">
		function noticeCheck(){
			let noticeMsg = '${noticeMsg }';
			if(noticeMsg.length > 0){
				let noticeObj = { "noticeType" : "board" };
				noticeSock.send(JSON.stringify(noticeObj));
			}
		}
	</script>

</html>