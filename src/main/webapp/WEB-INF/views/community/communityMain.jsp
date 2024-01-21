<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#community-main-container{
    		z-index: 1;
    	}
    	#community-main-img-container{
    		background-color: #F1E5D4;
    		min-width: 100vw;
    	}
    	#community-main-img-text-div{
    		height: 315px;
    		width: 1024px;
    		display: flex;
    		margin: 0 auto;
    	}
    	#community-text-left{
    		width: 40%;
    	}
    	#community-img-right{
    		width: 60%;
    	}
    	#community-text-div{
    		margin-top: 105px;
    		font-size: 2.0em;
		    font-weight: bold;
		    margin-bottom: 20px;
		    text-align: left;
    		padding-left: 30%;
    	}
    	#community-usedinput-btn{
    		padding-left: 30%;
    	}
    	#community-usedinput-btn button{
    		width: 120px;
    		height: 35px;
    		color : #fff;
    		border: 1px solid #5E5756;
    		background-color: #5E5756;
    		border-radius: 5px;
    	}
    	#community-usedinput-btn button:hover{
    		border: 1px solid #553830;
    		background-color: #553830;
    	}
    	#community-main-menu-container{
    		background-color: #F3CF98;
    		position: sticky;
  			top: 80px;
  			min-width: 100vw;
			z-index: 100;
    	}
    	#community-menu-flex{
    		display: flex;
    		width: 1200px;
    		height: 60px;
    		margin: 0 auto;
    		color: #553830;
    	}
    	#menu-div{
    		margin-left: 30px;
    	}
    	.inner-c{
    		padding-top: 3px;
    		padding-bottom: 3px;
    		padding-left: 10px;
    	}
    	.community-list-container{
    		display: flex;
    		min-height: 20px;
    		width: 1200px;
    		margin: 0 auto;
    		flex-wrap: wrap;
    	}
    	.community-list-content-div{
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
<div id="community-main-container">
    <div id="community-main-img-container">
    	<div id="community-main-img-text-div">
    		<div id="community-text-left">
    			<div id="community-text-div">
	    			당신의 즐거운<br/> 일상을 공유
    			</div>
    			<div id="community-usedinput-btn">
	    			<button onclick="location.href='${ctp}/used/usedInput'">글 올리기</button>
   				</div>
    		</div>
    		<div id="community-img-right">
    			<img src="${ctp}/data/images/다모아_커뮤니티.png" width="100%" height="315px" />
    		</div>
    	</div>
    </div>
    <div id="community-main-menu-container">
    	<div id="community-menu-flex">
    		<div>
    		
    		</div>
    	</div>
    </div>
    <!-- 커뉴니티 글 보이기 -->
    
    
    <br/>
	<div class="text-center">
		<ul class="pagination justify-content-center">
		    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
		  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
		  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
			    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="communityMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		  	</c:forEach>
		  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
		  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="communityMain?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
		</ul>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>