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
            border: 5px solid rgb(0, 0, 0);
            padding: 10px;
        }

        table{
            border: 2px solid rgb(0, 0, 0);
            border-radius: 7px;
        }
        
        button{
            width: 100px;
            padding: 3px;
            border-radius: 10px;
            background-color: rgb(255, 255, 255);
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

        <div id="contents" style="background-image: url(https://cdn.pixabay.com/photo/2018/02/24/06/49/pattern-3177396_640.png);">
            <h1>게시판 ${param.serchTitle }</h1>
            <table style="width: 500px;">
            
	            <tr style="color: rgb(255, 255, 255); text-align: center; background-color: black;">
	            	<th>글번호</th>
	            	<th>글제목</th>
	            	<th>작성자</th>
	            	<th>조회수</th>
	            </tr>
		
				<%-- bList 반복 시작 --%>
                <c:forEach items="${bList }" var="board">
                	<tr style="color: rgb(255, 255, 255); text-align: center; background-color: rgb(0, 24, 38);">
                		<td>${board.BNO }</td>
                		<td class="Btitle"><a href="${pageContext.request.contextPath}/boardView?viewBno=${board.BNO }">${board.BTITLE }</a></td>
                		<td>${board.BWRITER }</td>
                		<td>${board.BHITS }</td>
                	</tr>
                </c:forEach>
            </table>
                <%-- bList 반복 끝 --%>
                
                
                <%-- 로그인이 되면 출력 --%>
                <c:if test="${sessionScope.loginMemberId != null }">
                        <button><a href="${pageContext.request.contextPath}/boardWriteForm">글쓰기</a></button>
                </c:if>
                <form action="${pageContext.request.contextPath}/boardSearch" method="get">
                    <input type="text" name="searchTilte" placeholder="제목 검색...">
                    <input type="submit" value="검색">
                </form>
        </div>

    </body>
    
    <script src="${pageContext.request.contextPath}/JS/main.js"></script>

</html>