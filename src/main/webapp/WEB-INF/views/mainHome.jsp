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
	#soge-container{
		z-index: 1;
	}
	#soge-bg-cl{
		background-color: #EBDDCC;
	}
	#soge-bg{
		background-color: #EBDDCC;
		position: relative;
		max-width: 1024px;
		height: 655px;
		margin: 0 auto;
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
	.advertisement-container{
		position: relative;
	}
	.advertisement-div{
		z-index: 9999;
		position: fixed;
		top : 45%;
		left: 4%;
	}
	.advertisement-close-btn:hover{
		cursor: pointer;
	}
	#mid-no-close-btn{
		padding: 10px 0px;
	}
	.ad-str-div{
		background-color: #252525;
		color: #fff;
		text-align: center;
		padding: 10px 0px;
	}
	.oneDay-no-open{
		width: 48%;
		display: inline-block;
		border-right: 1px solid #fff;
	}
	.oneDay-no-open:hover{
		cursor: pointer; 
	}
	.mid-yes-close-btn{
		width: 48%;
		display: inline-block;
	}
	.f-d{
		display: flex;
	}
	#used-container{
		background-color: #FFF8F1;
		min-width: 100vw;
	}
	.used-container{
		width: 1024px;
		margin: 0 auto;
		height: 655px;
	}
	#comu-container{
		background-color: #F9F9F9;
		min-width: 100vw;
	}
	.comu-container{
		width: 1024px;
		margin: 0 auto;
		height: 655px;
	}
	#ask-container{
		background-color: #F0EFEB;
		min-width: 100vw;
	}
	.ask-container{
		width: 1024px;
		margin: 0 auto;
		height: 655px;
	}
	.f-d-7{
		display : flex;
		width: 700px;
	}
	.f-d-3{
		display: flex;
		width: 324px;
	}
	.top-text-div{
		margin-top: 55%;
		color: orange
	}
	.btm-text-div{
		margin-top: 5%;
		font-size: 2em;
		font-weight: bolder;
	}
	.btm-btn-div input[type="button"]{
		margin-top : 5%;
		width: 150px;
		height: 40px;
		line-height: 40px;
		font-size: 1.2em;
		background-color: #5E5756;
		color: #fff;
		border: 1px solid #5E5756;
		border-radius: 5px;
	}
</style>
<script>
	'use strict';
	
	// 창닫기
	$(function() {
		$(".advertisement-close-btn").on("click", function(){
			$(".advertisement-container").hide();
		});
	});
	
	// 오늘 하루 안보기
	$(function() {
		$(".oneDay-no-open").on("click", function() {
			
			$.ajax({
				url : "${ctp}/userShowNUpdate",
				type : "post",
				data : {mid : '${sMid}'},
				success : function(res){
					$(".advertisement-container").hide();
				},
				error : function(){
					alert("전송오류(mainHome.jsp)")
				}
			});
		});
	});
</script>
<body>
<!-- 메인화면에 띄울 광고 -->
<c:if test="${mainAdVO.openSw == 'Y' && userAdVO.alarm == 'Y' }">
	<div class="advertisement-container">
		<div class="advertisement-div">
			<a href="${mainAdVO.url}" target="_blank"><div><img src = "${ctp}/data/advertisement/${mainAdVO.mainImg}" width="320px" height="320px"></div></a>
			<div class="ad-str-div">
				<div class="oneDay-no-open">오늘 하루 안보기</div>
				<div class="advertisement-close-btn mid-yes-close-btn">창 닫기</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${mainAdVO.openSw == 'Y' && empty userAdVO.alarm}">
	<div class="advertisement-container">
		<div class="advertisement-div">
			<a href="${mainAdVO.url}" target="_blank"><div><img src = "${ctp}/data/advertisement/${mainAdVO.mainImg}" width="320px" height="320px"></div></a>
			<div class="ad-str-div">
				<div class="advertisement-close-btn mid-no-close-btn">창 닫기</div>
			</div>
		</div>
	</div>
</c:if>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<div id="soge-container">
	<div id="soge-bg-cl">
		<div id="soge-bg">
			<div id="soge-title">
				<div>일상의 보물을<br/> 모두 모아</div>
			</div>
			<div id="soge-sub-title">일상의 행복을 모두 모아 <br/> '다모아'에서 함께 나누어 보세요.</div>
			<div id="damoa-ct-img"><img src="${ctp}/data/images/다모아 캐릭터.png" height="655px;"/></div>
		</div>
	</div>
	<div id="used-container">
		<div class="f-d used-container">
			<div class="f-d-7">
				<img src="${ctp}/data/images/중고.png" width="700px" height="655px">
			</div>
			<div class="f-d-3 ">
				<div style="width: 100%; padding: 30px; text-align: right">
					<div class="top-text-div">중고거래</div>
					<div class="btm-text-div">행복을 나누는<br/> 중고거래</div>
					<div class="btm-btn-div"><input type="button" value="중고거래" onclick="location.href='${ctp}/used/usedMain'" /></div>
				</div>
			</div>
		</div>
	</div>
	<div id="comu-container">
		<div class="f-d comu-container">
			<div class="f-d-3">
				<div style="width: 100%; padding: 30px;">
					<div class="top-text-div">커뮤니티</div>
					<div class="btm-text-div">당신의 즐거운<br/> 일상을 공유</div>
					<div class="btm-btn-div"><input type="button" value="커뮤니티" onclick="location.href='${ctp}/community/communityMain'" /></div>
				</div>
			</div>
			<div class="f-d-7">
				<img src="${ctp}/data/images/커뮤.png" width="700px" height="655px">
			</div>
		</div>
	</div>
	<div id="ask-container">
		<div class="f-d ask-container">
			<div class="f-d-7">
				<img src="${ctp}/data/images/문의.png" width="700px" height="655px">
			</div>
			<div class="f-d-3">
				<div style="width: 100%; padding: 30px; text-align: right">
					<div class="top-text-div">자주하는 질문</div>
					<div class="btm-text-div">'다모아'에<br/> ■ ■가 궁금해</div>
					<div class="btm-btn-div"><input type="button" value="자주하는 질문" onclick="location.href='${ctp}/board/FAQList'" /></div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
