<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>버스 도착 정보 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style type="text/css">
	
		.busInfoDiv{
			border: 1px solid black;
			border-radius: 7px;
			display: flex;
			justify-content: center;
			text-align: center;
			margin-left: auto;
			margin-right: auto;
			margin-top: 10px;
			padding: 5px;
			min-height: 200px;
			align-items: flex-start;
		}
		
		p{
			margin: 0 30px;
		}
		
		.sttnBtn{
			min-width: 100px;
			margin: 3px;
		}
		
		.busNum{
			cursor: pointer;
		}
		
		.GMapStyle{
			width:500px;
			height:400px;
		}
		
		.busInfo{
			display: flex;
		}
		
		#busNodeList{
			border: 1px solid black;
			border-radius: 7px;
			padding: 5px;
			width: 250px;
			height: 380px;
			margin: 0 30px;
			overflow: scroll;
		}
		
	</style>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6c2caba447fb2c82043a693e2c21845b"></script>
	
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>버스 도착 정보 - views/BusArriveInfo.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				
				<div class="busInfo">
				
					<div id="map" style="width:450px;height:400px;border: 1px solid black;"></div>
					<div id="busNodeList">
					
					</div>
				</div>
				
				<hr>
				
				<button onclick="getBusArrInfo('ICB163000063')">공원앞</button>
				<button onclick="getBusArrInfo('ICB163000060')">편의점앞</button>
				<hr>
				
				<div id="busSttnArea">
					
				</div>
				<hr>
				
				<div id="busInfoArea" class="busInfoDiv">
						
				</div>
				
				<div id="busGpsInfoArea" class="busInfoDiv">
					버스 위치 정보 영역
				</div>

			</div>
			
		</div>
		
	</body>
	
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.4387, 126.6750), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		 // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		 var zoomControl = new kakao.maps.ZoomControl();
		 map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		 
		 
		    
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng;
		    
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    console.log(message);
		    
		    getBusSttnList(latlng.getLat(), latlng.getLng());
	    
	});
	</script>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>
	
	<script type="text/javascript">
		function getBusArrInfo(nodeId){
			console.log("nodeId : " + nodeId);
			// 1. 도착정보 조회 ajax
			$.ajax({
				type: "get",
				url: "getBusArr",
				data: {"nodeId" : nodeId},
				dataType: "json",
				success: function(arrInfoList){
					console.log(arrInfoList);
					console.log(arrInfoList.length);
					console.log("버스 번호 : " + arrInfoList[0].routeno);
					console.log("남은 정류장 : " + arrInfoList[0].arrprevstationcnt);
					console.log("도착예정시간 : " + arrInfoList[0].arrtime);
					
					printBusInfo(arrInfoList);
				}
			});
		}
	</script>
	
	<script type="text/javascript">
		<%-- 도시 코드 저장 --%>
		let cityCode = 0;
	</script>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
			getBusSttnList(37.4387, 126.6750);
		});
		
		function getBusSttnList(lati, longti){
			$.ajax({
				type: "get",
				url: "getBusSttn",
				data: {"lati" : lati, "longti" : longti},
				dataType: "json",
				success: function(sttnList){
					// 국토교통부_(TAGO)_버스정류소정보 - 좌표기반근접정류소 목록조회
					console.log(sttnList);
					cityCode = sttnList[0].citycode;
					
					printBusSttnBtn(sttnList);
				}
			});
		}
	</script>
	
	<script type="text/javascript">
		function printBusInfo(busInfoList){
			let busInfoMain = document.querySelector('#busInfoArea');
			busInfoMain.innerHTML = "";
			
			
			let busInfoTable = document.createElement('table');
			
			let busTitletr = document.createElement('tr');
			
			let nodenm = document.createElement('th');
			nodenm.innerText = "정류소명";
			busTitletr.appendChild(nodenm);
			
			let routeno = document.createElement('th');
			routeno.innerText = "버스번호";
			busTitletr.appendChild(routeno);
			
			let arrprevstationcnt = document.createElement('th');
			arrprevstationcnt.innerText = "남은정류장수";
			busTitletr.appendChild(arrprevstationcnt);
			
			let arrtime = document.createElement('th');
			arrtime.innerText = "도착예정시간";
			busTitletr.appendChild(arrtime);
			
			busInfoTable.appendChild(busTitletr);
			
			busInfoMain.appendChild(busInfoTable);
			
			for(let busInfo of busInfoList){
				
				let busInfoTr = document.createElement('tr');
				
				let nodenm = document.createElement('td');
				let nodenmPtag = document.createElement('p');
				nodenmPtag.innerText = busInfo.nodenm;
				nodenm.appendChild(nodenmPtag);
				busInfoTr.appendChild(nodenm);
				
				let routeno = document.createElement('td');
				let routenoPtag = document.createElement('button');
				routenoPtag.innerText = busInfo.routeno + "번";
				
				routenoPtag.setAttribute("onclick", "getBusNodeInfo('"+busInfo.routeid+"')");
				routenoPtag.classList.add('busNum');
				
				routeno.appendChild(routenoPtag);
				busInfoTr.appendChild(routeno);
				
				let arrprevstationcnt = document.createElement('td');
				let arrprevstationcntPtag = document.createElement('p');
				arrprevstationcntPtag.innerText = busInfo.arrprevstationcnt + "정류장";
				arrprevstationcnt.appendChild(arrprevstationcntPtag);
				busInfoTr.appendChild(arrprevstationcnt);
				
				let arrtime = document.createElement('td');
				let arrtimePtag = document.createElement('p');
				arrtimePtag.innerText = busInfo.arrtime + "초";
				arrtime.appendChild(arrtimePtag);
				busInfoTr.appendChild(arrtime);
				
				busInfoTable.appendChild(busInfoTr);
			}
			
		}
	</script>
	
	<script type="text/javascript">
		function printBusSttnBtn(sttnList){
			let btn_div = document.querySelector('#busSttnArea');
			btn_div.innerHTML = "";
			let idx = 0;
			
			for(let sttn of sttnList){
				let sttnBtn = document.createElement('button');
				sttnBtn.classList.add('sttnBtn');
				sttnBtn.setAttribute("onclick", "getBusArrInfo('"+sttn.nodeid+"')");
				
				sttnBtn.innerHTML = sttn.nodeno + "<br>" + sttn.nodenm;
				btn_div.appendChild(sttnBtn);
				idx++;
				
				if(idx % 5 == 0){
					let br = document.createElement('br');
					btn_div.appendChild(br);
				}
			}
		}
	</script>
	
	<script type="text/javascript">
		function getBusNodeInfo(routeid){
			$.ajax({
				type: "get",
				url: "getBusNodeInfoList",
				data: {"routeid" : routeid, "cityCode" : cityCode},
				dataType: "json",
				success: function(busNodeList){
					console.log("busNodeList : " + busNodeList);
					printBusNodeList(busNodeList);
				}
			});
		}
	</script>
	
	<script type="text/javascript">
		function printBusNodeList(busNodeList){
			let nodeListDiv = document.querySelector('#busNodeList');
			nodeListDiv.innerHTML = "";
			
			for(busNode of busNodeList){
				let node = document.createElement('div');
				node.innerText = busNode.nodenm;
				nodeListDiv.appendChild(node);
			}
			
		}
	</script>
	
	<script type="text/javascript">
		function getBusGpsInfo(routeid){
			
			$.ajax({
				type: "get",
				url: "getButGpsList",
				data: {"routeid" : routeid, "cityCode" : cityCode},
				dataType: "json",
				success: function(busGpsList){
					console.log("busGpsList : " + busGpsList);
					printBusGpsInfo(busGpsList);
				}
			});
		}
	</script>
	
	<script type="text/javascript">
		function printBusGpsInfo(busGpsList){
			
			let busGpsInfoDiv = document.querySelector('#busGpsInfoArea');
			busGpsInfoDiv.innerHTML = "";
			
			let busGpsInfoTable = document.createElement('table');
			
			let busGpsTitleTr = document.createElement('tr');
			
			let routenm = document.createElement('th');
			routenm.innerText = "버스 번호";
			busGpsTitleTr.appendChild(routenm);
			
			let nodenm = document.createElement('th');
			nodenm.innerText = "현재 정류장";
			busGpsTitleTr.appendChild(nodenm);
			
			let routetp = document.createElement('th');
			routetp.innerText = "버스 종류";
			busGpsTitleTr.appendChild(routetp);
			
			busGpsInfoTable.appendChild(busGpsTitleTr);
			
			busGpsInfoDiv.appendChild(busGpsInfoTable);
			
			for(busGps of busGpsList){
				
				let BusGpsInfoTr = document.createElement('tr');
				
				let routenm = document.createElement('td');
				let routenmPtag = document.createElement('p');
				routenmPtag.innerText = busGps.routenm + "번";
				routenm.appendChild(routenmPtag);
				BusGpsInfoTr.appendChild(routenm);
				
				let nodenm = document.createElement('td');
				let nodenmPtag = document.createElement('p');
				nodenmPtag.innerText = busGps.nodenm;
				nodenm.appendChild(nodenmPtag);
				BusGpsInfoTr.appendChild(nodenm);
				
				let routetp = document.createElement('td');
				let routetpPtag = document.createElement('p');
				routetpPtag.innerText = busGps.routetp;
				routetp.appendChild(routetpPtag);
				BusGpsInfoTr.appendChild(routetp);
				
				busGpsInfoTable.appendChild(BusGpsInfoTr);
			}
			
		}
	</script>
	
	<script type="text/javascript">
		function panTo(gpslati, gpslong) {
			
		    // 이동할 위도 경도 위치를 생성합니다 
		    var moveLatLon = new kakao.maps.LatLng(gpslati, gpslong);
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.panTo(moveLatLon);
		    
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(gpslati, gpslong); 
		
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			
			// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
			marker.setMap(null);
		
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
		}        
	</script>

</html>