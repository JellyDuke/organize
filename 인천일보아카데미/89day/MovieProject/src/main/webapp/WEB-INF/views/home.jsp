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
    	<!-- 메뉴시작 -->
        <!-- Responsive navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath }/">MOVIES PROJECT</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="#">영화</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">예매</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">메뉴1</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/">메뉴2</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- 메뉴 끝 -->
        
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">메인페이지</h1>
                    <p class="lead mb-0">영화 랭킹 1위 ~ 6위 목록 출력</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            <div class="row">
               
                <!-- Blog entries-->
                <div class="col-lg-8">
                
                    <!-- Nested row for non-featured blog posts-->
                    <div class="row">
                        <c:forEach begin="1" end="6" step="1">
	                        <div class="col-lg-4"> <!-- COL -lg-6 크기 12등분중 6칸을 쓴다. -->
	                            <!-- Blog post-->
	                            <div class="card mb-4">
	                                <a href="/영화정보페이지?mvcode=??"><img class="card-img-top" src="data:image/jpeg;base64,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" alt="..." /></a>
	                                <div class="card-body">
	                                    <div class="small text-muted">예매율</div>
	                                    <h2 class="card-title h4">호머 심슨........ 마법사 되다</h2>
	                                    <a class="btn btn-danger" href="#!">호머심슨 보기 →</a>
	                                </div>
	                            </div>	
	                        </div>
                        </c:forEach>
                        </div>
                    </div>
                
                <!-- Side widgets-->
                <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header">Search</div>
                        <div class="card-body">
                            <div class="input-group">
                                <input class="form-control" type="text" placeholder="Enter search term..." aria-label="Enter search term..." aria-describedby="button-search" />
                                <button class="btn btn-primary" id="button-search" type="button">Go!</button>
                            </div>
                        </div>
                    </div>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header">회원메뉴</div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">예매내역</a></li>
                                        <li><a href="#!">HTML</a></li>
                                        <li><a href="#!">Freebies</a></li>
                                    </ul>
                                </div>
                                <div class="col-sm-4">
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="#!">회원정보</a></li>
                                        <li><a href="#!">로그아웃</a></li>
                                        <li><a href="#!">Tutorials</a></li>
                                    </ul>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header">Side Widget</div>
                        <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use, and feature the Bootstrap 5 card component!</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

