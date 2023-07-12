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
            margin-top: 100px;
            width: 400px;
            border: 3px solid rgb(79, 223, 255);
            border-radius: 10px;
            background-color: rgba(47, 144, 255, 0.821);
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
        input[type='date']{
            font-family: auto;
        }

    </style>
    </head>

    <body>
        <div id="wrap">
        <div id="header" style="color : rgba(0, 0, 0, 0.809); background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTES2iKdaCw4VgdcQ27vw8p1tlzj04WHUFSeA&usqp=CAU);">
            MyInfo.jsp
        </div>  
        <%@ include file="/Menu.jsp" %>
            <div id="contents" style = "background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTANyD1Wgvhk3nHSbX09awJmc1KjrNygSMKJw&usqp=CAU);">
                <div class="formWrap">
                        <div class="formInput">
                            <input type="text"  value="${mInfo.mid}" readonly replaceholder="아이디">
                        </div>
                        <div class="formInput">
                            <input type="text"  value="${mInfo.mpw}" readonly placeholder="비밀번호">
                        </div>
                        <div class="formInput">
                            <input type="text" value="${mInfo.mname}" readonly placeholder="이름">
                        </div>
                        <div class="formInput">
                            <input type="date"  value="${mInfo.mbirth}" readonly>
                        </div>
                        <div class="formInput">
                            <input type="text"  value="${mInfo.maddr}" readonly>
                        </div>
                </div>
            </div>
            <hr>
</html>