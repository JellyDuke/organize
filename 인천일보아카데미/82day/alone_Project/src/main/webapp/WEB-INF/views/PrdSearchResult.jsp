<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		.prdTitle {
			display:inline-block;
			width: 300px;
			white-space:nowrap;
			overflow:hidden;
			margin: 0px;	
		}
		table{
			border-collapse: collapse;
		}
		td,th{
			border-bottom: 1px solid black;
			padding: 3px 7px;
		}
		.prdArea{
			height: 500px;
			overflow: scroll;
			border: 2px solid black;
			padding: 3px;
			marging: 3px;
		}
	</style>
</head>
<body>
	<h1>PrdSearchResult.jsp</h1>
	<div style="display: flex;">
	<div class="prdArea">
		<table>
			<thead>
				<tr>
					<th>쇼핑몰</th>
					<th>상품이름</th>
					<th>상품가격</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${prdList_coupang }" var="prdInfo">
					<tr>
						<td>${prdInfo.prdSite}</td>
						<td>
							<a class="prdTitle" title="${prdInfo.prdName}" href="${prdInfo.prdUrl}">${prdInfo.prdName}</a>
						</td>
						<td>${prdInfo.prdPrice}</td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>
	
	<div class="prdArea">
		<table class="prd_gmarket">
			<thead>
				<tr>
					<th>쇼핑몰</th>
					<th>상품이름</th>
					<th>상품가격
						<select onchange="prdSort(this.value)">
							<option value="price_desc">↑</option>
							<option value="price_asc">↓</option>
						</select>
					</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${prdList_gmarket }" var="prdInfo">
					<tr>
						<td>gmarket</td>
						<td>
							<a class="prdTitle" title="${prdInfo.prdName}" href="${prdInfo.prdUrl}">${prdInfo.prdName}</a>
						</td>
						<td class="prdPrice">${prdInfo.prdPrice}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
</body>
	<script type="text/javascript">
		function prdSort(sortOption/*,objId*/) {
			console.log(sortOption);
			// let idPrdList = document.querySelector("#"+objId);
			// let prdList = sortOption.parentElement.parentElement.parentElement.nextElementSibling;
			let prdList = document.querySelectorAll('.prd_gmarket>tbody>tr'); 
			let prdList_arr = Array.from(prdList);
			let prdSort = []; 
	
			prdSort[0] = prdList_arr.shift();

			for(let prd_arr of prdList_arr){//for문 시작
				
				let prdPrice_arr = Number(prd_arr.querySelector('.prdPrice').innerText);

				let idx = -1;

				for(let sortIdx in prdSort){ //내부 for문 시작

					let prdPrice_sort = Number(prdSort[sortIdx].querySelector('.prdPrice').innerText);

					let sortCheck = false;

					switch(sortOption){
						case "price_desc": 
							sortCheck = prdPrice_arr > prdPrice_sort;
							break;
						case "price_asc":
							sortCheck = prdPrice_arr < prdPrice_sort;
							break;
					}

					if(sortCheck){
						idx = sortIdx;
						break;
					}
				}//내부for문 끝
				if(idx > -1){
					prdSort.splice(idx,0,prd_arr);
				}else{
					prdSort.push(prd_arr);
				}

			}//for문 끝

			let tbodyTag = document.querySelector('.prd_gmarket>tbody');

			tbodyTag.innerHTML="";

			for(let item of prdSort){
				tbodyTag.appendChild(item);
			}
		}
	</script>
</html>