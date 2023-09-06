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
    	<style type="text/css">
    		.selectList{
    			cursor: pointer;
    			border: 1px solid black;	
    			border-radius: 5px;
    			margin-bottom: 3px;
    			margin-top: 3px;
    			padding: 3px;
    		}
    		.selectList:hover{
    			background-color: pink;
    		}
    		.selectObj{
    			background-color: pink;
    		}
    	</style>
    </head>
    <body>
    	<!-- 메뉴시작 -->
        <!-- Responsive navbar-->
        <%@ include file="/WEB-INF/views/include/menu.jsp" %>
        <!-- 메뉴 끝 -->
        
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">영화 예매 페이지 - ReservePage.jsp</h1>
                    <p class="lead mb-0">영화, 극장 날짜 선택 및 결제 페이지</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
        
            <!-- 컨텐츠 시작 -->
            <div class="row">
            	<div class="col-lg-3 col-md-6">
					<div class="card mb-4">
						<div class="card-body p-2" id="movArea">
						 	<div class="selectList">영화 1</div>
						 	<div class="selectList">영화 2</div>
						 	<div class="selectList">영화 3</div>
						</div>
					</div>
            	</div>
            	
            	<div class="col-lg-3 col-md-6">
	            	<div class="card mb-4">
						<div class="card-body p-2">
							 <div class="selectList">극장 1</div>
							 <div class="selectList">극장 2</div>
							 <div class="selectList">극장 3</div>
						</div>
					</div>
            	</div>
            	<div class="col-lg-3 col-md-6">
            		날짜
            	</div>
            	<div class="col-lg-3 col-md-6">
            		상영관 및 시간
            	</div>
            </div>
            
            <div class="row">
            	선택정보 출력
            </div>
            <!-- 컨텐츠 끝 -->    
            
        </div>
        
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    	<script type="text/javascript">
    		let movAreaEl = document.querySelectorAll('#movArea div.selectList');
    		console.log(movAreaEl);
    		
    		for(let movEl of movAreaEl){
				movEl.addEventListener('click',function(e){
					console.log(e.target.innerText);
					console.log(movEl.innerText);
				})    			
    		}
    	</script>
    </body>
</html>

