<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	ul{
		display: flex;
		list-style-type: none;
	}
	ul>li{
		padding: 10px;
	}
</style>
	<script>
		let check = '${param.check}';
		console.log("check:" +check);
		if(check =='y'){
			alert('회원가입에 성공 했습니다.')
		}
	</script>
</head>
	<body>
		<h1>mainPage.jsp</h1>
		<p> ${pageContext.request.contextPath}</p>

	</body>
	<ul>
	<!-- web-inf는 숨김처리된 파일이다. 외부에서 파일을 볼 수 없다. -->
		<li><a href=" ${pageContext.request.contextPath}/mainPage">메인</a></li>
		<li> <a href="${pageContext.request.contextPath}/joinForm">회원가입</a> </li>
		<li><a href=" ${pageContext.request.contextPath}/loginForm">로그인</a></li>
		<li> <button onclick="location.href=''"> 게시판 </button>
	</ul>
</html>






