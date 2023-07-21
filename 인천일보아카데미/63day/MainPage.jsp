<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
</head>
<body>
    <div class="mainWrap">
        <div class= "header" style="background-image: url(https://cdn.pixabay.com/photo/2017/07/15/21/46/sunflower-2507845_640.png);">
            <h1>메인페이지 - views/MainPage.jsp</h1>
        </div>
        <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
        <div class="contents" style="background-image: url('https://cdn.pixabay.com/photo/2017/06/01/02/21/marble-2362267_640.jpg');">
            <h2>컨텐츠 영역</h2>
        </div>
    </div>
</body>

<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</html>