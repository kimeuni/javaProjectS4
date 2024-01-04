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
    	#myPage-container{
    		margin: 0px;
    		padding: 0px;
    	}
    	#myPage-left-nav{
    		position : fixed;
    		overflow : hidden;
    		background-color: #EBDDCC;
    		height : 100vh;
    		width : 20%;
    		display: inline-block;
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
    		background-color: #5E5756;
			height: 50px;
			color: #fff;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
    	}
    </style>
</head>
<body>
	<div id="myPage-container">
		<div id="myPage-left-nav">
			<div><img src="${ctp}/data/images/다모아로고1.png"></div>
			<div></div>
		</div>
		<div id="myPage-right-content">
			<div id="top-menu-str">기본 정보</div>
		</div>
	</div>
</body>
</html>