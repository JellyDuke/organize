<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <div id="nav">
        <ul>
           
            
            <li><a href="${pageContext.request.contextPath}/main">게시판</a></li>
            <c:choose>
            <c:when test="${sessionScope.loginMemberId == null}">
	                <%-- 로그인 되어 있지 않으면 적용--%>    
	            <li><a href="${pageContext.request.contextPath}/memJoinForm">회원가입</a></li>
	            <li><a href="${pageContext.request.contextPath}/memLoginForm">로그인</a></li>
            	</c:when>
            
            <c:otherwise>
                <%--로그인이 되어 있으면 적용 --%>
                <li style="color: brown;"> <a href="${pageContext.request.contextPath}/myInfo">${sessionScope.loginMemberId}</a></li>
                <li><a href="${pageContext.request.contextPath}/memLogout">로그아웃</a></li>
            </c:otherwise>
        </c:choose>
            
            <%--로그인이 되어 있지 않은 경우 --%>
        </ul>
    </div>