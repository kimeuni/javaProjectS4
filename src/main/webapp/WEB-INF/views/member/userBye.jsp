<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계정 탈퇴</title>
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
			<h1>계정이 비활성화 되었습니다.</h1>
			<hr/>
			<div id="user-bye-text-div">
				그동안 '다모아'를 이용해주셔서 정말 감사합니다. <br/><br/>
				귀하의 정보는 <span style="color:red">30일 동안만 유지</span>합니다. 그 이후엔 <span style="color:red">영구적으로 삭제</span>될 예정입니다. <br/><br/>
				30일 이전에 다시 로그인 시, 계정 복구가 가능하오니 참고 부탁드립니다.<br/>
			</div>
			<hr/>
			<div>
				<a href="${ctp}/damoa"><div>메인으로 이동</div></a>
			</div>
		</div>
	</div>
</body>
</html>