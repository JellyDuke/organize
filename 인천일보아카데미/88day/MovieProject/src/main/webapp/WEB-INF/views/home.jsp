<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
	
	<a href="/getCgvMovieInfo">CGV 영화 정보 수집</a>
	<br> <br>
	<a href="/getCgvTheaterInfo">CGV 극장 정보 수집</a>
	<br> <br>
	<a href="/getCgvScheduleInfo">CGV 상영 시간표 수집</a>
	<hr>
	<form action="/mapperTest">
		<input type="text" name="thcode" placeholder="극장코드">
		<input type="submit" value="극장선택">
	</form>
</body>
</html>
