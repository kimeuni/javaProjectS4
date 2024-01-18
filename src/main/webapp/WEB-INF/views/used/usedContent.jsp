<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${usedVO.title}</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style>
    	#used-content-container{
    		width: 1024px;
    		margin: 0 auto;
    	}
    	.mySlides {
    		display:none;
    	}
    	.used-content-flex-div{
    		display: flex;
    		min-height: 300px;
    	}
    	.used-content-flex-left{
    		display: flex;
    		width: 40%;
    	}
    	.f-d{
    		display: flex;
    	}
    	.used-content-flex-right{
    		display: flex;
    		width: 60%;
    	}
    	.bor-b{
    		border: 1px solid black;
    	}
    	.u-title{
    		font-size: 1.7em;
    		font-weight: bold;
    		margin-bottom: 10px;
    	}
    	.u-money{
    		font-size: 1.9em;
    		font-weight: bold;
    	}
    	.str-w3{
    		min-width: 50px;
    		text-align: center;
    		margin-bottom: 10px;
    	}
    	.str-w1{
    		min-width: 80px;
    		margin-bottom: 10px;
    		color: #aaa;
    	}
    	.mt-1{
    		margin-top: 10px !important;
    		justify-content: space-evenly;
    	}
    	.u-btns-flex{
    		display: flex;
    		width: 33%;
    		/* justify-content: space-around; */
    	}
    	.like-btn, .management-btn, .report-btn{
    		background-color: #aaa;
    		border: 1px solid;
    		width: 150px;
    		height: 40px;
    		font-size: 1.1em;
    		font-weight: bold;
    		text-align: center;
    		line-height: 40px;
    	}
    	.u-btns-flex a{
    		text-decoration: none;
    	}
    </style>
    
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="used-content-container">
	<div class="f-d">
		<div><i class="fa-solid fa-house"></i> 홈 <i class="fa-solid fa-chevron-right"></i> </div> &nbsp;
		<div>${topCategoryName}</div>
		<c:if test="${midCategoryName != '0' }"><div>&nbsp; <i class="fa-solid fa-chevron-right"></i> &nbsp;${midCategoryName }</div></c:if>
		<c:if test="${btmCategoryName != '0' }"><div>&nbsp; <i class="fa-solid fa-chevron-right"></i> &nbsp;${btmCategoryName }</div></c:if>
	</div>
	<hr class="bor-b" />
	<div class="used-content-flex-div">
		<div class="used-content-flex-left">
			<div class="w3-content w3-display-container">
				<c:set var="imgss" value="${fn:split(usedVO.imgs,'/') }"/>
				<c:forEach var="imgs"  items="${imgss}">
					<img class="mySlides" src="${ctp}/data/used/${imgs}" height="350px" style="width:350px">
				</c:forEach>
				
				<button class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
				<button class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
			</div>
		</div>
		<div class="used-content-flex-right">
			<div style="width: 100%;">
				<div class="u-title">${usedVO.title}</div>
				<div class="u-money">${usedVO.money }원</div>
				<hr />
				<div class="f-d">
					<div class="str-w3"><i class="fa-solid fa-heart"></i> ${usedVO.totLike }</div>
					<div class="str-w3"><i class="fa-solid fa-eye"></i> ${usedVO.viewCnt }</div>
					<div class="str-w3">일전</div>
				</div>
				<div class="f-d">
					<div class="str-w1">상품상태</div>
					<div>${usedVO.usedState }</div>
				</div>
				<div class="f-d">
					<div class="str-w1">교환여부</div>
					<div>
						<c:if test="${usedVO.exchange == '가능' }">교환 가능</c:if>
						<c:if test="${usedVO.exchange == '불가' }">교환 불가능</c:if>
					</div>
				</div>
				<div class="f-d">
					<div class="str-w1">배송비</div>
					<div>
						<c:if test="${usedVO.delivery == 0}">배송비 포함</c:if>
						<c:if test="${usedVO.delivery != 0}">배송비 별도 (${usedVO.delivery}원)</c:if>
					</div>
				</div>
				<div class="f-d">
					<div class="str-w1">거래지역</div>
					<div>${usedVO.region}</div>
				</div>
				<div class="f-d mt-1">
					<div class="u-btns-flex"><a href="" class="like-btn">찜하기</a></div>
					<c:if test="${sMid == usedVO.mid }">
						<div class="u-btns-flex"><a href="" class="management-btn">상점관리</a></div>
					</c:if>
					<div class="u-btns-flex"><a href="" class="report-btn">신고</a></div>
				</div>
			</div>
		</div>
	</div>
	<hr class="bor-b" />
	<div>
		
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
   	'use strict'
   	
   	// 이미지 넘기기
   	let slideIndex = 1;
	showDivs(slideIndex);
	
	function plusDivs(n) {
	    showDivs(slideIndex += n);
	}

	function showDivs(n) {
	    let i;
	    let x = document.getElementsByClassName("mySlides");
	    if (n > x.length) {slideIndex = 1}
	    if (n < 1) {slideIndex = x.length} ;
	    for (i = 0; i < x.length; i++) {
	    	x[i].style.display = "none";
	    }
	    x[slideIndex-1].style.display = "block";
	}
</script>
</body>
</html>