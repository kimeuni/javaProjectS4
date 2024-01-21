<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${memVO.nickName} | 상점</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		#used-store-soge-container{
			width: 1200px;
			margin: 0 auto;
			display: flex;
			margin-top: 30px;
			margin-bottom: 40px;
			border: 1px solid #ccc;
		}
		.used-store-container{
			width: 1200px;
			margin: 0 auto;
			display: flex;
		}
		.f-d{
			display: flex;
		}
		.f-d-5{
			display: flex;
			width: 20%;
		}
		.f-btn-5 a{
			display : flex;
			width: 100%;
			height: 65px;
			font-size: 1.2em;
			justify-content: center;
			line-height: 65px;
			text-decoration: none;
			color: #000;
		}
		.f-check-y{
			border-top: 1px solid;
			border-left: 1px solid;
			border-right: 1px solid;
		}
		.f-check-n{
			border-top: 1px solid #ddd;
			border-left: 1px solid #ddd;
			border-right: 1px solid #ddd;
			border-bottom: 1px solid;
			background-color: #eee;
		}
		.used-str-top{
			margin-top: 30px !important;
			font-size: 1.2em;
		}
		.category-str{
			font-size: 1.12em;
			margin-bottom: 20px;
		}
		.line-b{
    		border: 1px solid #ccc;
    	}
		.inner-flex-div{
    		display: flex;
    	}
    	.mt-5{
    		margin-top: 7px !important;
    	}
    	.used-list-content-div{
    		display: flex;
    		width: 20%;
    		padding: 10px;
    	}
    	.mt-1{
    		margin: 7px;
    	}
    	.used-list-container{
    		flex-wrap: wrap;
    	}
    	.inner-flex-end{
    		margin-left: auto;
    	}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="used-store-soge-container">
	<jsp:include page="/WEB-INF/views/include/usedStoreSoge.jsp" />
</div>
<div class="used-store-container">
	<div class="f-d-5">
		<div style="width: 100%" class="f-btn-5">
			<a href="" class="f-check-y">상품 ${usedCnt}</a>
		</div>
	</div>
	<c:if test="${sMid == memVO.mid}">
		<div class="f-d-5">
			<div style="width: 100%" class="f-btn-5">
				<a href="${ctp}/used/usedStoreLike?mid=${memVO.mid}" class="f-check-n">찜목록 ${likeCnt}</a>
			</div>
		</div>
	</c:if>
	<div class="f-d-5">
		<div style="width: 100%" class="f-btn-5">
			<a href="${ctp}/used/usedStoreFollowing?mid=${memVO.mid}" class="f-check-n">팔로잉 ${fingCnt}</a>
		</div>
	</div>
	<div class="f-d-5">
		<div style="width: 100%" class="f-btn-5">
			<a href="${ctp}/used/usedStoreFollower?mid=${memVO.mid}" class="f-check-n">팔로워 ${ferCnt}</a>
		</div>
	</div>
	<c:if test="${sMid == memVO.mid}">
		<div class="f-d-5">
			<div style="width: 100%" class="f-btn-5">
				<a href="${ctp}/used/usedStoreManagement?mid=${memVO.mid}" class="f-check-n">상점관리</a>
			</div>
		</div>
	</c:if>
</div>
<div class="used-store-container">
	<div style="width: 100%">
		<div class="f-d ">
			<div class="used-str-top">상품 <span style="color: red">${usedCnt}</span></div>
		</div>
		<hr/>
		<c:if test="${empty topC && empty midC && empty btmC }"><div class="category-str">전체 &nbsp;&nbsp;&nbsp;<span style="color: #ccc">${usedCnt} 개</span></div></c:if>
		<c:if test="${!empty topC && !empty midC && !empty btmC}">
			<div>
				
			</div>
		</c:if>
		
		<!-- 전체 -->
		<c:if test="${empty topC && empty midC && empty btmC }">
			<div class="f-d used-list-container">
				<c:forEach var="usedVO" items="${usedVOS}">
					<c:set var="sImg" value="${usedVO.imgs.split('/')}" />
					<div class="used-list-content-div">
						<div class="line-b">
				    		<div><a href="${ctp}/used/usedContent?idx=${usedVO.idx}"><img src="${ctp}/data/used/${sImg[0]}" width="100%" height="218px"></a></div>
				    		<div class="mt-1">
					    		<div class="mt-5">
					    			<c:if test="${fn:length(usedVO.title) >13 }">
					    				${fn:substring(usedVO.title,0,13)}...
					    			</c:if> 
					    			<c:if test="${fn:length(usedVO.title) <=13 }">
					    				${usedVO.title}
					    			</c:if> 
					    		</div>
					    		<div class="inner-flex-div mt-5">
					    			<div>${usedVO.money}원</div>
					    			<c:if test="${usedVO.second_diff <= 59}"><div class="inner-flex-end">${usedVO.second_diff}초 전</div></c:if>
					    			<c:if test="${usedVO.second_diff > 59 && usedVO.minute_diff <= 59}"><div class="inner-flex-end">${usedVO.minute_diff}분 전</div></c:if>
					    			<c:if test="${usedVO.minute_diff > 59 && usedVO.hour_diff <=23}"><div class="inner-flex-end">${usedVO.hour_diff}시간 전</div></c:if>
					    			<c:if test="${usedVO.hour_diff > 23 && usedVO.day_diff <= 31}"><div class="inner-flex-end">${usedVO.day_diff}일 전</div></c:if>
					    			<c:if test="${usedVO.day_diff > 31 && usedVO.month_diff <= 12}"><div class="inner-flex-end">${usedVO.month_diff}달 전</div></c:if>
					    			<c:if test="${usedVO.month_diff > 12}"><div class="inner-flex-end">${usedVO.year_diff}년 전</div></c:if>
					    		</div>
				    		</div>
			    		</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
		
		<!-- 카테고리 -->
		
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedStore?pag=1&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedStore?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedStore?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedStore?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedStore?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedStore?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>