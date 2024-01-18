<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고거래</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#used-main-container{
    		z-index: 1;
    	}
    	#used-main-img-container{
    		background-color: #F1E5D4;
    		min-width: 100vw;
    	}
    	#used-main-img-text-div{
    		height: 315px;
    		width: 1024px;
    		display: flex;
    		margin: 0 auto;
    	}
    	#used-text-left{
    		width: 40%;
    	}
    	#used-img-right{
    		width: 60%;
    	}
    	#used-text-div{
    		margin-top: 125px;
    		font-size: 2.0em;
		    font-weight: bold;
		    margin-bottom: 20px;
		    text-align: center;
    	}
    	#used-usedinput-btn{
    		padding-left: 20%;
    	}
    	#used-usedinput-btn button{
    		width: 120px;
    		height: 35px;
    		color : #fff;
    		border: 1px solid #5E5756;
    		background-color: #5E5756;
    		border-radius: 5px;
    	}
    	#used-usedinput-btn button:hover{
    		border: 1px solid #553830;
    		background-color: #553830;
    	}
    	#used-main-menu-container{
    		background-color: #F3CF98;
    		position: sticky;
  			top: 80px;
  			min-width: 100vw;
			z-index: 100;
    	}
    	#used-menu-flex{
    		display: flex;
    		width: 1200px;
    		height: 60px;
    		margin: 0 auto;
    		color: #553830;
    	}
    	#menu-div{
    		margin-left: 30px;
    	}
    	#all-region-used-div{
    		margin-left: auto;
    		font-size: 1.5em;
    		font-weight: bold;
    		height : 60px;
    		line-height: 60px;
    	}
    	#all-used, #region-used{
    		margin: 0px 10px;
    	}
    	#all-used a, #region-used a{
    		margin: 0px 10px;
    		text-decoration: none;
    		color: #553830;
    	}
    	#all-used a:hover, #region-used a:hover{
    		color: #fff;
    	}
    	#menu-div ul{
    		list-style: none;
    		margin: 0px;
    		padding: 0px;
    	}
    	#menu-list-btn{
    		line-height: 60px;
    		font-size: 1.8em;
    	}
    	.menu-list ul{
    		display: none;
    	}
    	.menu-list{
    		z-index: 100;
    	}
    	/* 메뉴에 마우스 올릴 시 대,중,소 메뉴 보이기 */
    	.menu-list li:hover > ul {
    		border: 1px solid #ddd;
    		background-color: #fff;
    		display: block;
    		height: 800px;
    		width: 300px;
    	}
    	.menu-list hr{
    		margin: 0px;
    		margin-bottom: 5px;
    	}
    	.menu-list a{
    		text-decoration: none;
    		color: #000;
    	}
    	.one-menu li:hover{
    		background-color: #EBDDCC;
    	}
    	.menu-list li{
    		width: 300px;
    	}
    	.one-menu{
    		font-size: 1.2em;
    		position: relative;
    	}
    	.two-menu {
    		position: absolute;
    		left: 290px;
    		top: -1px
    	}
    	.th-menu {
    		position: absolute;
    		left: 290px;
    		top: -1px
    	}
    	.font-b{
    		font-size: 1.1em;
    		font-weight: bold;
    		padding: 5px 10px;
    	}
    	.inner-c{
    		padding-top: 3px;
    		padding-bottom: 3px;
    		padding-left: 10px;
    	}
    	.used-list-container{
    		display: flex;
    		min-height: 20px;
    		width: 1200px;
    		margin: 0 auto;
    		flex-wrap: wrap;
    	}
    	.used-list-content-div{
    		display: flex;
    		width: 240px;
    		padding: 10px;
    	}
    	.line-b{
    		border: 1px solid #ccc;
    	}
    	.mt-1{
    		margin: 7px;
    	}
    	.inner-flex-div{
    		display: flex;
    	}
    	.inner-flex-end{
    		margin-left: auto;
    	}
    	.w-2{
    		min-width: 50px;
    	}
    	.ml-a{
    		margin-left: auto;
    	}
    	.mt-5{
    		margin-top: 7px !important;
    	}
    	.mg-10{
    		margin-top : 15px;
    		margin-bottom : 15px;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="used-main-container">
    <div id="used-main-img-container">
    	<div id="used-main-img-text-div">
    		<div id="used-text-left">
    			<div id="used-text-div">
	    			행복을 나누는 거래
    			</div>
    			<div id="used-usedinput-btn">
	    			<button onclick="location.href='${ctp}/used/usedInput'">상품 올리기</button>
   				</div>
    		</div>
    		<div id="used-img-right">
    			<img src="${ctp}/data/images/중고거래.png" width="100%" height="315px" />
    		</div>
    	</div>
    </div>
    <div id="used-main-menu-container">
    	<div id="used-menu-flex">
    		<div id="menu-div">
    			<ul class="menu-list">
    				<li ><div id="menu-list-btn"><i class="fa-solid fa-bars"></div></i>
    					<ul class="one-menu">
   							<div class="font-b">전체 보기</div>
   							<hr/>
    						<c:forEach var="tVO" items="${tVOS }">
	    						<li >
	    							<a href="" ><div class="inner-c">${tVO.topCategoryName }</div></a>
	    							<ul class="two-menu">
	    								<div class="font-b">${tVO.topCategoryName}</div>
	    								<hr/>
			    						<c:forEach var="mVO" items="${mVOS }">
		    								<c:if test="${tVO.idx == mVO.topCategoryIdx }">
			    								<li>
					    							<a href="" ><div class="inner-c">${mVO.midCategoryName }</div></a>
			    									<ul class="th-menu">
			    										<div class="font-b">${mVO.midCategoryName}</div>
	    												<hr/>
							    						<c:forEach var="bVO" items="${bVOS}">
				    										<c:if test="${mVO.idx == bVO.midCategoryIdx }">
					    										<li>
									    							<a href=""><div class="inner-c">${bVO.btmCategoryName }</div></a>
					    										</li>
				    										</c:if>
							    						</c:forEach>
			    									</ul>
			    								</li>
		    								</c:if>
			    						</c:forEach>
	    							</ul>
	    						</li>
    						</c:forEach>
    					</ul>
    				</li>
    			</ul>
    		</div>
    		<div id="all-region-used-div">
    			<span id="all-used"><a href="${ctp}/used/usedMain">전체</a></span>
	    		<span id="region-used"><a href="">내 지역 거래</a></span>
    		</div>
    	</div>
    </div>
    <h2 class="used-list-container mg-10">최근 등록 상품</h2>
    <div class="used-list-container">
    	<c:set var="ctn" value="0" />
    	<c:forEach var="usedVO" items="${usedVOS}">
    		<c:set var="sImg" value="${usedVO.imgs.split('/')}" />
	    	<div class="used-list-content-div">
	    		<div class="line-b">
		    		<div><a href="${ctp}/used/usedContent?idx=${usedVO.idx}"><img src="${ctp}/data/used/${sImg[0]}" width="100%" height="218px"></a></div>
		    		<div class="mt-1">
			    		<div class="mt-5">${usedVO.title}</div>
			    		<div class="inner-flex-div mt-5">
			    			<div>${usedVO.money}원</div>
			    			<c:if test="${usedVO.second_diff <= 59}"><div class="inner-flex-end">${usedVO.second_diff}초 전</div></c:if>
			    			<c:if test="${usedVO.second_diff > 59 && usedVO.minute_diff <= 59}"><div class="inner-flex-end">${usedVO.minute_diff}분 전</div></c:if>
			    			<c:if test="${usedVO.minute_diff > 59 && usedVO.hour_diff <=23}"><div class="inner-flex-end">${usedVO.hour_diff}시간 전</div></c:if>
			    			<c:if test="${usedVO.hour_diff > 23 && usedVO.day_diff <= 31}"><div class="inner-flex-end">${usedVO.day_diff}일 전</div></c:if>
			    			<c:if test="${usedVO.day_diff > 31 && usedVO.month_diff <= 12}"><div class="inner-flex-end">${usedVO.month_diff}달 전</div></c:if>
			    			<c:if test="${usedVO.month_diff > 12}"><div class="inner-flex-end">${usedVO.year_diff}년 전</div></c:if>
			    		</div>
			    		<div class="inner-flex-div text-center mt-5">
			    			<div class="w-2 ml-a"><i class="fa-solid fa-heart" style="color: red"></i> ${usedVO.totLike }</div>
			    			<div class="w-2"><i class="fa-solid fa-eye"></i> ${usedVO.viewCnt}</div>
			    		</div>
		    		</div>
	    		</div>
	    	</div>
	    	<c:set var="cnt" value="${cnt +1}" />
    	</c:forEach>
    </div>
    <br/>
	<div class="text-center">
		<ul class="pagination justify-content-center">
		    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedMain?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
		  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
		  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
			    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		  	</c:forEach>
		  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
		  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
		</ul>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>