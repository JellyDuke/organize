<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="nav">
		<ul>
		<li> <a href="${pageContext.request.contextPath}/busapi">버스 도착 정보</a></li>
		
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