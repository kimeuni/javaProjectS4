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
    	.c-f-l-3{
    		display : flex;
    		width: 33%;
    		height: 150px;
    		overflow: auto;
    		border: 1px solid #eee;
    	}
    	.f-s-b{
    		width: 83%;
    		font-size: 1.2em;
    	}
    	.g-f-sm{
    		color: #ccc;
    		font-size: 0.8em;
    	}
    	.m-d input[type="text"]{
    		border: 1px solid #ddd;
    		width: 250px;
    		height: 40px;
    		padding-left: 10px;
    	}
    	.mr-a{
    		margin-right: auto;
    	}
    	.ml-a{
    		justify-content: flex-end;
    		padding-right: 20px;
    		margin-bottom: 20px;
    	}
    	.radi li{
    		list-style: none;
    	}
    	input[class*="midR"] + label{
    		display: none;
    	}
    	.show-div{
    		display: block !important;
    	}
    	.radi input[type="radio"]{
    		display: none;
    	}
    </style>
    <script>
    	'use strict'
    	
    	
    	function deliveryInputOpen(strs){
			let str = '';
			if(strs == "별도"){
				str += '<div style="margin-top:10px" ><input type="text" name="deliveryInput" placeholder="배송비를 입력하세요." maxlength="6" style="width:250px; height:40px;padding-left:10px;border: 1px solid #ddd;" /></div>';
				str += '<div style="color:#ccc; font-size:0.8em;">-별도로 받을 배송비를 입력하실 수 있습니다.</div>';
				
				$("#delivery-input").html(str);
			}
			else $("#delivery-input").html(str);
    	}
    	
    	function midCategoryOpen(idx,mVOS){
    		/* 
    		let topCategoryIdxArray = [];
    		let topCategoryStringArray = [];
	
    		let nextIdx = mVOS.substring(mVOS.indexOf("topCategoryIdx=")+15);
    		let nextString = mVOS.substring(mVOS.indexOf("midCategoryName=")+16);
    		let sw = true;
    		while(sw){
    			topCategoryIdxArray.push(nextIdx.substring(0,nextIdx.indexOf("midCategoryName"))); 
    			topCategoryStringArray.push(nextString.substring(0,nextString.indexOf(")")));
    			
    			if(nextIdx.indexOf(",") == -1) sw = false;
    			else {
    				nextIdx = nextIdx.substring(nextIdx.indexOf("midCategoryName")+15);
    				nextString = nextString.substring(nextString.indexOf(")")+16);
    			}
    		}
    		
    		alert(topCategoryIdxArray);
    		alert(topCategoryStringArray);
    		
    		alert(mVOS);
    		let str = '';
    		for(let i=0; i<10; i++){
    			str += '<li>'+i+'</li>';
    		}
    		$("#mid-c-name").html(str);
    		 */
    	}
    	
    	function midCOpen(idx){
    		$(".midR").removeClass("show-div");
    		$(".mid"+idx).addClass("show-div");
    	}
    </script>
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
		<div class="u-f-d radi">
			<div class="f-r-str">카테고리<span class="pil">*</div>
			<div class="f-l-input">
				<div class="c-f-l-3">
					<ul>
						<c:forEach var="tVO" items="${tVOS}">
							<li><input type="radio" value="${tVO.idx}" onclick="midCOpen(${tVO.idx})" id="top${tVO.idx}" name="topCategoryIdx" /><label for="top${tVO.idx}" > ${tVO.topCategoryName}</label></li>
						</c:forEach>
					</ul>
				</div>
				<div class="c-f-l-3">
					<ul>
						<c:forEach var="tVO" items="${tVOS}">
							<c:forEach var="mVO" items="${mVOS }">
								<c:if test="${tVO.idx == mVO.topCategoryIdx}">
									<li><input type="radio" value="${mVO.idx}" name="midCategoryIdx" class=" midR" id="mid${tVO.idx}" /><label for="mid${tVO.idx}" class="mid${mVO.topCategoryIdx} midR"> ${mVO.midCategoryName}</label></li>
								</c:if>
							</c:forEach>
						</c:forEach>
					</ul>
				</div>
				<div class="c-f-l-3">
				
				</div>
			</div>
		</div>
		<div>
			<div style="margin-left: 16%;">선택 카테고리: 
				<input type="text" style="outline: none; border: 0px; max-width: 205px;" readonly value="열다섯글자는어느정도인가요나다" id="tCtg" />-
				<input type="text" style="outline: none; border: 0px; max-width: 205px;" readonly value="열다섯글자는어느정도인가요나다" id="mCtg" />-
				<input type="text" style="outline: none; border: 0px; max-width: 205px;" readonly value="열다섯글자는어느정도인가요나다" id="mCtg" />
			</div>
		</div>
		<hr/>
		<div class="u-f-d">
			<div class="f-r-str">상품상태<span class="pil">*</div>
			<div class=" f-s-b">
				<input type="radio" name="usedState" id="usedState1" value="새상품" /><label for="usedState1"> 새 상품(미사용) <span class="g-f-sm">사용하지 않은 새 상품</span></label><br/>
				<input type="radio" name="usedState" id="usedState2" value="사용감없음" /><label for="usedState2"> 사용감 없음 <span class="g-f-sm">사용은 했지만 눈에 띄는 흔적이나 얼룩이 없음</span></label><br/>
				<input type="radio" name="usedState" id="usedState3" value="사용감적음" /><label for="usedState3"> 사용감 적음 <span class="g-f-sm">눈에 띄는 흔적이나 얼룩이 약간 있음</span></label><br/>
				<input type="radio" name="usedState" id="usedState4" value="사용감많음" /><label for="usedState4"> 사용감 많음 <span class="g-f-sm">눈에 띄는 흔적이나 얼룩이 많이 있음</span></label><br/>
				<input type="radio" name="usedState" id="usedState5" value="고장/파손" /><label for="usedState5"> 고장/파손 상품 <span class="g-f-sm">기능 이상이나 외관 손상 등으로 수리/수선 필요</span></label>
			</div>
		</div>
		<hr/>
		<div class="u-f-d">
			<div class="f-r-str">교환<span class="pil">*</div>
			<div class="f-l-input f-s-b">
				<div><input type="radio" name="exchange" id="exchange1" value="불가" checked /><label for="exchange1">불가</label>&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<div><input type="radio" name="exchange" id="exchange2" value="가능" /><label for="exchange2">가능</label></div>
			</div>
		</div>
		<hr/>
		<div class="u-f-d">
			<div class="f-r-str">가격<span class="pil">*</div>
			<div class="f-l-input f-s-b">
				<div class="m-d"><input type="text" name="money" id="money" placeholder="가격을 입력하세요." maxlength="9" /></div>
			</div>
		</div>
		<hr/>
		<div class="u-f-d">
			<div class="f-r-str">배송비<span class="pil">*</div>
			<div class="f-l-input f-s-b mr-a">
				<div><input type="radio" name="delivery" id="delivery1" value="0" checked onclick="deliveryInputOpen()" /><label for="delivery1">배송비 포함</label>&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<div><input type="radio" name="delivery" id="delivery2" value="별도" onclick="deliveryInputOpen('별도')" /><label for="delivery2">배송비 별도</label></div>
			</div>
		</div>
		<div style="margin-left: 18%;">
			<div id="delivery-input"></div>
		</div>
		<hr/>
		<div class="u-f-d">
			<div class="f-r-str">설명<span class="pil">*</div>
			<div class="f-l-input f-s-b">
				<div>
					<textarea rows="6" style="width: 739px;resize: none; padding: 10px;" name="content" id="content"></textarea>
				</div>
			</div>
		</div>
		<hr/>
		<div class="u-f-d ml-a">
			<button>등록</button>
		</div>
	</div>
	<input type="hidden" id="topCategoryIdx" />
	<input type="hidden" id="midCategoryIdx" />
	<input type="hidden" id="btmCategoryIdx" />
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>