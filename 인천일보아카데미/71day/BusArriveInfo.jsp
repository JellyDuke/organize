<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>버스 도착정보 ajax</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>버스 도착정보 ajax - views/BusArriveInfo.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				<button onclick="getBusArrInfo('ICB163000063')">공원앞</button>
				<button onclick="getBusArrInfo('ICB163000060')">세븐일레븐 앞</button>
				<hr>
				<div id = "busSttnArea">
				</div>
				<hr>
				<div id="busInfoArea">
				
				</div>	
		</div>
		</div>
		
	</body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<script type="text/javascript">
	let msg = '${msg}';
	if(msg.length > 0){
		alert(msg);
	}
	</script>
	<!-- 버스도착정보 -->
	<script type="text/javascript">
		function getBusArrInfo(nodeId) {
			console.log("nodeId : " +nodeId)
			//1.도착정보 조회
			$.ajax({
				type: "get",
				url : "getBusArr",
				data : {"nodeId" :  nodeId},
				dataType : "json",
				success : function (arrInfoList){
					console.log(arrInfoList);
					console.log(arrInfoList.length);
					console.log("버스번호: " + arrInfoList[0].routeno);
					console.log("남은 정류장: " + arrInfoList[0].arrprevstationcnt);
					console.log("도착 예정시간: " + arrInfoList[0].arrtime);
				printBusInfo(arrInfoList);

				}
				
			});
		}
	</script>
	<script type="text/javascript">
		function printBusInfo(busInfoList) {
			let busList = document.querySelector("#busInfoArea");
			busList.innerHTML = "";
			
			for(let busInfo of busInfoList){
			let busTable = document.createElement('table');
			busList.appendChild(busTable);
			
			let busTr = document.createElement('tr');
			busTable.appendChild(busTr);

			let busTh4 = document.createElement('th');
			busTr.appendChild(busTh4);
			busTh4.innerText = "버스: " +busInfo.nodenm;
			
			let busTh1 = document.createElement('th');
			busTr.appendChild(busTh1);
			busTh1.innerText = busInfo.routeno+"번";
			
			let busTh2 = document.createElement('th');
			busTr.appendChild(busTh2);
			busTh2.innerText = "남은 정류장: "+busInfo.arrprevstationcnt+"전 ";
			
			let busTh3 = document.createElement('th');
			busTr.appendChild(busTh3);
			busTh3.innerText = "도착 예정시간: "+busInfo.arrtime+"초";
			}
		}
	</script>
	<script type="text/javascript">
	//GEOLOCATION
		$(document).ready(function(){
			getBusSttnList(37.4398411, 126.6640894);
		});
		function getBusSttnList(lati, longti) {
			$.ajax({
				type: "get",
				url : "getBusSttn",
				data : {"lati" :  lati,
						"longti" : longti	
				},
				dataType : "json",
				success : function (sttnList){
				//국토교통부_(TAGO)_버스정류소정보 - 좌표기반근접정류소 목록조회
				printBusSttnBtn(sttnList);
				}
			});
		}
	</script>x	
	<script type="text/javascript">
		function printBusSttnBtn(sttnList) {
			let btn_div = document.querySelector("#busSttnArea");
			btn_div.innerHTML = "";
			let idx = 0;
			for(let sttn of sttnList){
				let sttnBtn = document.createElement('button');	
				sttnBtn.classList.add('sttnBtn');
				sttnBtn.setAttribute("onclick", "getBusArrInfo('"+sttn.nodeid+"')");
				
				sttnBtn.innerHTML = sttn.nodeno+"<br>"+sttn.nodenm;
				btn_div.appendChild(sttnBtn);
				idx++;
				if(idx % 5 ==0) {
					let br = document.createElement('br');
					btn_div.appendChild(br);
				}
			}
		}
	</script>
</html>