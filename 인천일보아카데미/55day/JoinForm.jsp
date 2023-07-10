<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
    <style type="text/css">
        .formWrap{
            margin-top: 20px;
            width: 400px;
            border: 3px solid rgb(255, 202, 202);
            border-radius: 10px;
            background-color: rgba(165, 60, 60, 0.678);
            padding: 10px;
            margin-left: auto;
            margin-right: auto;
        }
        .formInput{
            margin-bottom: 0px;
            border: 1px solid rgb(163, 255, 249);
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
            background-color: rgb(201, 255, 245);
            cursor: pointer;
            margin-bottom: 3px;
            font-weight: bold;
        }
        .formSubmit{
            border: none;
            margin-top: 10px;
        }
        .formSubmit>input{
            background-color: rgb(201, 255, 245);
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
            background-color: coral;
        }
        .checkMsg{
            font-size: 13px;
            margin: 5px;
            color: white;
        }
    </style>
    </head>

    <body>
        <div id="wrap">
        <div id="header" style="background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfQNA4l2MkgwiiRUvGMwTfnky6bJF_CDdqHw&usqp=CAU);">
            JoinForm.jsp
        </div>  
        <%@ include file="/Menu.jsp" %>
            <div id="contents" style = "background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ2GXdiL5-trELCF1cgYUpluUPTz_dXYvXSA&usqp=CAU);">
                <div class="formWrap">
                    <form action="${pageContext.request.contextPath}/memJoin" method="post" onsubmit="return joinCheckForm(this)">
                        <div class="formInput">
                            <input type="text" name="joinId" placeholder="아이디">
                        </div>
                        <p class="checkMsg"> 중복체크 확인 메세지 </p>
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
                            <input type="text" name="postcode" onclick="sample6_execDaumPostcode()" id="sample6_postcode" placeholder="우편번호">
                            <input type="text" name="address" id="sample6_address" placeholder="주소"><br>
                            <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                            <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
                        </div>
                        <div class="formSubmit">
                            <input type="submit" value="회원가입">
                        </div>
                    </form>
                </div>
            </div>
            <hr>

        <div id="contents">
            <%-- 아이디(중복확인- ajax), 비밀번호, 이름, 생년월일, 주소(다음 우편 서비스) --%>
            <form action="${pageContext.request.contextPath}/memJoin" method="post">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td> <input type="text" name="joinId"> </td>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <td> <input type="text" name="joinPw"> </td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td> <input type="text" name="joinName"> </td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td> <input type="date" name="joinBirth"> </td>
                    </tr>
                    <tr>
                        <th> 주소 </th>
                        <td>
                            <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
                            <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                            <input type="text" name="address" id="sample6_address" placeholder="주소"><br>
                            <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                            <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목">
                        </td>
                    </tr>
                    <tr>
                        <th colspan="2"> <input type="submit" value="회원가입"></th>
                    </tr>
                </table>
            </form>

            </div>   
        </div>
    </body>
    <script src="${pageContext.request.contextPath}/JS/Main.js"></script>
        <!--회원가입 양식 JS 시작-->
    <script type = "text/javascript">
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
        function joinCheckForm(formObj){
            //아이디 ~ 주소 모두 입력 되어 있으면 submit 실횅
            //하나라도 미입력 되어 있으면 submit 중지
            //미입력된 항목으로 포커스
            let idEl = formObj.joinId; //form 태그 안의 input name = "joinId" 요소를 선택
            let pwEl = formObj.joinPw; //form 태그 안의 input name = "joinPw" 요소를 선택
            if(idEl.value == ""){
                alert("아이디를 입력하세요!");
                idEl.focus();
                return false;
            }
            if(formObj.joinPw.value == ""){
                alert("비밀번호를 입력 해주세요!");
                formObj.joinPw.focus;23
                return false;
            }
            if(formObj.joinName.value == ""){
                alert("이름을 입력 해주세요!");
                formObj.joinName.focus;
                return false;
            }
            if(formObj.joinBirth.value ==""){
                alert("날짜를 입력 해주세요!");
                formObj.joinBirth.focus;
                return false;
            }
            if(formObj.postcode.value==""){
                alert("우편번호를 입력 해주세요!");
                formObj.postcode.focus;
                return false;
            }
            if(formObj.address.value==""){
                alert("주소를 입력 해주세요!");
                formObj.address.focus;
                return false;
            }
            if(formObj.detailAddress.value==""){
                alert("상세주소를 입력 해주세요!");
                formObj.detailAddress.focus;
                return false;
            }
            return true;
        }
    
    </script>





































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