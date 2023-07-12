<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
    </head>
    <style type="text/css">
        .formWrap{
            margin-top: 140px;
            width: 400px;
            border: 3px solid rgb(0, 0, 0);
            border-radius: 10px;
            background-color: rgba(189, 189, 189, 0);
            padding: 10px;
            margin-left: auto;
            margin-right: auto;
        }
        .formInput{
            margin-bottom: 0px;
            border: 1px solid rgba(0, 0, 0, 0.897);
            border-radius: 10px;
            padding: 7px;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }
        .formInput>input[type='text'], .formInput>input[type='date']{
            box-sizing: border-box;
            width: 100%;
            border: none;
            outline: none;
            padding: 5px;
            font-size: 17px;
        }
        .formInput>input[type='button']{
            width: 100%;
            padding: 5px;
            border-radius: 10px;
            background-color: rgb(0, 0, 0);
            cursor: pointer;
            margin-bottom: 3px;
            font-weight: bold;
        }
        .formSubmit{
            border: none;
            margin-top: 10px;
        }
        .formSubmit>input{
            background-color: rgb(255, 252, 252);
            width: 100%;
            border-radius: 10px;
            padding: 7px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }
        input[type='date']{
            font-family: auto;
        }
        .formInputOn{
            background-color: rgb(0, 0, 0);
            padding: 4px;
        }
        .checkMsg{
            font-size: 15px;
            font-weight: bold;
            margin: 5px;
            color: red;
            display: none;
            background-color: white;
        }
        .formInputErr{
            border: 2px solid red !important;
        }
    </style>
    <body>
        <div id="header" style="background-image: url(data:image/png;base64,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);">
            LoginForm.jsp
        </div>

        <%@ include file="/Menu.jsp" %>

        <div id="contents" style="background-image: url(data:image/png;base64,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);">
            <div class="formWrap">
                    <form action="${pageContext.request.contextPath}/memLogin" method="post" onsubmit="return joinCheckForm(this)">
                        <div class="formInput">
                            <input type="text" name="loginId" onblur="idCheck(this)" placeholder="아이디">
                        </div>
                        <p class="checkMsg" id = "idMsg"> 아이디를 입력 해주세요! </p>
                        <div class="formInput">
                            <input type="text" name="loginPw" placeholder="비밀번호">
                        </div>
                        <p class="checkMsg" id = "pwMsg"> 비밀번호를 입력해주세요!</p>

                        <div class="formSubmit">
                            <input type="submit" value="로그인">
                        </div>
                    </form>
                </div>
        </div>

    </body>
    <script>
        function joinCheckForm(formObj){
            //아이디 ~ 주소 모두 입력 되어 있으면 submit 실횅
            //하나라도 미입력 되어 있으면 submit 중지
            //미입력된 항목으로 포커스
            let checkMsg1 = document.getElementById("idMsg");
            let checkMsg2 = document.getElementById("pwMsg");

            let idEl = formObj.joinId; //form 태그 안의 input name = "joinId" 요소를 선택
            let pwEl = formObj.joinPw; //form 태그 안의 input name = "joinPw" 요소를 선택
            let checkForm = true;
            if(idEl.value == ""){
                idEl.focus();
                checkMsg1.style.display = "block";
                checkForm = false;
            }else{
                checkMsg1.style.display = "none";
            }
            if(formObj.joinPw.value == ""){
                pwEl.focus();
                checkMsg2.style.display = "block";
                checkForm = false;
            }else{
                checkMsg2.style.display = "none";
            }
            return checkForm;
        }
    </script>
    <script>    
        let inputEls = document.querySelectorAll(".formInput>input");
        console.log(inputEls.length);
        for(let obj of inputEls){
            obj.addEventListener('focus',function(e){       
                e.target.parentElement.classList.add("formInputOn");
            });
            obj.addEventListener('blur',function(e){
                e.target.parentElement.classList.remove("formInputOn");
            });
        }
    </script>

</html>