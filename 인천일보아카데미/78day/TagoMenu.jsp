<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
	<!-- Socket -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	
	<div class="nav">
		<ul>
		<li> <a href="${pageContext.request.contextPath}/tagoBus">새로고침</a></li>
		</ul>
		
	</div>
	
	<!-- 모든 페이지에 적용을 해야 알람이 된다. -->
	<!-- JQUERY -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js"></script>
	<!-- Socket -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<!-- NOTICEJS JS -->
	<script src="${pageContext.request.contextPath }/resources/js/NoticeJs.js"></script>
	
	
	<script type="text/javascript">
	let msg = '${msg}';
	if(msg.length > 0){
		alert(msg);
	}
	</script>
	
	
	<script type="text/javascript">

		function toastrOn() {
		toastr.options = {
			"positionClass": "toast-bottom-right"
		}
		toastr.info('새 글이 등록 되었습니다.')
			
		}
	
	</script>