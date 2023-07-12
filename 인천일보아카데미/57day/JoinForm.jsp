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
        .formInputErr{
            border: 2px solid red !important;
        }
    </style>
    </head>

    <body>
        <div id="wrap">
        <div id="header" style="color : rgba(255, 255, 255, 0.809); background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY4Z6jg2jXyubi6aojstfb3G6WJJT2Z9XBVQ&usqp=CAU);">
            JoinForm.jsp
        </div>  
        <%@ include file="/Menu.jsp" %>
            <div id="contents" style = "background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOsAAADXCAMAAADMbFYxAAABMlBMVEX////z8/NaLyT90bDLqINmcnoAAAD/1bPPq4X/1LP/17Xq6urFxcXZ2dlbLiNmcnvj4+OysrKgoKBgbHQ8PDyGhoZfX199fX0uAACnpqb1y6tZZW3T09NHFgDpwaPo6OiXlZVTW2GMUTZTIxU/LitQIBIdAABZKh1AGxXBoYmhhnPQrZOSemk9DwCZmJmrjnnLpoq2k3lVUlO3l3WWel2ghWlSQ0Fyamo/KCQ3AABLQD43CAA3HReEgoIuCQC6ublHJyBCCAAyLCwxIB1LMCtPIxk4HBZmUkiGb2BFNDAsFBQnAABhTUN1YlWUioWdiXyNeGx+cWqIb11NTVBvWkePclSri2lvZFt+aFFVRDR8Z1YyOUA/SVJkWlBzQitiST1WOS52ORh7Ri0+GgRlOyldKQl53R3iAAAK4klEQVR4nO2d/VvayBbHJ6CEDEl4E5AQQ7RrkRcJCIjtLqV7WyvtXaioVZfbba3X/v//wp1JCIS37v3hzsl9pvk+TxGqj3M+npkzZ4YzA4rMtZNJ6jGBHxX1ZGbHw4dmz3IK4lFKboU1m/DbKGZKZBdZU34bxFQpL6vstzWMJc9ZeUedwiLuO7CjlMOa9dsOEGVtVn4jsFcJyprz2wog5QgrnynEqpQI2vHbBjDtoIzfJoApg5J+mwCmJNL9NgFMOor5bQKYYkjw2wQwCQErlwpY+VTAyqcCVj4VsPKpgJVPBax8KmDlUwErnwpY+ZQPrILg058XmlXvne7u7p51kz7wwrLKp8fPSmoopJb2zvKA7TqCZBW6L0ohV+reS+j3fQFZlV8OQ16VfgN+ewWOtb9bCi1K3YWFBWPN/6qGlqX+BtqNoVjXoZJu/BKk8amAWOW1qKHQYQ+i9algWIuv1qOGQi8AqzVgWF8uh6V5Lz5BCKq+CoTV3NuEGgod6+h5n70JVBCsyu6mHkwd24296DI3wRYE68nGHkx1lDkEisYArP3jH6GGQm9K71mb4AiA9fSHbiUZhXoq1/MAKRR7Vvlv3Er0eu/w9+f/YE7LnvXHo9Xtx6asMJ9pmbMqxz8IwnPPvj3NZlhXpzNn7T37L1DpoC0923vVY1pYxppVONvkVlVVz8/Pjxb+6/Ady+pI1qz9tSkTwTw6e38xqFjl9wt/C/UFQ1jWrN3VyEQ5h5WqgYkk/GHpm+/YdWPWrP9cJX0zKWsYi2Fb2vIPHLI7VMKYdbkLq0d/WGEshV1Jxrsl1mfsjh8wZu0uRGH11UVVtEFdWrF6xAur4I08xKdVp+tKmrGR9ZBdTT5bVsWTH56flbFmUFbRmDQHm1j32GUUbFnz8x3ho4mGrVqtTGC1YRhXLXEtq/oLO2vYsubc4Vr6YGGxYWFck8JS1SAPDqu0zLrH8GwfW1Z3uB6e5CjXNCh5otNyHC4xdCtbVmF36qwcGnmC74IW5lf1mOXCjimrs3RVX5gIfRTXgYbD+IM3R9wz2RnDmDW5Z/uKvvu4wCrOX2DvrHTIdveUKStdz6m/2tm8zYodSqlR1tz+jIfzhPnwhJ0pVExZT0ouqsNaM3N0zhnrSldzWWvnUKhsWU/V0PF0DvkohUWLBJ66gZvki1CbdmPROofpwIgtq/BW3XMzPhKHxRESzFgTf0T9LhqJbvLvTLDqHvsNcZasxdeHM4AM4eohIZcgrIKgoEs3PGlvVTuAARxNZcmqHL+c/fKUFhYvySvTEBskLqeq8+CkhtTSK4i3dFiy6pHi7Hmf5IXaON8jsQk3xuMGnq1grfPzs4vBGKAshimrZ+9IpwE4XLEZcbnsXa0/H9LtmAZ7WKgagkST4mnOVOOQis4LXJHoazxmbgMUa8xaThK1WmXK7CDzw4oq9iqduHTafcWhhj3kklZnbgIYa42Q4QGuilWtTIOwQRa0noWPNGFvBxyrSOcX6xQPBzUSk8NiZdCsuqBYGwJUOoHFJjpexUa1OjQMZ24VRcPefZJEzaj0IKwAYlXG9s6hKElYktwoJRkGzZJHZrL497/hfyD2rIIu58fNNZsSUpjutOEa4/Y9ljBmVcZWo2Hg1V0JERtDOV+VxA5YoStrVjOMpRVQiSzZG4OUnig2JdHihlUZVMOYzC4ETyISJfJCq1qXOZm0rfDlVyT0R4OrTrNM1Ww2O1eXo1S/GKPFEfIJHa9ttu17TYGIw3VUTCh6KpEoxpC9eBMUM98bNGjvxlfs258KgFXQs/VUvZ7qpsijmR2NPn6sNKuG6AQsfMm6/bkhzFmTtYbmkZ1FiNJsChJHjNufiz3rDRZpzrBJADm/K/as/dEoY+FNqFIVqKAWQeWIvY2OFS2Y/JAKKB++2+RXkf0SfSYgVmG8gdUAvEsVbE03WIuKa4DH+cDW6sU7bc2Y1SBvZ4Q7YyaMVwMUrsBFJthzkr3G0tQjGXCTKwI+/5qsLC3Z7+DaRtBnfZWx4XEtrkH2YPgz3Kbl7vrjcC0Le085+Nl8+bRKay9x43KUF/Kgdx+Ds+py95Ks5xrb9ivQC4HBWesoVUzVGpmiHYJTkK2Ds2ZQz0TCNYGmBeAnkJ0YmFXpdpOZumASTtMk/1LJHNxdz7Cs+Xzv9EZGJyT+6p+GqE/rovUc1MwDymrK8m27IwsEMXYT7XQ/OT7NcHT+1ZUpo2E02lYoYXdra6sVNZ1v9GFSRUDWvIz6t5SVPM+0ogQ26uaIOggsHKucR+guumWzJtsU1Xk++yZzgbHGesR9bYdVv7dRiWa5RB4gXQRjpSG35/gyceOiRu9np6wy7O+jh2I1E6StCWGM3ubvXFQSnuZJIvuPQIG6N4TGXvnWhvxza67o/axOQmG+ywbEajvNnPJ5WTvz8tI665wChtUZjEMv5ZS1nZzliALrRQ8Ia8LunsVPa1jvUWZmQJ5x3Q/MHSmkjVguf7uCuhW9IdFZmeaIgsnWDAhWwbQfu6tutVnzmf7UBpPxeXIA1r6THY1XWKOtzp+oP4+/MtsrJiBYTfoQM1dCU/TKMqysZ/0aY5spQrDmaRQeG1crfh1WLPtUx8wYtlMsBKu9tTQ22qusYWPorSFIsN2jgKmDUZA8HHRWWAcVqyoO5j/HuAITJpfIxTLYaq1E4YlmDDz1iCbj22+AcsRMzqqssl6VKwZuTg0Qeqwv+oFa52QawzWTa9mo4aazmOuzvQuGCopVGE/c4draijpPoxNDkyS7HlHP8bRWF2Z7Ea12u9NycNsXtG6tmIfZSQRjTc6Ha3Sr1Wl3KG10omnXPdY5vyswVk+GGLXV6hD61oT1oVePwFjv56yddvvqqt1pOWMW8K5nqJqf9rJfp69bJkj7VFCs6xbqDvgQpH0qsD58tx7VXsECCa6Wa7i1ZgsmGm3DFenBvcdR32m7I9UdsK328PpfcJ/JCsdqpguf/5pcdW6p2u374V/XnwvxeIHH95rN9PZ2PF0o7BMVCoV0Oh7fJtqHq/uBY82ktx05jHHn+fY1f/PrlHV/f3tB6RPAW++h/Vq4XmAtQH4qBzBrfD+9/7Owbqf3fx5WOmbT3LP2ZqwFDyvg0QZf/Bqwspe/rPGfiJV3v8YDVgAFrCy0nhXyMBLs+nUlNqX59Ot6Vk796iJ6s39OWesua8HLagK1TgXHmvqpWOMua3zOyudZ33zACtQ6FRxrcs46H69x9tXgc0GyrolNfLIq3R17v59u/Mfj23FHaaCP4bMFxSo/PD0+fgkNq42L1w/vdz5nT65Psnd3Ax5Za1Wjoh4cPJXLk69P5OuEXm8kYQx5wQQQa/7rhVUtfzk4eFsph8sPBwdfalgiqNh4A7drClWj9+3x6esNcejD15eDcpU8eV0ulyuDm4cDuHsXoO6+yT08ff9G9O9vB49PT8TBB18eHx8PDr595/B9dSGh6LqsK8nu19J3qmelhz/ueqxrSxdMAJtfPW1OBd6uD6x+KWDlUwErnwpY+VTAyqcCVj4VsPKpgJVPBax8KmDlUwErnxIQ7L24fiqGADdofZaO4M49+a0k7LW4viqDdvw2AUw7KAJ6t7OPUiIoAlmy4KdyhDUCeKTNRyUilJX5B2D/Xyhrs0Ygi3j9UirisEZg79n3Q3LEZeUe1kadsnLejVMRL2sky280TmQji6yRSI7PpELJzQjnrJHITiapxwR+FNOTmR0P338AgDcfi/Qp1gQAAAAASUVORK5CYII=);">
                <div class="formWrap">
                    <form action="${pageContext.request.contextPath}/memJoin" method="post" onsubmit="return joinCheckForm(this)">
                        <div class="formInput">
                            <input type="text" name="joinId" onblur="idCheck(this)" placeholder="아이디">
                        </div>
                        <p class="checkMsg" id = "idMsg"> 중복체크 확인 메세지 </p>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/JS/Main.js"></script>
    
    <!--아이디 중복확인 시작-->
    <script type = "text/javascript">

        function idCheck(idTag){
            console.log('입력한 아이디 : ' + idTag.value);
            //ajax - 아이디 중복 확인 요청 전송
            $.ajax({
                type : "get", //어떤 방법으로 주는가
                url :  "memIdCheck", //어디로 요청을 보내는가
                data : {"inputId" : idTag.value}, //전송할 데이터는 무엇인가?
                //key,(파라메터,이름) 변수에 값을 넣어서 전송 : 넣는 실제 값value
                success : function(result){ //전송에 성공했을때 무엇을 하려는가?
                    if(result == "Y"){
                        console.log("사용가능한 아이디");
                        $("#idMsg").css("color",'rgb(153, 243, 237)').text('사용가능한 아이디입니다.');
                    }else{
                        console.log("중복된 아이디");
                        $("#idMsg").css("color",'chartreuse').text('이미 가입된 아이디입니다.');
                        $(idTag).parent().addClass('formInputErr');
                    }
                }
                // error : function(){ },//전송에 실패했을때 무엇을 하려는가?
                // dataType : "text", //응답 받은 데이터는 무엇인가?
            });
        }
        
    </script>
    <!--아이디 중복체크 끝-->



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