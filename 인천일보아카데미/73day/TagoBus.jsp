<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>TagoBus.jsp</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style type="text/css">
		#mapInfo{
			display: flex;
		}
		#busSttnArea{
			border: 2px solid black;
			border-radius: 10px;
			margin-left: auto;
			margin-right: auto;
			padding: 4px;
			width: 150px;
			height: 380px;
			overflow: scroll;
			font-size: 17px;
		}
		#busSttnArea::-webkit-scrollbar{
		 width: 4px;
		}
		.busSttn{
			border: 1px solid black;
			border-radius: 10px;
			padding: 5px;
			text-align: center;
			margin-bottom: 3px;
			cursor: poiner;
		}
		.busSttn:hover{
			background-color: pink; 
		}
		#busArrInfo{
			box-sizing: border-box;
			border: 2px solid black;
			border-radius: 10px;
			width: 93%;
			margin-top: 10px;
			margin-bottom: auto;
			margin-left: auto;
			margin-right: auto;
			padding: 5px
			
		}
		.arrInfo{
			display: flex;
			border: 1px solid black;
			border-radius: 10px;
			padding: 5px;
			margin-bottom: auto;
			margin-top: auto;
		}
	</style>
	</head>
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>TagoBus - views/TagoMain.jsp</h1>
			</div>
			<%@ include file="/WEB-INF/views/includes/TagoMenu.jsp" %>	
			
			<div class="contents">

				<div id = "TagoBus">
					
					<div id = "leftInfo">

						<div id = "mapInfo">

						<!-- 지도 -->
						<div id="map" style="width:500px;height:400px; margin-left: auto; margin-right: auto"></div>
						
						<!-- 정류소 목록 /국토 교통부_(TAGO)_버스정류소정보 - 정류소 목록 조회 -->
						<div id = "busSttnArea">
						</div>
					</div>
					
						<div id = "busArrInfo">
						<!-- 도착예정 버스 정보 -->
							
						</div>
					</div>

					<div id = "busLocInfo">
					<!-- 버스 노선 정보 -->

					</div>
				</div>
			</div>
		</div>
	</body>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6419d68cc08de2e99f500a34b40bcf0e"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.438878321962214, 126.67511263957657), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    console.log("위도 : " + latlng.getLat());
	    console.log("경도 : " + latlng.getLng());
	    //정류소 목록 조회 기능 호출
		getBusSttnList(latlng.getLat(), latlng.getLng());
	});
	</script>
	
	<script type="text/javascript">
	//정류소 목록 조회 기능
		function getBusSttnList(latitude, longtitude){
			console.log("getBusSttnList() 호출");
			console.log(latitude+" : "+ longtitude);
			//1. 국토 교통부_(TAGO)_버스정류소정보 - 정류소 목록 조회
			$.ajax({
				type: "get",
				url : "getTagoSttnList",
				data : {"lati" : latitude, "longti" : longtitude },
				dataType : "json",
				success : function(result){
					
					printBusSttn(result);
					
				}
			});
		}
		
		let currentCityCode = null;

		let oldMarker = null;
	
		//정류소 목록 출력 기능
		function printBusSttn(sttnList){
			//정류소 목록을 출력하는 DIV 선택
			let busSttnArea = document.querySelector("#busSttnArea");
			busSttnArea.innerHTML = ""; //정류소 목록 초기화
			// <div class = "busSttn" onclick="getBusArrInfo('도시코드','정류소ID')">
			// 		30063 정류소A				
			// 	</div>
			for(let sttn of sttnList){
				let sttnDiv = document.createElement('div');
				sttnDiv.classList.add('busSttn');
				// sttnDiv.setAttribute("onclick","getBusArrInfo('" + sttn.citycode + "','"+sttn.nodeid+"')");
				
				sttnDiv.addEventListener('click',function(){
					
					// 마커가 표시될 위치입니다 
					var markerPosition  = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong); 
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({ position: markerPosition });
					
					// 이동할 위도 경도 위치를 생성합니다 
					var moveLatLon = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);
					
					// 지도 중심을 부드럽게 이동시킵니다
					// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
					map.panTo(moveLatLon); 
					
					// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
					if(oldMarker !=  null){
						oldMarker.setMap(null);
					}
					
					oldMarker = marker;
					marker.setMap(map);
					
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					
					//전역변수에 도시코드를 저장합니다
					currentCityCode = sttn.citycode;

					// 도시코드, 버스아이디 정보를 받아옵니다
					getBusArrInfo(sttn.citycode, sttn.nodeid);
					
				});
				
				sttnDiv.innerHTML = sttn.nodeno+"<br>"+sttn.nodenm;
			
				busSttnArea.appendChild(sttnDiv);
			
			}
		}
	</script>
	
	<script>
	
		function getBusArrInfo(citycode, nodeid){
			
			console.log("getBusArrInfo() 호출");
			console.log("도시코드: " + citycode+ " 정류소Id: " + nodeid);
			
			$.ajax({
				type: "get",
				url : "getTagoBusArrList",
				data : {"citycode" : citycode, "nodeid" : nodeid },
				dataType : "json",
				success : function(result){
					//버스 도착 정보 목록 출력 기능 호출
					printBusArrInfo(result);
				}
			});
		}
		/*<div class="arrInfo">
			<div>
				버스번호 4번
			</div>
			<div>
				남은정류장 3 정거장 전
			</div>
			<div>
				도착예정시간 100초 후 도착예정
			</div>
		</div>*/
		function printBusArrInfo(arrList){

			console.log("버스도착정보 출력 기능 호출");
			console.log(arrList);
			console.log(arrList.length);
			console.log(arrList.length == undefined);
			//도착 정보를 출력할 DIV 선택
			let busArrInfoDiv = document.querySelector("#busArrInfo");
			busArrInfoDiv.innerHTML = ""; //초기화
			
			for(let arrInfo of arrList){

				let arrInfoDiv = document.createElement('div');
				arrInfoDiv.classList.add('arrInfo');
				arrInfoDiv.innerText = "버스: "+ arrInfo.routeno +"번 " + "정거장: " + arrInfo.arrprevstationcnt + "전 " + arrInfo.arrtime +"초 후 도착예정";
				
				arrInfoDiv.addEventListener('click',function(){
						console.log("버스선택! cityCode, routeId");
						//버스 위치 정보 조회 기능 호출
						getBusLocList(currentCityCode, arrInfo.routeid);
				});

				busArrInfoDiv.appendChild(arrInfoDiv);

			}
		function getBusLocList(citycode, routeid){
			console.log("버스 위치정보 조회 기능 호출 + 노선정보 조회 기능 호출");
			console.log("도시코드: "+ citycode);
			console.log("버스ID : " + routeid);

		}
	}

	</script>
	
</html>