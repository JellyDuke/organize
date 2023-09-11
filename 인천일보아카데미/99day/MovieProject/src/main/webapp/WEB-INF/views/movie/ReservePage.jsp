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

.unselectList{
	cursor: pointer;
	border: 1px solid lightgray;
	border-radius: 5px;
	margin-bottom: 3px;
	margin-top: 3px;
	padding: 3px;
	color:lightgray;
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
							<c:forEach items = "${movList }" var = "mv">
								<div class="selectList selEl" id ="${mv.mvcode }"
									 onclick="movieClick(this, '${mv.mvcode}','${mv.mvposter }')">${mv.mvtitle }</div>
							</c:forEach>
						</div>
					</div>
				</div>

			<div class="col-lg-3 col-md-6">
				<div class="card mb-4">
					<div style="text-align: center;margin-top: 7px">극장</div>
						<div class="card-body p-2 selectArea" id="thArea">
							<c:forEach items = "${thList }" var = "th">
								<div class="selectList selEl" id="${th.thcode }" 
									 onclick="theaterClick(this,'${th.thcode}')">${th.thname }</div>
							</c:forEach>
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
						<p id="selName" class="card-text">극장 선택</p>
						
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
	
		function movieClick(selectMVObj, mvcode, mvposter) {
			console.log("movieClick() 호출");
			//selectMVObj : 스타일 변경, mvcode : 극장목록 조회, selectMVObj.innerText : 선택항목 출력 ,mvposter : 선택항목 출력
			
			//1. 선택 항목 출력
			document.querySelector('#selTitle').innerText = selectMVObj.innerText;
			document.querySelector('#selPoster').setAttribute('src',mvposter);
			
			//2. 선택 항목 스타일 변경
			addSelectStyle(selectMVObj);
			
			//3. 선택한 영화를 예매 할 수 있는 극장 목록 조회
			let thList = getReserveTheaterList(mvcode);
			console.log(thList.length);
			changeTheaterList(thList);
		}
		
		function addSelectStyle(selObj){
			console.log('removeSelectStyle() 호출');

			//부모태그 div selectAll			
			let movDivs = selObj.parentElement.querySelectorAll('div');
			
			//remove select style
			for(let movEl of movDivs){
				movEl.classList.remove('selectObj');
			}
			//add select style
			selObj.classList.add('selectObj');
		}
		
		function getReserveTheaterList(selectMovieCode){
			console.log('예매 가능한 극장 목록 조회 요청');
			let theaterList = [];
			$.ajax({
				type : 'get',
				url : 'getTheaterList_json',
				data: {'selMvcode' : selectMovieCode},
				async : false,
				dataType : 'json',
				success : function(result){
					theaterList = result;	
				}
			});
			return theaterList;
		}
		
		function changeTheaterList(thList) {
			console.log("changeTheaterList() 호출");
			console.log(thList.length);
			
			let thCodeList = [];
			for(let th of thList){
				thCodeList.push(th.thcode);
			}
			
			let theaterEls = document.querySelectorAll("#thArea>div.selEl");
			
			let thArea = document.querySelector('#thArea');
			
			for(let thEl of theaterEls){
				thEl.classList.remove('selectList');
				thEl.classList.remove('unselectList');

				if(thCodeList.includes(thEl.getAttribute('id'))){
					//예매 가능한 극장
					thEl.classList.add('selectList');
				}else{
					//예매 불가능한 극장
					thEl.classList.add('unselectList');
					thArea.appendChild(thEl);
				}			
			}
		}
	</script>
	
	<script type="text/javascript">
		function theaterClick(selectTHObj, thcode){
			console.log("theaterClick 호출()");
			console.log(selectTHObj);
			console.log("선택한 극장코드 : " + thcode);

			if(selectTHObj.classList.contains('unselectList')){
				console.log("예매가 불가능한 극장 선택");				
				let reloadCheck = confirm('예매가 불가능한 극장입니다.\n계속 하시겠습니까?');
			
				if(reloadCheck){
					 //페이지 재요청
					location.reload();
				}
			}else{
				console.log("예매가 가능한 극장 선택");
				//1.선택 항목 출력
				document.querySelector('#selName').innerText = selectTHObj.innerText;
				
				//2.선택 항목 스타일 변경
				addSelectStyle(selectTHObj);
		
				//3.선택한 극장에서 예매 할 수 있는 영화 목록 조회
				
			}
		}
	</script>
	
</body>
</html>

