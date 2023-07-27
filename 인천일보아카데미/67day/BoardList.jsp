<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
        <style type="">
        .formWrap{
            margin-bottom: 200px;
            width: 400px;
            border: 3px solid black;
            padding: 10px;
            border-radius: 10px;
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            margin-top: 100px;
        }

		div#contents{
			margin-top: 20px;
			border: 2px solid black;
			border-radius: 2px 
		}

		table {
		  width: 100%;
		  border-collapse: collapse;
		  margin: 20px auto;
		}
		
		th, td {
		  padding: 10px;
		  border: 1px solid black;
		  
		}
		
		th {
		  background-color: #f2f2f2;
		}
		
		tr:nth-child(even) {
		  background-color: #f9f9f9;
		  font-weight: bold;
		}
		
		tr:hover {
		  background-color: #e1e1e1;
		}


    </style>
    </head>

    <body>

       <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

        <div id="contents" style="background-image: url('https://cdn.pixabay.com/photo/2018/04/06/15/17/pattern-3296033_640.png');">

            <div class="formWrap">
					<h1>게시판</h1>
					<table>
						<tr>
							<th>글번호</th>
							<th>글제목</th>
							<th>작성자</th>
							<th>조회수</th>
						</tr>
						
				<c:forEach items="${bList }" var="board">
                	<tr style="border: 3px solid black; text-align: center; color: black">
                		<td>${board.bno }</td>
                		<td class="Btitle"><a href="${pageContext.request.contextPath}/boardView?bno=${board.bno }">${board.btitle }</a></td>
                		<td>${board.bwriter}</td>
                		<td>${board.bhits}</td>
                	</tr>
                </c:forEach>
				</table>
            </div>
        </div>

    </body>

    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
</html>