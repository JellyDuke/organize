<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>TagoBus 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style type="text/css">
	
		#TagoBus {
			display: flex;
		}
	
		#mapInfo {
			display: flex;
		}
		
		#busSttnArea {
			box-sizing: border-box;
			border: 1px solid black;
			border-radius: 7px;
			margin-left: 3px;
			padding: 3px;
			width: 200px;
			height: 300px;
			overflow: scroll;
			font-size: 13px;
		}
		
		.busSttn {
			border: 1px solid black;
			border-radius: 10px;
			padding: 5px;
			text-align: left;
			margin-bottom: 3px;
			cursor: pointer;
		}
		
		.busSttn:hover {
			background-color: antiquewhite;
		}
		
		#leftInfo {
			/* width: 600px; */
		}
		
		#busArrInfo {
			box-sizing: border-box;
			border: 2px solid black;
			border-radius: 7px;
			width: 605px;
			height: 300px;
			padding: 5px;
			margin-top: 5px;
			overflow: scroll;
		}
		
		.arrInfo {
			display: flex;
			border: 1px solid black;
			border-radius: 10px;
			padding: 5px;
			margin-bottom: 3px;
			
			justify-content: center;
			cursor: pointer;
		}
		
		.arrInfo:hover {
			background-color: antiquewhite;
		}
		
		.arr {
			margin: 0 30px;
		}
		
		#busLocInfo {
			border: 2px solid black;
			border-radius: 7px;
			margin-left: 5px;
			padding: 7px;
			width: 250px;
			height: 587px;
			overflow: scroll;
		}
		
		.busNode {
			border: 1px solid black;
			border-radius: 10px;
			padding: 8px;
			margin-bottom: 5px;
			cursor: pointer;
		}
		
		.busNode:hover {
			background-color: antiquewhite;
		}
		
		.nowBus {
			border: 5px solid lightcoral!important;
		}
		
		.selectBusSttn {
			background-color: lightgrey;
		}
		
	</style>
	<script src="https://kit.fontawesome.com/b213412e2c.js" crossorigin="anonymous"></script>
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>TagoBus - views/TagoBus.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				
				<div id="TagoBus">
				
					<div id="leftInfo">
					
						<div id="mapInfo">
							<%-- 지도 --%>
							<div id="map" style="width:400px;height:300px;"></div>
							
							<%-- 정류소 목록 / 국토교통부_(TAGO)_버스정류소정보_API --%>
							<div id="busSttnArea">
								<div class="busSttn" onclick="getBusArrInfo('도시코드', '정류소ID')">
									30063 정류소A
								</div>
								<div class="busSttn">
									30060 정류소B
								</div>
							</div>
							
						</div>
						
						<div id="busArrInfo">
							<%-- 도착예정 버스 정보 --%>
							<div class="arrInfo">
								<div class="arr">
									4번
								</div>
								
								<div class="arr">
									3 정거장 전
								</div>
								
								<div class="arr">
									100초 후 도착예정
								</div>
								
							</div>
						</div>
						
					</div>
					
					<div id="busLocInfo">
						<%-- 버스 노선 정보 --%>
						<div class="busNode">
							30063 영남아파트
						</div>
						
						<div class="busNode nowBus">
							30063 영남아파트
						</div>
						
						<div class="busNode">
							30063 영남아파트
						</div>
					</div>
					
				</div>
				
			</div>
			
		</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c2caba447fb2c82043a693e2c21845b"></script>
	<%-- JQUERY --%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.4387, 126.6754), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) { 
			
			document.querySelector("#busSttnArea").innerHTML = "";
			document.querySelector("#busArrInfo").innerHTML = "";
			document.querySelector("#busLocInfo").innerHTML = "";
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng;
		    console.log("위도 : " + latlng.getLat());
		    console.log("경도 : " + latlng.getLng());
		    
		    //정류소 목록 조회 기능 호출
		    getBusSttnList(latlng.getLat(), latlng.getLng());
		    
		    /* var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    var resultDiv = document.getElementById('result'); 
		    resultDiv.innerHTML = message; */
		});
	</script>
	
	<%-- 정류소 목록 조회 기능 --%>
	<script type="text/javascript">
		function getBusSttnList(latitude, longitude){
			console.log("getBusSttnList() 호출");
			console.log(latitude + " : " + longitude);
			// 1. 정류소 목록 조회 - 국토교통부_(TAGO)_버스정류소정보_API
			
			$.ajax({
				type: "get",
				url: "getTagoSttnList",
				data: {"lati" : latitude, "longti" : longitude},
				dataType: "json",
				success: function(result){
					// 정류소 목록 출력 기능 호출
					printBusSttn(result);
				}
			});
		}
		
		let currentCityCode = null;
		
		let oldMarker = null;
		
		let selectBusSttn = null;
		
		// 정류소 목록 출력 기능
		function printBusSttn(sttnList){
			console.log("printBusSttn() 호출");
			console.log(sttnList);
			console.log(sttnList.length);
			
			// 정류소 목록을 출력하는 DIV
			let busSttnArea = document.querySelector('#busSttnArea');
			busSttnArea.innerHTML = ""; // 정류소 목록 초기화
			
			/* <div class="busSttn" onclick="getBusArrInfo('도시코드', '정류소ID')">
					30063 정류소A
			   </div> */
			
			for(let sttn of sttnList){
				let sttnDiv = document.createElement('div');
				sttnDiv.classList.add('busSttn');
				// sttnDiv.setAttribute("onclick", "getBusArrInfo('"+sttn.citycode+"', '"+sttn.nodeid+"')");
				sttnDiv.innerText = sttn.nodeno + " " + sttn.nodenm;
				
				// 정류소 목록 DIV를 눌렀을 때 지도를 정류소 위치로 이동 후 마커 생성
				sttnDiv.addEventListener('click', function(){
					
					// 이동할 위도 경도 위치를 생성합니다 
				    var moveLatLon = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong);
				    
				    // 지도 중심을 부드럽게 이동시킵니다
				    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
				    map.panTo(moveLatLon);
				    
					// 마커가 표시될 위치입니다 
				    var markerPosition  = new kakao.maps.LatLng(sttn.gpslati, sttn.gpslong); 

				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({
				        position: markerPosition
				    });
					
				    if(oldMarker != null){
					    oldMarker.setMap(null);				    	
				    }
				    
				    marker.setMap(map);
				    oldMarker = marker;
				    
				    selectBusSttn = sttn.nodeid;
				    
				    currentCityCode = sttn.citycode;
				    
				    getBusArrInfo(sttn.citycode, sttn.nodeid);
				    
				});
				
				busSttnArea.appendChild(sttnDiv);
			}
		
		}
	</script>
	
	<script type="text/javascript">
	
		// 정류소 목록 DIV를 눌렀을 때 기능 수행 후 호출
		function getBusArrInfo(citycode, nodeid){
			console.log("버스 도착 정보 - getBusArrInfo() 호출");
			console.log("도시코드 : " + citycode + " || 정류소ID : " + nodeid);
			
			document.querySelector("#busArrInfo").innerHTML = "";
			document.querySelector("#busLocInfo").innerHTML = "";
			
			$.ajax({
				type: "get",
				url: "getTagoBusArrList",
				data: {"citycode" : citycode, "nodeid" : nodeid},
				dataType: "json",
				success: function(result){
					// 버스 도착 정보 목록 출력 기능 호출
					console.log(result);
					console.log(result.length);
					
					printBusArrInfo(result);
				}
			});
		}
		
	 /* <div class="arrInfo">
			<div class="arr">
				4번
			</div>
								
			<div class="arr">
				3 정거장 전
			</div>
								
			<div class="arr">
				100초 후 도착예정
			</div>
								
		</div> */
		function printBusArrInfo(arrList){
			console.log("버스도착정보 출력 기능 호출");
			console.log(arrList);
			console.log(arrList.length);
			console.log(arrList.length == undefined);
			
			// 도착 정보를 출력할 DIV 선택
			let busArrInfoDiv = document.querySelector('#busArrInfo');
			busArrInfoDiv.innerHTML = ""; // 초기화
			document.querySelector("#busLocInfo").innerHTML = "";
			
			for(let arrInfo of arrList){
				let arrInfoDiv = document.createElement('div');
				arrInfoDiv.classList.add('arrInfo');
				
				let routenoDiv = document.createElement('div');
				routenoDiv.classList.add('arr');
				routenoDiv.innerText = arrInfo.routeno + "번";
				arrInfoDiv.appendChild(routenoDiv);
				
				let arrprevstationcntDiv = document.createElement('div');
				arrprevstationcntDiv.classList.add('arr');
				arrprevstationcntDiv.innerText = arrInfo.arrprevstationcnt + "정거장 전";
				arrInfoDiv.appendChild(arrprevstationcntDiv);
				
				let arrtimeDiv = document.createElement('div');
				arrtimeDiv.classList.add('arr');
				arrtimeDiv.innerText = arrInfo.arrtime + "초 후 도착예정";
				arrInfoDiv.appendChild(arrtimeDiv);
				
				arrInfoDiv.addEventListener('click', function(){
					console.log("버스 선택!");
					// 버스 위치정보 + 노선정보 조회 기능 호출
					getBusLocList(currentCityCode, arrInfo.routeid);
				}); 
				
				busArrInfoDiv.appendChild(arrInfoDiv);
				
			}
		}
		
		function getBusLocList(ccode, rid){
			console.log("버스 위치정보 + 노선정보 조회 기능 호출");
			console.log("도시코드 : " + ccode);
			console.log("버스 아이디 : " + rid);
			
			let nodeList = null; // 정류소 목록
			let locList = null; // 위치 정보 목록
			
			// 1. 버스 노선 정보 - 국토교통부_(TAGO)_버스노선정보 (노선별 경유 정류소 목록 조회)
			 $.ajax({
				type: "get",
				url: "getTagoBusNodeList",
				data: {"citycode" : ccode, "routeid" : rid },
				dataType: "json",
				async : false,
				success: function(nodeResult){
					nodeList = nodeResult;
				} 
			});
			
			// 2. 버스 위치 정보 - 국토교통부_(TAGO)_버스위치정보 (노선별 버스 위치 목록 조회)
			 $.ajax({
				type: "get",
				url: "getTagoBusLocList",
				data: {"citycode" : ccode, "routeid" : rid },
				dataType: "json",
				async : false,
				success: function(busLocResult){
					locList = busLocResult;
				}
			});
			
			// 3. 정류소 목록 출력
			console.log("정류소 목록");
			console.log(nodeList);
			
			console.log("버스 위치 목록");
			console.log(locList);
			
			let locNodeIdList = []; // 버스 위치 목록의 nodeid를 저장할 배열
			for(let locnode of locList){
				locNodeIdList.push(locnode.nodeid);
			}
			console.log(locNodeIdList);
			
			let busLocInfoDiv = document.querySelector("#busLocInfo");
			busLocInfoDiv.innerHTML = "";
			
			for(let busNode of nodeList){
				let busNodeDiv = document.createElement('div');
				busNodeDiv.classList.add('busNode');
				
				/* busNode.nodeid가 locList에 포함되어 있으면
				   class="busNode nowBus" 
				   locList[0].nodeid, locList[1].nodeid, locList[...].nodeid */
				
				// 정류소에 버스가 위치하고 있는지 확인
				if(locNodeIdList.includes(busNode.nodeid)){
					busNodeDiv.classList.add('nowBus');
					busNodeDiv.innerHTML = "<i class='fa-solid fa-bus' style='color: #11b7ee;'></i>" + " " + busNode.nodenm;
				}
				else{
					busNodeDiv.innerHTML = busNode.nodenm;
				}
				
				// 선택한 정류소인지 확인
				if(selectBusSttn == busNode.nodeid) {
					busNodeDiv.classList.add('selectBusSttn');
					busNodeDiv.innerHTML = "<i class='fa-solid fa-person'></i>" + "(선택) " + busNode.nodenm;
					busNodeDiv.setAttribute("tabindex", "0");
					busNodeDiv.setAttribute("id", "focusNode");
				}
				
				busLocInfoDiv.appendChild(busNodeDiv);
			}
			
			document.querySelector("#focusNode").focus();
		}
		
		/* <div id="busLocInfo">
				<div class="busNode">
					30063 영남아파트
				</div>
			</div> */
	</script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>

</html>