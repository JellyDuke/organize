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

        .formInputErr{
            border: 2px solid red !important;
        }

        .checkMsg{
            font-size: 12px;
            margin: 3px 5px;
        }

        #mainText{
            text-align: center;
            font-weight: bold;
            font-size: 20px;
        }

    </style>
    </head>

    <body>
        <div id="header">
            JoinForm.jsp
        </div>

        <%@ include file="/Menu.jsp" %>

        <div id="contents" style="background-image: url('https://cdn.pixabay.com/photo/2022/01/21/11/37/pandas-6954571_640.jpg');">

            <div class="formWrap">
                <form action="${pageContext.request.contextPath}/memJoin" method="post" onsubmit="return joinFormCheck(this)">

                    <p id="mainText">회원가입</p>

                    <div class="formInput">
                        <input type="text" name="joinId" onblur="idCheck(this)" placeholder="아이디">
                    </div>
                    <p class="checkMsg" id="idMsg">중복체크 확인 메세지</p>

                    <div class="formInput">
                        <input type="text" name="joinPw" placeholder="비밀번호">
                    </div>

                    <div class="formInput">
                        <input type="text" name="joinName" placeholder="이름">
                    </div>

                    <div class="formInput">
                        <input type="date" name="joinBirth">
                    </div>

                    <div class="formInput">
                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                        <input type="text" name="postcode" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="우편번호" >
                        <input type="text" name="address" id="sample6_address" placeholder="주소" ><br>
                        <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" >
                        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                    </div>

                    <div class="formSubmit">
                        <input type="submit" value="회원가입">
                    </div>

                </form>
            </div>
        </div>

        <hr>

        <div id="contents" style="background-image: url('https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTAzMDRfOTkg%2FMDAxNjE0ODA0MDcwNDA1.turrKEoxmJ7qCmhMVUwrBAYpB8k_wtJBfu-sl-YiFbQg.luvDT1Q7foO0E7f1VumkEpPMlJirGGOf-DOwvewlXOAg.JPEG.zootagonia%2FIMG_5365.JPG&type=sc960_832');">
            <%-- 아이디(중복확인 - ajax), 비밀번호, 이름, 생년월일, 주소(다음 우편 서비스) --%>

            <form action="${pageContext.request.contextPath}/mamJoin" method="post">

                <table>
                    <tr>
                        <th colspan="2">회원가입</th>
                    </tr>

                    <tr>
                        <th>아이디</th>
                        <td><input type="text" name="joinId"></td>
                    </tr>

                    <tr>
                        <th>비밀번호</th>
                        <td><input type="text" name="joinPw"></td>
                    </tr>

                    <tr>
                        <th>이름</th>
                        <td><input type="text" name="joinName"></td>
                    </tr>

                    <tr>
                        <th>생년월일</th>
                        <td><input type="date" name="joinBirth"></td>
                    </tr>

                    <tr>
                        <th>주소</th>
                        <td>
                            <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" >
                            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                            <input type="text" name="address" id="sample6_address" placeholder="주소" ><br>
                            <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                            <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" >
                        </td>
                    </tr>

                    <tr>
                        <th colspan="2"><input type="submit" value="회원가입"></th>
                    </tr>
                </table>

            </form>

        </div>

    </body>

    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <!-- 아이디 중복 확인 시작 -->
    <script>
        function idCheck(idTag){
            console.log('입력한 아이디 : ' + idTag.value);

            let idmsg = $("#idMsg");

            // ajax - 아이디 중복 확인 요청
            $.ajax( {
                type: "get", // get, post
                // url: "${pageContext.request.contextPath}/mamIdCheck"
                url: "memIdCheck", // 요청 url
                data: { "inputId" : idTag.value }, // 전송할 데이터 ( 키 : 값 )
                // dataType: "text", // 응답받은 데이터 타입
                success: function(result){
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
                }, // 전송에 성공하면 실행
                // error: function(){} // 전송에 실패하면 실행
            } )
        }
    </script>
    <!-- 아이디 중복 확인 끝 -->

    <script>
        function joinFormCheck(formObj){
            // 아이디 ~ 주소 모두 입력되어 있으면 submit 실행
            // 하나라도 미입력 되어있으면 중지
            // 미입력된 항목으로 포커스

            let idEl = formObj.joinId; // form >> <input name = 'joinId'>
            let pwEl = formObj.joinPw; // form >> <input name = 'joinPw'>
            let nameEl = formObj.joinName;
            let birthEl = formObj.joinBirth;
            let postcodeEl = formObj.postcode;
            let addressEl = formObj.address;
            let extraAddrEl = formObj.extraAddress;
            let detailAddrEl = formObj.detailAddress;

            if(idEl.value == ''){
                alert("아이디를 입력해 주세요!");
                idEl.focus();
                return false;
            }
            if(pwEl.value == ''){
                alert("비밀번호를 입력해 주세요!");
                pwEl.focus();
                return false;
            }
            if(nameEl.value == ''){
                alert("이름을 입력해 주세요!")
                nameEl.focus();
                return false;
            }
            if(birthEl.value == ''){
                alert("생년월일을 입력해 주세요!");
                birthEl.focus();
                return false;
            }
            if(postcodeEl.value == ''){
                alert("우편번호를 입력해 주세요!");
                postcodeEl.focus();
                return false;
            }
            if(addressEl.value == ''){
                alert("주소를 입력해 주세요!");
                addressEl.focus();
                return false;
            }
            if(extraAddrEl.value == ''){
                alert("참고항목을 입력해 주세요!");
                extraAddrEl.focus();
                return false;
            }
            if(detailAddrEl.value == ''){
                alert("상세주소를 입력해 주세요!");
                detailAddrEl.focus();
                return false;
            }
            return true;
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

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>

</html>