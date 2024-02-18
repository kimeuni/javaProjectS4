<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${memVO.nickName} | 팔로잉</title>
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
		.f-d-2{
			display: flex;
			width: 20%;
		}
		.b-1-p-2{
			border-bottom: 1px solid #ddd;
			padding: 20px;
		}
		.d-center{
			justify-content: center;
		}
		.img-text-profile{
			text-align: center;
		}
		.img-text-profile img{
			height: 150px;
			width: 150px;
			border-radius: 100%;
		}
		.f-d-8{
			display: flex;
			width: 80%;
		}
		.u-img-p{
			padding: 10px;
		}
		.u-img-p img{
			border: 1px solid #ddd;
		}
		.d-nick{
			margin-top: 15px;
			font-size: 1.3em;
		}
		.d-nick a{
			text-decoration: none;
			color: #000;
		}
	</style>
	<script>
		'use strict'
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="used-store-soge-container">
	<jsp:include page="/WEB-INF/views/include/usedStoreSoge.jsp" />
</div>
<div class="used-store-container">
	<div class="f-d-5">
		<div style="width: 100%" class="f-btn-5">
			<a href="${ctp}/used/usedStore?mid=${memVO.mid}" class="f-check-n">상품 ${usedCnt}</a>
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
			<a href="${ctp}/used/usedStoreFollowing?mid=${memVO.mid}" class="f-check-y">팔로잉 ${fingCnt}</a>
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
			<div class="used-str-top">팔로잉 <span style="color: red">${fingCnt}</span></div>
		</div>
		<hr/>
		
		<div >
			<c:forEach var="fingVO" items="${fingVOS}">
				<c:forEach var="fingMemVO" items="${fingMemVOS }">
					<c:if test="${fingVO.followingMid == fingMemVO.mid}">
						<div class="f-d b-1-p-2">
							<div class="f-d-2 d-center">
								<div class="img-text-profile">
									<a href="${ctp}/used/usedStore?mid=${fingMemVO.mid}"><img src="${ctp}/data/member/${fingMemVO.profile}" width="30px" ></a>
									<div class="d-nick"><a href="${ctp}/used/usedStore?mid=${fingMemVO.mid}">${fingMemVO.nickName}</a></div>
								</div>
							</div>
							<div class="f-d-8">
								<c:forEach var="fingUsedVO" items="${fingUsedVOS }" begin="0" end="2" >
									<c:if test="${fingMemVO.mid == fingUsedVO.mid}">
										<c:set var="sImg" value="${fingUsedVO.imgs.split('/')}"  />
										<div class="u-img-p"><a href="${ctp}/used/usedContent?idx=${fingUsedVO.idx}"><img src="${ctp}/data/used/${sImg[0]}" width="190px" height="190px"></a></div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</c:forEach>
		</div>
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollowing?pag=1&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollowing?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedStoreFollowing?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollowing?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollowing?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollowing?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>