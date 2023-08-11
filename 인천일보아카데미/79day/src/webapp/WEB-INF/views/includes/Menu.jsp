<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<!-- TOASTR JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	<!-- sockJs -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	
	<!-- Notice JS -->
	<script src="${pageContext.request.contextPath }/resources/js/NoticeJS.js"></script>
	
	<script type="text/javascript">
		let noticeSock = connectNotice('${noticeMsg}');
	</script>
	
	<div class="nav">
	
		<ul>
			<li onclick="location.href='${pageContext.request.contextPath}/memberChatPage'">회원채팅</li>
		
			<li onclick="location.href='${pageContext.request.contextPath}/tagoBus'">tagoBus</li>
		
			<li onclick="location.href='${pageContext.request.contextPath }/busapi'">버스 도착 정보</li>
			
			<li onclick="location.href='${pageContext.request.contextPath }/busapi_ajax'">버스 도착 정보_ajax</li>
			
			<li onclick="location.href='${pageContext.request.contextPath }/boardList'">게시판</li>
			<c:choose>
				<%-- 로그인이 X --%>
				<c:when test="${sessionScope.loginMemberId == null}">
					<li onclick="location.href='${pageContext.request.contextPath }/memberJoinForm'">회원가입</li>
					<li onclick="location.href='${pageContext.request.contextPath }/memberLoginForm'">로그인</li>
				</c:when>
			
				<%-- 로그인이 O --%>
				<c:otherwise>
					<li onclick="location.href='${pageContext.request.contextPath }/myInfoMpwCheck'">${sessionScope.loginMemberId }</li>
					<li onclick="location.href='${pageContext.request.contextPath }/memberLogout'">로그아웃</li>					
				</c:otherwise>
			
			</c:choose>
		</ul>
	</div>