<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500에러 화면</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-main-right-content{
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
    		background-color: #fff;
			height: 50px;
			color: #000;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
			border-bottom: 1px solid;
			box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    	}
    	#admin-main-right-inner-content{
    		margin: 0 auto;
    		width: 100%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 75%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-main-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-main-container">
		<div id="admin-main-right-content">
			<div id="top-menu-str">500에러 화면</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">500에러 화면 미리보기 <i class="fa-solid fa-image"></i><i class="fa-solid fa-pen"></i></div>
						<div class="text-center">
					    	<img src="${ctp}/data/images/500에러.png" height="100%" width="100%"/>
					    	<hr/>
					    	<div><button onclick="location.href='${ctp}/damoa'">홈으로 돌아가기</button></div>
					    	<hr/>
					    </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>