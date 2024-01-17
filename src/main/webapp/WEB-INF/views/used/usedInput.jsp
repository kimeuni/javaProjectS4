<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고거래 상품 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#usedInput-container{
    		z-index: 1;
    		min-width: 100vw;
    	}
    	#used-input-div{
    		width: 900px;
    		margin: 0 auto;
    	}
    	.u-f-d{
    		display: flex;
    	}
    	.top-text{
    		display: flex;
    		font-size: 2em;
    		margin-top: 20px;
    	}
    	.pil-text{
    		margin-top: 25px;
    		margin-left : 30px;
    		color: red;
    		font-size: 1.2em;
    	}
    	#used-input-div .top-hr{
    		margin: 10px 0px;
    		border: 1px solid;
    	}
    	.f-r-str{
    		display: flex;
    		width: 18%;
    		font-size: 1.15em;
    		padding-left: 10px;
    	}
    	.f-l-input{
    		display: flex;
    		width: 82%;
    	}
    	.pil{
    		color: red;
    	}
    	.f-l-input-t{
    		display: flex;
    		width: 72%;
    	}
    	.f-l-input-t input[type="text"]{
    		width: 100%;
    		height: 40px;
    		border: 1px solid #ddd;
    		padding-left: 10px;
    	}
    	.f-l-input-t-c{
    		display: flex;
    		width: 10%;
    		line-height: 40px;
    		padding-left: 10px;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="usedInput-container">
	<div id="used-input-div">
		<div class="u-f-d">
			<div class="top-text">기본정보</div>
			<div class="pil-text">*필수항목</div>
		</div>
		<hr class="top-hr"/>
		<div class="u-f-d">
			<div class="f-r-str">상품이미지<span class="pil">*</div>
			<div class="f-l-input"></div>
		</div>
		<hr/>
		<div class="u-f-d">
			<div class="f-r-str">상품명<span class="pil">*</div>
			<div class="f-l-input-t"><input type="text" id="title" name="title" placeholder="상품명을 입력하세요. 최대 40글자" maxlength="40" required /></div>
			<div class="f-l-input-t-c">(0/40)</div>
		</div>
		<hr/>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>