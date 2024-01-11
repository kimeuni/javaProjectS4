<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%-- <%@ page session="false" %> --%>
<html>
<head>
	<meta charset="UTF-8">
	<title>다모아</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<style> 
	#soge-bg-cl{
		background-color: #EBDDCC
	}
	#soge-bg{
		background-color: #EBDDCC;
		position: relative;
		max-width: 1024px;
		height: 655px;
		margin: 0 auto;
		z-index: 1;
	}
	#soge-title{
		padding-top: 180px;
		font-size: 3.4em;
		font-weight: bold;
		margin-bottom: 20px;
	}
	#soge-sub-title{
		font-size: 1.4em;
		color: gray;
		
	}
	#damoa-ct-img{
		position: absolute;
		top: 0px;
		right: 0px;
	}
	#advertisement-container{
		position: relative;
	}
	#advertisement-div{
		z-index: 9999;
		position: fixed;
		top : 45%;
		left: 4%;
	}
	.advertisement-close-btn:hover{
		cursor: pointer;
	}
</style>
<script>
	'use strict';
	
	$(function() {
		$(".advertisement-close-btn").on("click", function(){
			$("#advertisement-container").hide();
		});
	});
</script>
<body>
<!-- 메인화면에 띄울 광고 -->
<div id="advertisement-container">
	<div id="advertisement-div">
		<a href=""><div><img src = "" width="320px" height="320px"></div></a>
		<c:if test="${sMid == null }">
			<div class="advertisement-close-btn">창 닫기</div>
		</c:if>
		<c:if test="${sMid != null }">
			<div>오늘 하루 안보기</div>
			<div class="advertisement-close-btn">창 닫기</div>
		</c:if>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<main>
	<div id="soge-bg-cl">
		<div id="soge-bg">
			<div id="soge-title">
				<div>일상의 보물을<br/> 모두 모아</div>
			</div>
			<div id="soge-sub-title">일상의 행복을 모두 모아 <br/> '다모아'에서 함께 나누어 보세요.</div>
			<div id="damoa-ct-img"><img src="${ctp}/data/images/다모아 캐릭터.png" height="655px;"/></div>
		</div>
	</div>
	<div style="height: 1000px;"></div>
</main>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
