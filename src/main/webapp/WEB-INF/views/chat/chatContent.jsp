<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅창</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#chat-content-container{
    		margin: 0 auto;
    		width: 1024px;
    		display: flex;
    		border-top: 1px solid #ddd;
    		border-bottom: 1px solid #ddd;
    	}
    	#chat-left-container{
    		width: 50%;
    		height: 700px;
    		border-right: 1px solid #ddd;
    	}
    	#chat-right-container{
    		width: 50%;
    		height: 700px;
    	}
    	
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="chat-content-container">
		<div id="chat-left-container">
			<jsp:include page="/WEB-INF/views/include/chatGroup.jsp" />
		</div>
		<div id="chat-right-container">
			
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>