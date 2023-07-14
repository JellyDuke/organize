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

        #mainText{
            text-align: center;
            font-weight: bold;
            font-size: 20px;
        }

        .formWrap>div{
            margin: 5px;
        }

    </style>
    </head>

    <body>
        <div id="header">
            myInfo.jsp
        </div>

        <%@ include file="/Menu.jsp" %>

        <div id="contents" style="background-image: url('https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20230227_158%2F16774624176221Stat_JPEG%2F33_841large.jpg&type=sc960_832');">

            <div class="formWrap">

                <p id="mainText">내 정보 확인</p>

                <div class="formInput">
                    <input type="text" name="joinId" value="아이디 : ${mInfo.mid}" disabled>
                </div>

                <div class="formInput">
                    <input type="text" name="joinPw" value="비밀번호 : ${mInfo.mpw}" disabled>
                </div>

                <div class="formInput">
                    <input type="text" name="joinName" value="이름 : ${mInfo.mname}" disabled>
                </div>

                <div class="formInput">
                    <input type="text" name="joinBirth" value="생년월일 : ${mInfo.mbirth}" disabled>
                    <!-- ${mInfo.mbirth} -->
                </div>

                <div class="formInput">
                    <input type="text" value="주소 : ${mInfo.maddr}" disabled>
                </div>

            </div>

        </div>

    </body>

    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    
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

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</html>