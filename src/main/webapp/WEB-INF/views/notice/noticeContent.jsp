<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항| ${vo.title}</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#notice-content-container{
    		max-width: 1024px;
    		min-height: 200px;
    		margin: 0 auto;
    	}
    	#notice-content-div{
    		border-bottom: 1px solid #5E5756;
    	}
    	div #content img{
    	max-width: 600px; 
    	height: auto !important; 
    	}
    	#notice-str-div{
    		margin-top: 50px;
    		margin-bottom: 40px;
    	}
    	#notice-str{
    		width: 90%;
    		display: inline-block;
    	}
    	#notice-list{
    		width: 8%;
    		display: inline-block;
    	}
    	#notice-list-btn{
    		width: 100px;
    		height: 40px;
    		line-height: 40px;
    		background-color: #eee;
    		border-radius: 5px;
    		text-align: center;
    		border: 1px solid #5E5756;
    	}
    	#notice-list a{
    		text-decoration: none;
    		color: #000;
    	}
    	#notice-title-div{
    		border-bottom: 1px solid #5E5756;
    		border-top: 1px solid #5E5756;
    		background-color: #F1E5D4;
    		height: 80px;
    		font-size: 1.5em;
    		line-height: 80px;
    		padding: 0px 15px;
    		color: #5E5756;
    	}
    	#notice-read-date{
    		height: 60px;
    		line-height: 60px;
    		border-top: 1px solid #5E5756;
    		text-align: right;
    		width: 100%;
    		color: #CEBAAD;
    	}
    	#notice-read{
    		width: 20%;
    		display: inline-block;
    	}
    	#notice-date{
    		padding-right: 20px;
    		width: 17%;
    		display: inline-block;
    	}
    	#notice-content{
    		margin: 20px 40px;
    	}
    </style>
    <script>
    	'use strict'
    	
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
    <div id="notice-content-container">
    	<div id="notice-str-div">
    		<div id="notice-str"><h2>공지사항</h2></div>
    		<div id="notice-list">
    			<a href="${ctp}/board/noticeList"><div id="notice-list-btn">목록</div></a>
   			</div>
    	</div>
    	<div id="notice-content-div">
			<div id="notice-read-date">
				<div id="notice-read"><i class="fa-solid fa-eye"></i>${vo.readNum}</div>
				<div id="notice-date"><i class="fa-regular fa-calendar-days"></i>${fn:substring(vo.NDate,0,10)}</div>
			</div>
			<div id="notice-title-div">
				<div id="notice-title-str">${vo.title}</div>
			</div>
			<div id="notice-content">${vo.content}</div>
    	</div>
		<div>다음글 이전글 처리하기</div>
    </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>