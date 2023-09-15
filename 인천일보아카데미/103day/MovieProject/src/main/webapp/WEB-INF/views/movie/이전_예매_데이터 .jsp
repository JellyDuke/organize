<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>영화예매프로젝트 - MOVIESPROJECT</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath }/resources/users/assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="${pageContext.request.contextPath }/resources/users/css/styles.css"
	rel="stylesheet" />
<style type="text/css">
.selectList {
	cursor: pointer;
	border: 1px solid black;
	border-radius: 5px;
	margin-bottom: 3px;
	margin-top: 3px;
	padding: 3px;
}

.selectList:hover {
	background-color: black;
	color: white;
	font-weight: bold;
}

.selectObj {
	background-color: black;
	color: white;
	font-weight: bold;
}

.selectArea {
	overflow: scroll;
	height: 500px;
}

.selMoviePoster {
	height: 300px;
	font-weight: 300px;
}
</style>
</head>
<body>
	<!-- 메뉴시작 -->
	<!-- Responsive navbar-->
	<%@ include file="/WEB-INF/views/include/menu.jsp"%>
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
					<div style="text-align: center; margin-top: 7px">영화</div>
						<div class="card-body p-2 selectArea" id="movArea">
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6">
				<div class="card mb-4">
					<div style="text-align: center;margin-top: 7px">극장</div>
						<div class="card-body p-2 selectArea" id="thArea">

					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6">날짜</div>

			<div class="col-lg-3 col-md-6">상영관 및 시간</div>



		</div>

		<div class="row">
			<div class="col-lg-4">
				<div class="card mb-4">
					<div class="card-body p-2" id="movieInfoArea">
						<img id="selPoster" class="selMoviePoster" alt="" src="">
						<p id="selTitle" class="card-text">영화 선택</p>
					</div>
				</div>
			</div>

			<div class="col-lg-5">
				<div class="card mb-4">
					<div class="card-body p-2"></div>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="card mb-4">
					<div class="card-body p-2">
						<button class="btn btn-danger w-100 p-5">예매하기</button>
					</div>
				</div>
			</div>

		</div>
		<!-- 컨텐츠 끝 -->

	</div>

	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- JQUERY -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			//1. 예매 가능한 영화 목록 조회 - json
			let mvList = getReserveMovieList('ALL');
			//2. 예매 가능한 극장 목록 조회 - json
			let thList = getReserveTheaterList('ALL');
			//3. 영화목록 출력
			printMovieList(mvList);
			//4. 극장목록 출력
			printTheaterList(thList);
		})
	</script>

	<script type="text/javascript">
		function getReserveMovieList(selectTheaterCode) {
			console.log('예매 가능한 영화 목록 조회 요청');
			let movieList = '';
			$.ajax({
				type : 'get',
				url : 'getMovieList_json',
				data:{'selThCode' : selectTheaterCode},
				dataType : 'json',
				async : false,
				success : function(result){
					console.log("영화목록_json");
					console.log(result);
					movieList = result;
					
				}
			})
			return movieList;
		}
		
		let reserve_mvcode = null; //선택한 영화 코드를 저장할 변수
		let reserve_thcode = null; //선택한 극장 코드를 저장할 변수
		
		function printMovieList(movList) {
			console.log('영화 목록 출력');
			let movArea_Div = document.querySelector('#movArea');
			movArea_Div.innerHTML ='';
			
			for(let mvinfo of movList){
				let mv_Div = document.createElement('div');
				mv_Div.innerText = mvinfo.mvtitle;
				mv_Div.classList.add('selectList');
				mv_Div.classList.add('selEl');
				mv_Div.addEventListener('click',function(e){
					
					reserve_mvcode = mvinfo.mvcode;
					
					//영화목록에 모든 영화에 STYLE.(.selectObj) 제거
					removeSelectStyle('movArea');
					
					//선택된 영화 강조 STYLE 추가
					mv_Div.classList.add('selectObj');
					
					console.log('선택영화 코드 : ' + mvinfo.mvcode);
					
					//2. 선택된 제목, 포스터 출력
					document.querySelector('#selTitle').innerText = mvinfo.mvtitle;
					document.querySelector('#selPoster').setAttribute('src',mvinfo.mvposter);
					
					//1. 극장목록 조회 및 출력(영화코드)
					if(reserve_thcode == null){
						
					let thList = getReserveTheaterList(mvinfo.mvcode);
					printTheaterList(thList);
					
					}
					
				})
				
				movArea_Div.appendChild(mv_Div);
			}
		}
		
		
		function getReserveTheaterList(selectMovieCode) {
			console.log('예매 가능한 극장 목록 조회 요청');
			let theaterList = [];
			$.ajax({
				type : 'get',
				url : 'getTheaterList_json',
				data: {'selMvcode' : selectMovieCode},
				dataType : 'json',
				async : false,
				success : function(result){
					theaterList = result;	
				}
			})
			return theaterList;
		}
		function printTheaterList(thList){
			console.log("극장 목록 출력");
			
			let thArea_Div = document.querySelector('#thArea');
			thArea_Div.innerText = '';
			
			for(let thinfo of thList){
				let th_Div = document.createElement('div');
				th_Div.innerText = thinfo.thname;
				th_Div.setAttribute('id',thinfo.thcode);
				th_Div.classList.add('selectList');
				th_Div.classList.add('selEl');
				
				th_Div.addEventListener('click', function(e){
					
					//reserve_thcode 변수에 극장코드 저장
					reserve_thcode = thinfo.thcode;

					//극장목록에 모든 영화에 STYLE.(.selectObj) 제거
					removeSelectStyle('thArea');
					
					//선택된 극장 강조 STYLE 추가
					th_Div.classList.add('selectObj');
					
					//영화 목록 조회
					if(reserve_mvcode == null){
						console.log('영화목록 조회');
						let movieList = getReserveMovieList(thinfo.thcode);
						printMovieList(movieList);
					}
					
				})
				
				thArea_Div.appendChild(th_Div);
				
			} 
		}	
		function removeSelectStyle(areaId) {
			//#movArea > .selectList
			let aredDIV = document.querySelectorAll('#'+areaId+">.selEl");
			for(let el of aredDIV){
				el.classList.remove('selectObj');
			}
	}
	</script>


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

