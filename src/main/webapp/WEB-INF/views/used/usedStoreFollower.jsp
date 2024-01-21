<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${memVO.nickName} | 팔로워</title>
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
		.f-d-4{
			display: flex;
			width: 25%;
		}
		.f-d-4 a{
			text-decoration: none;
			color: #000;
			font-size: 1.2em;
		}
		.f-folloer-container{
			flex-wrap: wrap;
		}
		.f-center{
			justify-content: center;
			text-align: center;
			padding-top: 15px;
		}
		.img-profile-d img{
			width: 200px;
			height: 200px;
			line-height: 200px;
			border-radius: 100%;
		}
		.b-d{
			border: 1px solid #eee;
		}
		.nick-d{
			padding: 10px 0px;
		}
		.used-cnt-follower-cnt{
			padding-bottom: 25px;
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
			<a href="${ctp}/used/usedStoreFollowing?mid=${memVO.mid}" class="f-check-n">팔로잉 ${fingCnt}</a>
		</div>
	</div>
	<div class="f-d-5">
		<div style="width: 100%" class="f-btn-5">
			<a href="${ctp}/used/usedStoreFollower?mid=${memVO.mid}" class="f-check-y">팔로워 ${ferCnt}</a>
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
			<div class="used-str-top">팔로워 <span style="color: red">${ferCnt}</span></div>
		</div>
		<hr/>
		
		<div>
			<div class="f-d f-folloer-container">
				<c:forEach var="ferMemVO" items="${ferMemVOS}">
					<div class="f-d-4 f-center b-d">
						<div>
							<div class="img-profile-d"><a href="${ctp}/used/usedStore?mid=${ferMemVO.mid}"><img src="${ctp}/data/member/${ferMemVO.profile}"></a></div>
							<div class="nick-d"><a href="${ctp}/used/usedStore?mid=${ferMemVO.mid}">${ferMemVO.nickName}</a></div>
							<div class="used-cnt-follower-cnt"><a href="${ctp}/used/usedStore?mid=${ferMemVO.mid}">상품 ${ferMemVO.usedCnt} | 팔로워 ${ferMemVO.followerCnt}</a></div>
						</div>
					</div>	
				</c:forEach>
			</div>
		</div>
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollower?pag=1&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollower?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedStoreFollower?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollower?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollower?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreFollower?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>