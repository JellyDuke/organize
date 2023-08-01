<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
        <style type="">
        #inputPwDiv{
            height: 200px;
        }
		.bcontent{
			height: 500px;
		}
        .formWrap{
            margin-bottom: 10px;
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



    </style>
    </head>

    <body>

       <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

        <div id="contents" style="background-image: url('https://cdn.pixabay.com/photo/2018/04/06/15/17/pattern-3296033_640.png');">

            <div class="formWrap">
                <form action="${pageContext.request.contextPath}/boardWrite" method="post" enctype="multipart/form-data">

                    <p id="mainText">글쓰기</p>

                    <div class="formInput" >
                        <input type="text" name="btitle" placeholder="글 제목">
                    </div>

                    <div class="formInput">
                        <input type="text" name="bcontents" placeholder="글 내용">
                    </div>
					
					<div class="formInput">
                        <input type="file" name="bfile">
                    </div>
                    
                    <div class="formSubmit">
                        <input type="submit" value="글등록">
                    </div>

                </form>
            </div>
        </div>

    </body>

    <!-- jquery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script type="text/javascript">
	let msg = '${msg}';
	if(msg.length > 0){
		alert(msg);
	}
	</script>
</html>