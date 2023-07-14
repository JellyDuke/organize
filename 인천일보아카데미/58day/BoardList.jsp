<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
    <style>
        div{
            border: 5px solid pink;
            padding: 10px;
        }

        table{
            border: 1px solid black;
        }
        
        button{
            width: 100px;
            padding: 3px;
            border-radius: 10px;
            background-color: cornsilk;
            cursor: pointer;
            margin-bottom: 5px;
            
        }
    </style>
    </head>

    <body>
        <div id="header">
            BoardList.jsp
        </div>

        <%@ include file="Menu.jsp" %>

        <div id="contents">
            <table>
            
	            <tr>
	            	<th>글번호</th>
	            	<th>글제목</th>
	            	<th>작성자</th>
	            	<th>조회수</th>
	            </tr>
		
				<%-- bList 반복 시작 --%>
                <c:forEach items="${bList }" var="board">
                	<tr>
                		<td>${board.BNO }</td>
                		<td class="Btitle"><a href="${pageContext.request.contextPath}/boardView?viewBno=${board.BNO }">${board.BTITLE }</a></td>
                		<td>${board.BWRITER }</td>
                		<td>${board.BHITS }</td>
                	</tr>
                </c:forEach>
                <%-- bList 반복 끝 --%>
                
                
                <%-- 로그인이 되면 출력 --%>
                 <c:if test="${sessionScope.loginMemberId != null }">
                        <button><a href="${pageContext.request.contextPath}/boardWriteForm">글쓰기</a></button>
                 </c:if>
            </table>
        </div>

    </body>
    
    <script src="${pageContext.request.contextPath}/JS/main.js"></script>

</html>