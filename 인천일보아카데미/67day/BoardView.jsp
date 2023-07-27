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
            border: 2px solid black;
            border-radius: 10px;
        }

        .div>span{
            margin: 0 10px;
        }
        .th{
            color: aliceblue;
        }
		
	
	
		
		
    </style>
    <style type="text/css">
    	div.replyArea{
			border: 3px solid black;
			border-radius: 10px;
			width: 500px;
			margin: 0 auto;
			padding:15px;
		}
		
		.replyWrite textarea{
			border-radius: 7px;
			width: 93%;
			min-height: 70px;
			font-family: auto;
			resize: none;
			padding: 8px;
		}
		.replyWrite button{
			width: 98%;
			margin-top: 5px;
			cursor: pointer;
			padding: 5px;
		}
    </style>
    </head>

    <body>

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
              
              
                
                <%-- 댓글관련 시작 --%>
                <hr>
             	<div clas="replyArea">
             		
             		<c:if test="${sessionScope.loginMemberId != null }">
             		
             		<div class="replyWrite">
             		<h3>댓글 작성 양식 - 로그인한 경우 출력</h3>
             		<form onsubmit="return replyWrite(this)">
             			<input type="hidden" name="rebno" value="${board.bno}">
             			<textarea name = "recomment" placeholder="댓글 내용 작성"></textarea>
             			<button type = "submit">댓글 등록</button>
             		</form>
             		
             		
             		
             		</div>
             		<hr>
             		</c:if>
             		
             		<div class="replyList">
             			<h3>댓글 출력</h3>
             		</div>
             		
             	</div>
           
           
           
           
           
           		<%--댓글 관련 끝 --%>
            </div> <%--div.formWrap끝 --%>
        </div>	<%--div.contents끝 --%>
    </body>
    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
	<!-- 댓글 등록 -->
	<script type="text/javascript">
		function replyWrite(formObj) {
			console.log("replyWrite 호출" + formObj.rebno.value);
			//ajax 댓글 등록 요청 전송
			$.ajax({
				type : "get",
				url : "replyWrite",
				data : {"rebno": formObj.rebno.value, "recomment": formObj.recomment.value},
				success: function (result) {
					console.log(result);
					if(result == "1"){
						alert("댓글이 등록되었습니다.");
						//댓글 목록 조회 요청
						formObj.recomment.value = "";
						getReplyList(bno);
					}
					else{
						alert("댓글 등록이 실패하였습니다.");
					}
				}
			})
			return false;
		}
		
		//댓글 목록 조회 및 출력
		function getReplyList(rebno){
			console.log("getReplyList() 호출");
			console.log("댓글 조회 할 글번호 : " + rebno);
			//SELECT * FROM REPLYS WHERE REBNO = #{rebno} AND RESTATE = '1'
			//ORDER BY REDATE DESC
			
			//>>ArrayList<Reply> >> JSON 변환 >> 페이지로
			$.ajax({
				type: "get",
				url: "replyList",
				data: {"rebno" : rebno},
				dataType: "json", 
				success : function(reList){
					console.log("reList"+ reList);
				}
			});
		}
	</script>
	
	<script type="text/javascript">
		let bno = '${board.bno}';
		$(document).ready(function(){
			getReplyList(bno);
		});
	</script>
	
    
    
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</html>