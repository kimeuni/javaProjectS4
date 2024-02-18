<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${memVO.nickName} | 찜목록</title>
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
    	.inner-flex-end a{
    		text-decoration:  none;
    		color: #fff;
    	}
    	.like-no-btn{
    		display: flex;
    		width: 100px;
    		height: 25px;
    		line-height: 25px;
    		background-color: #FFC0CB;
    		color: #fff;
    		justify-content: center;
    	}
	</style>
	<script>
		'use strict'
		// 찜 취소
    	function likeDelete(idx){
	   		let query = {
	       			idx : idx,
	       			mid : '${sMid}',
	       			flag : 'delete'
	       		}
	   		$.ajax({
    			url : "${ctp}/used/likeUpNDel",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1"){
    					location.reload();
    				}
    				else if(res == "2") alert("해당 게시물 찜 취소에 실패하였습니다.")
    			},
    			error : function(){
    				alert("전송오류(usedContent.jsp)")
    			}
    		});
    	}
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
				<a href="${ctp}/used/usedStoreLike?mid=${memVO.mid}" class="f-check-y">찜목록 ${likeCnt}</a>
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
			<div class="used-str-top">찜 <span style="color: red">${likeCnt}</span></div>
		</div>
		<hr/>
		
		<div class="f-d used-list-container">
			<c:forEach var="usedLikeVO" items="${usedLikeVOS}">
				<c:set var="sImg" value="${usedLikeVO.imgs.split('/')}" />
				<div class="used-list-content-div">
					<div class="line-b">
			    		<div><a href="${ctp}/used/usedContent?idx=${usedLikeVO.idx}"><img src="${ctp}/data/used/${sImg[0]}" width="218px" height="218px"></a></div>
			    		<div class="mt-1">
				    		<div class="mt-5">
				    			<c:if test="${fn:length(usedLikeVO.title) >13 }">
				    				${fn:substring(usedLikeVO.title,0,13)}...
				    			</c:if> 
				    			<c:if test="${fn:length(usedLikeVO.title) <=13 }">
				    				${usedLikeVO.title}
				    			</c:if> 
				    		</div>
				    		<div class="inner-flex-div mt-5">
				    			<div class="inner-flex-end "><a href="javascript:likeDelete(${usedLikeVO.idx})" class="like-no-btn ">찜취소</a></div>
				    		</div>
			    		</div>
		    		</div>
				</div>
			</c:forEach>
		</div>
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreLike?pag=1&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreLike?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedStoreLike?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreLike?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreLike?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreLike?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>