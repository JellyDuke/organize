<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>영화예매프로젝트 - MOVIESPROJECT</title>
        <!-- Favicon-->
     	   <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/users/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath }/resources/users/css/styles.css" rel="stylesheet" />
    </head>
    <body>
    
    	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">
        	let payResult = '${payResult}';
        	if(payResult == 'Y'){
        		/*insert 성공, 결제 성공*/
        		//부모창에 예매가 되었습니다.
        		//window.opener.location.href="/";
        		window.opener.reserveResult_success();

        	}else{
        		/*insert 성공, 결제 실패*/
        		window.opener.failReserve();
        	}
        	window.close();
        </script>
    </body>
</html>

