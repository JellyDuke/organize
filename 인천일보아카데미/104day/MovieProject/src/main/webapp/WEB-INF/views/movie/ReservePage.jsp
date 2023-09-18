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
	text-align: center;
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
#selName{
	text-align: center;
}

.csstyle{
	border: 1px solid black;
	color: red;
	font-weight: bold; 
	border-radius: 5px;
}
.inline{
	display: inline-block;
	margin-right: 3px;
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
								<div class="selectList selEl p-2 my-1" id ="${mv.mvcode }" tabindex="0"
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
								<div class="selectList selEl p-2 my-1" id="${th.thcode }" 
									 onclick="theaterClick(this,'${th.thcode}')">${th.thname }</div>
							</c:forEach>
						</div>
					</div>
				</div>

			<div class="col-lg-3 col-md-6">
				<div class="card mb-4">
					<div style="text-align: center;margin-top: 7px">날짜</div>
						<div class="card-body p-2 selectArea" id="dateArea">
						
						</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6">
				<div class="card mb-4">
					<div style="text-align: center;margin-top: 7px">상영관 및 시간</div>
						<div class="card-body p-2 selectArea" id="timeArea">
						
				   	    </div>
				</div>
			</div>



		</div>

		<div class="row">
			<div class="col-lg-4">
				<div class="card mb-4">
					<div class="card-body p-2" id="movieInfoArea">	
						<div style="text-align:center;">선택 영화</div>
						<img id="selPoster" class="selMoviePoster" alt="" src="">
						<p id="selTitle" class="card-text">선택 영화</p>
					</div>
				</div>
			</div>

			<div class="col-lg-5">
				<div class="card mb-4">
					<div class="card-body p-2"></div>
						<p id="selName" class="card-text">극장: <span calss="selInfo" id="selTheater">극장 이름</span></p>
						<p id="selName" class="card-text">일시 날짜: 
							<span class="selInfo" id="selDate">날짜</span>
							<span class="selInfo" id="selTime">날짜</span>
						</p>
						<p id="selName" class="card-text">상영관: <span class="selInfo" id="selHall"></span> 관</p>
				</div>
			</div>
			
			<div class="col-lg-3">
				<div class="card mb-4">
					<div class="card-body p-2">
						<button class="btn btn-danger w-100 p-5 reserveBtn" onclick="movieReserve()">예매하기</button>
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
		function movieReserve(){
			let loginCheck ='${sessionScope.loginId}';
			
			if(loginCheck.length == 0){
				alert('로그인 후 이용 가능합니다.');
				location.href="memberLoginForm";
				
			}else if(reserve_mvcode == null){
				alert('영화를 선택 해주세요!');
			}else if(reserve_thcode == null){
				alert('극장을 선택 해주세요!');
			}else if(reserve_scdate == null){
				alert('날짜를 선택 해주세요!');
			}else if(reserve_schall == null || reserve_schall == null){
				alert('시간을 선택 해주세요');
			}else{
				console.log('예매처리 요청');
				//1. 카카오페이 API 결제준비요청
				kakaoPay_ready();
				
				//registReserveInfo();
			}
		}
	</script>
	<script type="text/javascript">
	
		function kakaoPay_ready() {
			console.log("카카오페이 결제 준비");
			$.ajax({
				type : "post",
				url : "kakaoPay_ready",
				data : {'mvcode' : reserve_mvcode,
					    'thcode' : reserve_thcode,
					    'schall' : reserve_schall,
					    'scdate' : reserve_scdate+" "+reserve_sctime
					    },
				success : function(result) {
					console.log(result);
					window.open(result,"pay","width=400,height=500");
					
				}
			});
		} 
		
		function registReserveInfo() {
			$.ajax({
				type: "post",
				url: "registReserveInfo",
				data: {'mvcode' : reserve_mvcode,
					   'thcode' : reserve_thcode,
					   'schall' : reserve_schall,
					   'scdate' : reserve_scdate+" "+reserve_sctime
					   },
				async: false,
				success : function(result){
					console.log('예매 처리 결과');
					
					if(result == '1'){
						console.log('예매 성공');
						alert('예매되었습니다.');
						location.href="/";
						
					}else{
						console.log('예매 실패');
					}
				}
				
			});
		}		
	
	</script>
	
	<script type="text/javascript">
	
		let reserve_mvcode = null; //선택한 영화 저장 ='mv00001'
		let reserve_thcode = null; //선택한 극장 저장 ='th00001'
		let reserve_scdate = null; //선택한 날짜 저장 ='2023/09/14'
		let reserve_sctime = null; //선택한 시간 저장 ='13:20'
		let reserve_schall = null; //선택한 상영관 저장 = '10관 8층'
		
		function resetSelectInfo(sel){
			//선택 정보 초기화
			//페이지 : 시간, 상영관 초기화
			document.querySelector('#selTime').innerText = "";
			document.querySelector('#selHall').innerText = "";

			//시간 상영관 목록 초기화
			document.querySelector('#timeArea').innerHTML = "";
			
			//변수 : reserve_sctime, reserve_schall 초기화
			reserve_sctime = null;
			reserve_schall = null;
			
			if(sel){
				//페이지 : 날짜 초기화
				document.querySelector('#selDate').innerText = "";
				//변수 : reserve_sctime 초기화
				reserve_scdate = null;
								
			}
			
		}
		
		function movieClick(selectMVObj, mvcode, mvposter) {
			console.log("movieClick() 호출");
			//selectMVObj : 스타일 변경, mvcode : 극장목록 조회, selectMVObj.innerText : 선택항목 출력 ,mvposter : 선택항목 출력
			
			if(selectMVObj.classList.contains('unselectList')){
				console.log("예매가 불가능한 영화 선택");				
				let reloadCheck = confirm('예매가 불가능한 영화입니다.\n계속 하시겠습니까?');
			
				if(reloadCheck){
					 //페이지 재요청
					location.reload();
				}
				
				}else{
					
					//선택정보 초기화 함수 호출
					resetSelectInfo(true);
					
					reserve_mvcode = mvcode; //선택한 영화 코드 저장					

					//1. 선택 항목 출력
					document.querySelector('#selTitle').innerText = selectMVObj.innerText;
					document.querySelector('#selPoster').setAttribute('src',mvposter);
					
					//2. 선택 항목 스타일 변경
					addSelectStyle(selectMVObj);
					
					//3. 선택한 영화를 예매 할 수 있는 극장 목록 조회
					let thList = getReserveTheaterList(mvcode);
					changeTheaterList(thList);
					
					//4. 영화 & 극장이 모두 선택이 되어 있으면 날짜 목록 조회 출력
					if((reserve_mvcode != null) && (reserve_thcode != null)){
						getReserveScheduleDateList();
					}
				}
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
					//선택정보 초기화 함수 호출
					resetSelectInfo(true);
					
					reserve_thcode = thcode;
					
					//1.선택 항목 출력
					document.querySelector('#selTheater').innerText = selectTHObj.innerText;
					
					//2.선택 항목 스타일 변경
					addSelectStyle(selectTHObj);
			
					//3.선택한 극장에서 예매 할 수 있는 영화 목록 조회
					let mvList = getReserveMovieList(thcode);
					changeMovieList(mvList);
					
					//4. 영화 & 극장이 모두 선택이 되어 있으면 날짜 목록 조회 출력
					if((reserve_mvcode != null) && (reserve_thcode != null)){
						getReserveScheduleDateList();
					}
				}
			}
		
		function getReserveMovieList(selectThcode) {
			console.log('예매 가능한 영화 목록 조회 요청');
			let movieList = [];
			$.ajax({
				type : 'get',
				url : 'getMovieList_json',
				data: {'selThCode' : selectThcode},
				async : false,
				dataType : 'json',
				success : function(result){
					movieList = result;	
				}
			});
			return movieList;
		}
		
		function changeMovieList(mvList) {
			console.log("changeMovieList() 호출");
			let mvCodeList = [];
			
			for(let mv of mvList){
				mvCodeList.push(mv.mvcode);
			}
			
			let MovieEls = document.querySelectorAll("#movArea>div.selEl");
			
			let mvArea = document.querySelector('#movArea');
			
			for(let mvEl of MovieEls){
				mvEl.classList.remove('selectList');
				mvEl.classList.remove('unselectList');

				if(mvCodeList.includes(mvEl.getAttribute('id'))){
					//예매 가능한 영화
					mvEl.classList.add('selectList');
				}else{
					//예매 불가능한 영화
					mvEl.classList.add('unselectList');
					mvArea.appendChild(mvEl);
				}			
			}
		}
	</script>
	
	<script type="text/javascript">
	
		function getReserveScheduleDateList() {
			console.log('예매 가능한 날짜 목록 조회 요청');
			
			document.querySelector("#selDate").innerText = "";
			
			$.ajax({
				type : "get",
				url : "getSchduleDateList_json",
				data : {'mvcode' : reserve_mvcode, 'thcode' : reserve_thcode},
				async : false,
				dataType : 'json',
				success : function(result){
					console.log(result);
					printScheduleDate(result);
				}
			});
		}
		
		function printScheduleDate(scDateList) {
			console.log("printScheduleDate() 호출");
			
			let dateArea = document.querySelector('#dateArea'); //날짜 출력 div
			dateArea.innerHTML = '';
			let nowMM = null;	//월 출력
			
			for(let sc of scDateList){
				
				let dateDiv = document.createElement('div');
				let dateArr = sc.scdate.split("/");
				
				if(nowMM != dateArr[1]){
					nowMM = dateArr[1];
					
					let mmDiv = document.createElement('div');
					mmDiv.innerText = dateArr[1]+"월";
					
					mmDiv.classList.add('text-center');
					mmDiv.classList.add('csstyle');
					
					dateArea.appendChild(mmDiv);
				}
				//몇일 인지 출력
				dateDiv.classList.add('selectList');
				dateDiv.classList.add('selEl');
				dateDiv.classList.add('text-center');//<div class= " "> </div> 
				
				dateDiv.innerText = dateArr[2]+"일";
				//dateDiv.addEventListener('click',function(e){});
				dateDiv.addEventListener('click',function(e){
					reserve_scdate = sc.scdate;
					
					console.log("날짜 선택 : " + sc.scdate);
					//1.선택 항목 STYLE 변경
					addSelectStyle(e.target);
					
					//2.선택 항목 출력
					document.querySelector("#selDate").innerText = dateArr[1]+"월 " + dateArr[2]+"일 ";
					
					//3.선택한 날짜의 상영관, 시간 출력
					let scTimeList= getReserveScheduleTimeList(reserve_mvcode, reserve_thcode, sc.scdate);
				})
				dateArea.appendChild(dateDiv);

			}
			
		}
	</script>
	
	<script type="text/javascript">
		function getReserveScheduleTimeList(mvcode, thcode, scdate) {
			console.log('예매 가능한 상영관, 날짜 조회 요청');
			$.ajax({
				type : "get",
				url : "getSchduleTimeList_json",
				data : {'mvcode' : mvcode, 'thcode' : thcode, 'scdate' : scdate},
				async : false,
				dataType : 'json',
				success : function(result){
					console.log(result);
					printScheduleTime(result);
				}
			});
		}
		
		function printScheduleTime(scTimeList) {
			console.log("printScheduleTime() 호출");
			timeArea.innerHTML = ''; //초기화
			let nowHall = null //상영관
			
			for(let sc of scTimeList){
				//상영관 출력
				if(nowHall != sc.schall){
					//구분선
					if(nowHall !=null){
						let hrEl = document.createElement('hr');
						timeArea.appendChild(hrEl);
					}
					
					nowHall = sc.schall
					let hallDiv = document.createElement('div');
					
					hallDiv.classList.add('text-center');
					hallDiv.classList.add('csstyle');
					
					hallDiv.innerText = sc.schall;
					timeArea.appendChild(hallDiv);
				}
				//시간 출력
				let timeDiv = document.createElement('div');
				
				timeDiv.classList.add('selectList');
				timeDiv.classList.add('selEl');
				timeDiv.classList.add('text-center');
				timeDiv.classList.add('inline');
				
				timeDiv.innerText = sc.scdate;
				
				
				timeDiv.addEventListener('click',function(e){
					
					reserve_sctime = sc.scdate;
					reserve_schall = sc.schall;
					
					//1.선택 항목 STYLE 변경
					addSelectStyle(e.target);
					
					//2.선택 항목 출력
					document.querySelector("#selHall").innerText = sc.schall;
					document.querySelector("#selTime").innerText = sc.scdate;

				})
				
				timeArea.appendChild(timeDiv);
				}
			}
	</script>
	<c:if test='${param.mvcode != null}'>
	<script type="text/javascript">
		document.querySelector("#${param.mvcode}").click();
		document.querySelector("#${param.mvcode}").focus();
	</script>
	</c:if>
	
</body>
</html>

