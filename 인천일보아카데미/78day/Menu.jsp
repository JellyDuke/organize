<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<div class="nav">
		<ul>
		<li> <a href="${pageContext.request.contextPath}/memberChatPage">회원채팅</a></li>
		<li> <a href="${pageContext.request.contextPath}/busapi">버스 도착 정보</a></li>
		<li> <a href="${pageContext.request.contextPath}/busapi_ajax">버스 도착 정보_ajax</a></li>
		<li> <a href="${pageContext.request.contextPath}/tagoBus">new_Tago</a></li>
			<c:choose>
				<%--로그인 안되어 있으면 --%>
				<c:when test="${sessionScope.loginMemberId == null}">
					<li onclick="location.href='${pageContext.request.contextPath }/memberJoinForm'">회원가입</li>
					<li onclick="location.href='${pageContext.request.contextPath }/memberLoginForm'">로그인</li>
				</c:when>
				
			<c:otherwise>
				<%--로그인 되어있으면 --%>
				<li onclick="location.href='${pageContext.request.contextPath }/boardList'">게시판</li>
				<li onclick="location.href='${pageContext.request.contextPath }/boardWriteForm'">글쓰기</li>
				<li onclick="location.href='${pageContext.request.contextPath }/memberLogout'">로그아웃</li>
				<li onclick="location.href='${pageContext.request.contextPath }/myInfo'">내정보</li>
			</c:otherwise>
			
		</c:choose>
		
		</ul>
		
	</div>
	
	
	
	<!-- 모든 페이지에 적용을 해야 알람이 된다. -->
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
	<!-- Socket -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<!-- NOTICEJS JS -->
	<script src="${pageContext.request.contextPath }/resources/js/NoticeJs.js"></script>
	
	

	
	<script type="text/javascript">

		function toastrOn() {
		toastr.options = {
			"positionClass": "toast-bottom-right"
		}
		toastr.info('새 글이 등록 되었습니다.')
			
		}
	
	</script>