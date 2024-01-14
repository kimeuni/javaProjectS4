<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>임시 이미지 삭제</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#imsi-del-right-content{
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
    	#imsi-del-right-inner-content{
    		margin: 0 auto;
    		width: 100%;
    		margin-top: 70px; 
    		margin-bottom: 20px; 
    	}
    	#imsi-del-menu{
    		margin: 0 auto;
    		width : 85%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#imsi-del-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#imsi-del-flex-div{
    		display: flex;
    		height: 750px;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="imsi-del-container">
		<div id="imsi-del-right-content">
			<div id="top-menu-str">임시 이미지 삭제</div>
			<div id="imsi-del-right-inner-content">
				<div id="imsi-del-menu">
					<div id="imsi-del-menu-str">임시 이미지 삭제 <i class="fa-solid fa-image"></i></div>
					<div id="imsi-del-flex-div">
					
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>