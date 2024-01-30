<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="${encoding}">
    <title></title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<style>
	#main-search-container{
		widows: 1024px;
		margin: 0 auto;
	}
</style>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
    <div id="main-search-container">
    
    </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>