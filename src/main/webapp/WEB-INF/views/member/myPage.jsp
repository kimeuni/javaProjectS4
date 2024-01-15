<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#myPage-right-content{
    		min-height : 100vh;
    		background-color: #eee;
    		margin-left : 20%;
    		display: inline-block;
    		width: 80%;
    		height : 100%;
    	}
    	#top-menu-str{
    		position: fixed;
    		width: 100%;
    		background-color: #5E5756;
			height: 50px;
			color: #fff;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
    	}
    	#myPage-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#myPage-myinfo-menu{
    		margin: 0 auto;
    		width : 75%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myPage-myinfo-menu hr{
    		margin: 0px;
    	}
    	#myPage-myinfo-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#myPage-myinfo-menu a div{
    		height: 60px;
    		line-height: 60px;
    		font-size: 1.1em;
    	}
    	#myPage-myinfo-menu a{
    		color : black;
    		text-decoration: none;
    	}
    	#myPage-alarm-menu{
    		margin-top: 20px !important;
    		margin: 0 auto;
    		width : 75%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myPage-alarm-menu a div{
    		height: 60px;
    		line-height: 60px;
    		font-size: 1.1em;
    	}
    	#myPage-alarm-menu a{
    		color : black;
    		text-decoration: none;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myPage-container">
		<div id="myPage-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myPage-right-inner-content">
				<div id="myPage-myinfo-menu">
					<div id="myPage-myinfo-menu-str">개인정보 관리 <i class="fa-solid fa-pencil"></i></div>
					<a href="${ctp}/member/pwdUpdate"><div><i class="fa-solid fa-lock"></i> 비밀번호 변경</div></a>
					<hr/>
					<a href="${ctp}/member/infoUpdate"><div><i class="fa-solid fa-pen"></i> 정보 수정</div></a>
					<hr/>
					<a href="${ctp}/member/userDel"><div><i class="fa-solid fa-user-slash"></i> 계정 탈퇴</div></a>
				</div>
				<div id="myPage-alarm-menu">
					<div id="myPage-myinfo-menu-str">알림 관리 <i class="fa-regular fa-bell"></i></div>
					<a href=""><div><i class="fa-solid fa-envelope"></i> (광고/이벤트) 메일 알림</div></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>