$.ajax({
				type: "get",                      //방식
				url : "getBusArr",                //접속할 url
				data : {"nodeId" :  nodeId},      //보내줄 데이터 키, 내용
				dataType : "json",                //데이터 타입
        async : false,                    //코드 순서를 맞추기 위함, 스택 밖에 따로 실행하지 않는다 false.
				success : function (arrInfoList){ //데이터 전송 성공시 실행할 코드	
				printBusInfo(arrInfoList); 

				}
			});

