<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
    <style type="">

        .formWrap{
            margin-bottom: 0px;
            width: 400px;
            border: 3px solid black;
            padding: 10px;
            border-radius: 10px;
            background-color: white;
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

        .formInput>input[type='text']{
            box-sizing: border-box;
            width: 100%;
            border: none;
            outline: none;
            padding: 3px;
            font-size: 15px;
        }

        .formInput>input[type='button']{
            width: 100%;
            padding: 3px;
            border-radius: 10px;
            background-color: cornsilk;
            cursor: pointer;
            margin-bottom: 3px;
        }

        .formSubmit{
            border: none;
            margin-top: 5px;
        }
        .formSubmit>input{
            background-color: mistyrose;
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
        }

        .formInputOn{
            border: 5px solid palevioletred;
        }

        .formInputErr{
            border: 5px solid crimson !important;
        }

        .checkMsg{
            font-size: 12px;
            margin: 3px 5px;
			color: red;
        }

        #mainText{
            text-align: center;
            font-weight: bold;
            font-size: 20px;
        }

		.d-none{
			display: none;
		}

    </style>
    </head>

    <body>
        <div id="header">
            BoardWriteForm.jsp
        </div>

        <%@ include file="/Menu.jsp" %>

        <div id="contents" style="background-image: url('https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20230227_158%2F16774624176221Stat_JPEG%2F33_841large.jpg&type=sc960_832');">

            <div class="formWrap">
                <form action="${pageContext.request.contextPath}/boardWrite" method="post" onsubmit="return loginFormCheck(this)">

                    <p id="mainText">글쓰기</p>

                    <div class="formInput" id="inputIdDiv">
                        <input type="text" name="title" placeholder="글 제목">
                    </div>


                    <div class="formInput" id="inputPwDiv">
                        <input type="text" name="content" placeholder="글 내용">
                    </div>

                    <div class="formSubmit">
                        <input type="submit" value="완료">
                    </div>

                </form>
            </div>
        </div>

    </body>

    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    <script>
        function loginFormCheck(formObj){
            // 아이디, 비밀번호 모두 입력되어 있으면 submit 실행
            // 하나라도 미입력 되어있으면 중지
            // 미입력된 항목으로 포커스

            let idEl = formObj.title; // form >> <input name = 'title'>
            let pwEl = formObj.content; // form >> <input name = 'content'>
			let checkForm = true;

            if(idEl.value == ""){ // 아이디 입력 태그에 입력된 값이 없으면
				document.getElementById("idMsg").classList.remove("d-none");
				document.getElementById("inputIdDiv").classList.add("formInputErr");
                checkForm = false;
            }
            else{ // 아이디 입력 태그에 입력된 값이 있으면
                document.getElementById("idMsg").classList.add("d-none");
				document.getElementById("inputIdDiv").classList.remove("formInputErr");
            }

			if(pwEl.value == ""){
				document.getElementById("pwMsg").classList.remove("d-none");
				document.getElementById("inputPwDiv").classList.add("formInputErr");
                checkForm = false;
            }
            else{
                document.getElementById("pwMsg").classList.add("d-none");
				document.getElementById("inputPwDiv").classList.remove("formInputErr");
            }
            return checkForm;
        }
    </script>

	<script>
		let inputEls = document.querySelectorAll(".formInput>input");
		// console.log(inputEls.length); // 9
		for(let obj of inputEls) {
			obj.addEventListener('focus', function(e){
				e.target.parentElement.classList.add("formInputOn");
			});

			obj.addEventListener('blur', function(){
				obj.parentElement.classList.remove("formInputOn");
			});
		}

	</script>
    
    <script src="${pageContext.request.contextPath}/JS/main.js"></script>

</html>