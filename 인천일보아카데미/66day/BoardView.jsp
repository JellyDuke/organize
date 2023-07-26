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
            margin-bottom: 0px;
            width: 400px;
            border: 3px solid rgb(255, 255, 255);
            padding: 10px;
            border-radius: 10px;
            background-color: rgb(255, 255, 255);
            margin-left: auto;
            margin-right: auto;
        }

        .formInput{
            display: flex;
            align-items: center;

            margin-bottom: 0px;
            /* border: 1px solid black; */
            border-radius: 7px;
            padding: 7px;
            flex-wrap: wrap;
        }

        .formInput>input[type='text'], .formInput>input[type='date']{
            box-sizing: border-box;
            width: 100%;
            border: none;
            outline: none;
            padding: 3px;
            font-size: 15px;
        }

        input[type='date']{
            font-family: auto;
        }

        .formInput>input[type='button']{
            width: 100%;
            padding: 3px;
            border-radius: 10px;
            background-color: rgb(255, 255, 255);
            cursor: pointer;
            margin-bottom: 3px;
        }

        .formSubmit{
            border: none;
            margin-top: 5px;
        }
        .formSubmit>input{
            background-color: rgb(255, 255, 255);
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
        }

        .formInputOn{
            border: 5px solid rgb(255, 255, 255);
        }

        #mainText{
            text-align: center;
            font-weight: bold;
            font-size: 20px;
        }

        .formWrap>div{
            margin: 5px;
        }

        .div>span{
            margin: 0 10px;
        }
        .th{
            color: aliceblue;
        }

    </style>
    </head>

    <body>
        <div id="header">
            BoardView.jsp
        </div>

		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

        <div id="contents" style="background-image: url('https://cdn.pixabay.com/photo/2020/01/27/18/47/background-4798051_640.jpg');">

            <div class="formWrap">

                <p id="mainText">상세보기</p>

                <div class="formInput">
                	<p>글 등록 시간: ${board.bdate}</p>
                    <input type="text" value="글 번호 : ${board.bno}" disabled>
                    <input type="text" value="작성자 : ${board.bwriter}" disabled>
                </div>

                <div class="formInput">
                    <input type="text" value="글 제목 : ${board.btitle}" disabled>
                </div>

                <div class="formInput">
                    <input type="text" value="글 내용 : ${board.bcontents}" disabled>
                </div>
                
                 <div class="formInput">
                    <input type="text" value="첨부파일 : ${board.bfile}" disabled>
                </div>

                <div class="formInput">
                    <img src= "${pageContext.request.contextPath}/resources/boardUpload/${board.bfilename}" >
                </div>
                <div class="formSubmit">
                    <c:if test = "${sessionScope.loginMemberId == board.bwriter}">
                    <button onclick=location.href="${pageContext.request.contextPath}/boardWriteForm">글수정</button>
                    
                        <button type="button" onclick="location.href='${pageContext.request.contextPath}/boardDelete?deleteBno=${board.bno}'" class="bdelBtn">글삭제</button>
                </c:if>
                <button type="button" onclick="location.href = '${pageContext.request.contextPath}/boardList'" class="blistBtn">글목록</button>
                </div>
            </div>
        </div>
    </body>
    
    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
    <script src="${pageContext.request.contextPath}/JS/main.js"></script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</html>