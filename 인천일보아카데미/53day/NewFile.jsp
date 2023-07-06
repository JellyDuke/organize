<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTP-8">
<title>Insert title here</title>
</head>
<body>
	<% String str = "JSP 페이지 입니다." ;%>
	<%//스크립틀릿 =이 붙으면 이 영역에 사용을 하겠다는 뜻. <%=str.. %>
	<h1><%=str %></h1>
	<% for(int i = 0; i<5; i++){ %>
	<h1><%=i %></h1>
	<%} %>
	
	
	
</body>
</html>