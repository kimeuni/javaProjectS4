<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    	div #content img{
    	max-width: 600px; 
    	height: auto !important; 
    	}
    </style>
    <script>
    	'use strict'
    	
    	
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
    <div id="notice-content-container">
    	<div id="notice-content-div">
    		<div id="content">${vo.content}</div>
    	</div>
    </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>