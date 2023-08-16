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
		}
	</style>
</head>
<body>
	<h1>PrdSearchResult.jsp</h1>

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

	<div></div>
</body>
</html>