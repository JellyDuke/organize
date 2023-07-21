<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>

<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">
<style>

/* 컨텐츠 영역 스타일 */
.contents {
    margin-top: 20px;
}

/* 폼 스타일 */
.formWrap {
    border: 2px solid black;
    margin-bottom: 10px;
    width: 400px;
    padding: 20px;
    margin-left: auto;
    margin-right: auto;
    border-radius: 20px;
    background-color: rgba(255, 255, 255, 0.92);
}
.formInputErr{
    border: 2px solid red !important;
}
.formRow{
    display: flex;
    align-items: center;
    margin-bottom: 0px;
    border: 1px solid black;
    border-radius: 7px;
    padding: 7px;
    flex-wrap: wrap;
}
.formRow>input[type='text'], .formRow>input[type='date']{
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
.checkMsg{
    font-size: 15px;
    margin: 3px 5px;
}
.formSubmit>input{
    background-color: mistyrose;
    width: 100%;
    padding: 10px;
    border-radius: 10px;
    font-weight: bold;
    cursor: pointer;
}
.formRow>input[type='button']{
    width: 100%;
    padding: 3px;
    border-radius: 10px;
    background-color: rgba(255, 250, 230, 0.91);
    cursor: pointer;
    margin-bottom: 3px;
}
.formSubmit{
    border: none;
    margin-top: 5px;
}
</style>
<body>
	<div class= "header" style="background-image: url(https://cdn.pixabay.com/photo/2017/06/10/13/41/marble-2389894_640.jpg);">
    <h1>views/member/MainJoinForm.jsp</h1>
    </div>
    <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
    <div class="contents" style="background-image: url(https://cdn.pixabay.com/photo/2017/07/10/13/03/seamless-2490061_640.png);">
        <h2 style="background-color: rgba(248, 248, 248, 0.929); text-align: center; border: 2px solid black; border-radius: 20px;">회원가입</h2>
        <!-- 아이디,비밀번호, 이름, 생년월일, 이메일 -->
        <div class="formWrap">
            <form action="memberJoin" method="post">
                <div class="formRow">
                    <input type="text" id = "inputId" name="mid" placeholder="아이디">
                </div>
                <button type="button" onclick="idCheck()">중복확인</button>
                <p id="idMsg" class="checkMsg">중복확인 메세지</p>
                <div class="formRow">
                    <input type="text" name="mpw" placeholder="비밀번호">
                </div>
                <div class="formRow">
                    <input type="text" name="mname" placeholder="이름">
                </div>
                <div class="formRow">
                    <input type="date" name="mbirth">
                </div>
                <div class="formRow">
                    <input type="text" name="memailId"  placeholder="이메일아이디">
                    <input type="text" name="memailDomain" id="edomain" placeholder="이메일도메인">
                <select onchange="selectedDomain(this)">
                    <option value="">직접입력</option>
                    <option value="naver.com">네이버</option>
                    <option value="google.com">구글</option>
                </select>
                </div class="formSubmit">
                <input type="submit" value="회원가입">
            </form>
        </div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script> 
<script>
    function selectedDomain(selObj){
        document.querySelector('#edomain').value = selObj.value;
    }
    </script>
    <script type="text/javascript">
        function idCheck(){
            //중복확인 할 아이디 VALUE 확인
            let idEl = document.querySelector('#inputId');
            let idmsg = $("#idMsg");
            console.log(idEl.value);
            //ajax - 아이디 중복 확인 요청 (memberIdCheck)
            $.ajax({
                type: "get", //전송방식
            url: "memberIdCheck", //전송 URL
            data: {"inputId" : idEl.value}, //전송 파라미터
            success: function(result){ //전송 성공 했을때
                console.log("확인결과 : "+result);
                if(result == "Y"){
                        console.log("사용가능한 아이디");
                        $("#idMsg").css("color", 'green').text("사용 가능한 아이디입니다.");
                        idmsg.parent().removeClass("formInputErr");
                    }
                    else{
                        console.log("사용 불가능한 아이디");
                        $("#idMsg").css("color", 'red').text("이미 가입된 아이디입니다.");
                        idmsg.parent().addClass("formInputErr");
                    }
            }
        })
    }
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</html>