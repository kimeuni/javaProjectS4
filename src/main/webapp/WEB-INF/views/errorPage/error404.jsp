<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>해당 페이지를 찾을 수 없습니다.</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
    <div class="text-center">
    	<img src="${ctp}/data/images/404에러.png" />
    	<hr/>
    	<div><button onclick="location.href='${ctp}/damoa'">홈으로 돌아가기</button></div>
    	<hr/>
    </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>