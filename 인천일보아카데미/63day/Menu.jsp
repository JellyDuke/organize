<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
        div.nav{
            border: 3px solid black;
            border-radius: 10px;
            margin-top: 10px;
        }
        div.nav>ul{
        display: flex;
        list-style-type: none;
        padding: 0px;
        justify-content: center;
        }
        div.nav>ul>li{
        padding: 10px;
        font-size: large;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        font-weight: bold;
        border: 2px solid black;
        border-radius: 30px;
        background-color: aliceblue;
        }
        div.nav>ul>li>a{
            text-decoration: none;	
        }
    </style>
<div class="nav" style=" background-image: url(https://cdn.pixabay.com/photo/2018/05/12/02/58/drawing-3392324_640.jpg);">
        <ul>
            <li>게시판</li>
            <li><a href="${pageContext.request.contextPath}/MemberJoinForm">회원가입</a></li>
            <li>로그인</li>
        </ul>
    </div>