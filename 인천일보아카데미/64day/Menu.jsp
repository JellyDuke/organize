<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<div class="nav">
		<ul>
			<li>게시판</li>
			<li onclick="location.href='${pageContext.request.contextPath }/memberJoinForm'">회원가입</li>
			<li onclick="location.href='${pageContext.request.contextPath }/memberLoginForm'">로그인</li>
		</ul>
	</div>