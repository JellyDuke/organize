<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
    </head>

    <body>
        <div id="header">
             Main.jsp
        </div>

        <%@ include file="/Menu.jsp" %>

        <div id="contents">
            <h1>컨텐츠 영역</h1>
            <h2>로그인 아이디 : ${sessionScope.loginMemberId}</h2>
        </div>

    </body>

    <script src="${pageContext.request.contextPath}/JS/main.js"></script>

</html>