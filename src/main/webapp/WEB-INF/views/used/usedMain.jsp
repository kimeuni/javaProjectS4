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
    		width: 1024px;
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
    			<span id="all-used"><a href="">전체</a></span>
	    		<span id="region-used"><a href="">내 지역 거래</a></span>
    		</div>
    	</div>
    </div>
    <div style="height: 1500px;">
    	
    </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>