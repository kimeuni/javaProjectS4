<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영구정지</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#user-bye-container{
    		min-width: 100vw;
    		min-height: 100vh;
    		background-color: #eee;
			display: inline-block;
    	}
    	#user-bye-div{
			margin: 0 auto;
    		margin-top: 100px;
    		width: 800px;
    	}
    	#user-bye-div hr{
    		border: 0.5px solid black;
    	}
    	#user-bye-text-div{
    		height: 450px;
    	}
    	#user-bye-div #rogo-img, #user-bye-div a{
    		text-align: center;
    		margin: 10px;
    	}
    </style>
</head>
<body>
	<div id="user-bye-container">
		<div id="user-bye-div">
		<div id="rogo-img"><img src="${ctp}/data/images/다모아로고1.png" height="65px"/></div>
			<h1>해당 계정은 영구 정지 처리되었습니다.</h1>
			<hr/>
			<div id="user-bye-text-div">
				서비스 운영정책 위반으로 해당 계정은 '다모아 이용이 <span style="color: red">영구 제한</span>되었습니다. <br/><br/>
				
				정지 기간 : 영구 정지 <br/>
				제한 사유 : 서비스 운영정책 위반 신고 누적
			</div>
			<hr/>
			<div>
				<a href="${ctp}/damoa"><div>메인으로 이동</div></a>
			</div>
		</div>
	</div>
</body>
</html>