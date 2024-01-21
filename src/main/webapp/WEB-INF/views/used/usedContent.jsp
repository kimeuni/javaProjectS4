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
    	.str-w2{
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
    	.like-btn, .report-btn, .chat-btn, .like-btn-n{
    		width: 150px;
    		height: 40px;
    		font-size: 1.1em;
    		font-weight: bold;
    		text-align: center;
    		line-height: 40px;
    	}
    	.like-btn-n{
    		background-color: #FFC0CB;
    	}
    	.like-btn{
    		background-color: #aaa; 
    	}
    	.chat-btn{
    		background-color: orange;
    	}
    	.report-btn{
    		background-color: red;
    	}
    	.management-btn{
    		background-color: orange;
    		color : #fff;
    		width: 300px;
    		height: 40px;
    		font-size: 1.1em;
    		font-weight: bold;
    		text-align: center;
    		line-height: 40px;
    	}
    	.u-btns-flex a{
    		color : #fff;
    		text-decoration: none;
    	}
    	.inner-f-d-7{
    		display: flex;
    		width: 70%;
    		border-right: 1px solid #ccc;
    	}
    	.inner-f-d-3{
    		display: flex;
    		width: 30%;
    	}
    	.content-p{
    		padding-top: 2%;
    		padding-bottom: 2%;
    	}
    	.categry-str{
    		margin-bottom: 10px;
    		color: #aaa;
    	}
    	.img-f-3{
    		display: flex;
    		width: 30%;
    	}
    	.str-f-7{
    		display: flex;
    		width: 70%;
    	}
    	.img-f-3 img{
    		height: 50px;
    		width: 50px;
    		border-radius: 100%;
    	}
    	.w-5{
    		min-width: 70px; 
    	}
    	.str-f-7 a{
    		text-decoration: none;
    		color: #000;
    	}
    	.f-center{
    		justify-content: center;
    		text-align: center;
    	}
    	.f-center a{
    		margin : 10px 0px;
    		width: 150px;
    		height: 35px;
    		border: 1px solid #ccc;
    		line-height: 35px;
    		text-decoration: none;
    		color: #000;
    	}
    	.f-w-5{
    		display: flex;
    		width: 50%;
    	}
    	.f-u{
    		flex-flow: wrap;
    	}
    	.f-w-5 img{
    		width: 100%;
    		height: 138px;
    	}
    	.see-more-btn{
    		width: 100%;
    		height: 40px;
    		line-height: 40px;
    	}
    	.see-more-div{
    		border-left: 1px solid #ccc;
    		border-right: 1px solid #ccc;
    		border-bottom: 1px solid #ccc;
    		width: 100%;
    		text-align: center;
    	}
    	.see-more-div a{
    		text-decoration: none;
    		color: #000;
    	}
    	.fn-b{
    		font-size: 1.1em;
    		font-weight: bold;
    	}
    </style>
    <script>
    	'use strict'
    	
    	// 팔로우 취소
    	function followNo(followingMid){
    		let query = {
   				followerMid : '${sMid}',
   				followingMid : followingMid,
   				flag : "No"
    		}
    		$.ajax({
    			url : "${ctp}/used/usedFollow",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1") location.reload();
    				else if(res == "2") alert("팔로우 취소에 실패하였습니다.");
    			},
    			error : function(){
    				alert("전송오류(usedContent.jsp)");
    			}
    		});
    	}
    	
    	// 팔로우 하기
    	function followYes(followingMid){
    		let query = {
   				followerMid : '${sMid}',
   				followingMid : followingMid,
   				flag : "Yes"
    		}
    		$.ajax({
    			url : "${ctp}/used/usedFollow",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1") location.reload();
    				else if(res == "2") alert("팔로우에 실패하였습니다.");
    			},
    			error : function(){
    				alert("전송오류(usedContent.jsp)");
    			}
    		});
    	}
    	
    	// 찜 누르기
    	function likeUpdate(idx){
    		let query = {
    			idx : idx,
    			mid : '${sMid}',
    			flag : 'update'
    		}
    		$.ajax({
    			url : "${ctp}/used/likeUpNDel",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1"){
    					location.reload();
    				}
    				else if(res == "2") alert("해당 게시물 찜에 실패하였습니다.")
    			},
    			error : function(){
    				alert("전송오류(usedContent.jsp)")
    			}
    		});
    	}
    	
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
					<div class="str-w2"><i class="fa-solid fa-heart"></i> ${usedVO.totLike }</div>
					<div class="str-w2"><i class="fa-solid fa-eye"></i> ${usedVO.viewCnt }</div>
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
					<c:if test="${sMid != usedVO.mid }">
						<c:if test="${empty likeVO }">
							<div class="u-btns-flex"><a href="javascript:likeUpdate(${usedVO.idx})" class="like-btn"><i class="fa-solid fa-heart"></i> 찜하기</a></div>
						</c:if>
						<c:if test="${!empty likeVO }">
							<div class="u-btns-flex"><a href="javascript:likeDelete(${usedVO.idx})" class="like-btn-n"><i class="fa-solid fa-heart-crack"></i> 찜취소</a></div>
						</c:if>
					</c:if>
					<c:if test="${sMid != usedVO.mid }">
						<div class="u-btns-flex"><a href="" class="chat-btn"><i class="fa-solid fa-comments"></i> 채팅하기</a></div>
					</c:if>
					<c:if test="${sMid != usedVO.mid }">
						<div class="u-btns-flex"><a href="" class="report-btn"><i class="fa-solid fa-triangle-exclamation"></i> 신고</a></div>
					</c:if>
					<c:if test="${sMid == usedVO.mid }">
						<div class="u-btns-flex"><a href="" class="management-btn"><i class="fa-solid fa-store"></i> 상점관리</a></div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<hr class="bor-b" />
	<div class="f-d">
		<div class="inner-f-d-7">
			<div style="width: 100%; padding: 1%; padding-top: 0px">
				<div class="fn-b">상품정보</div>
				<hr/>
				<div class="content-p">${usedVO.content}</div>
				<hr/>
					<div>
						<div class="categry-str"><i class="fa-solid fa-rectangle-list"></i>카테고리</div>
						<c:if test="${midCategoryName == '0' && btmCategoryName == '0' }"><a href=""> ${topCategoryName} &nbsp;<i class="fa-solid fa-chevron-right"></i></a></c:if>
						<c:if test="${midCategoryName != '0' && btmCategoryName == '0' }"><a href=""> ${midCategoryName} &nbsp;<i class="fa-solid fa-chevron-right"></i></a></c:if>
						<c:if test="${midCategoryName != '0' && btmCategoryName != '0' }"><a href=""> ${btmCategoryName} &nbsp;<i class="fa-solid fa-chevron-right"></i></a></c:if>
					</div>
				<hr/>
			</div>
		</div>
		<div class="inner-f-d-3">
			<div style="width: 100%; padding: 5%; padding-top: 0px">
				<div class="fn-b">상점정보</div>
				<hr/>
				<div class="f-d">
					<div class="img-f-3">
						<a href="${ctp}/used/usedStore?mid=${usedVO.mid}" >
							<img src="${ctp}/data/member/${memVO.profile}"/>
						</a>
					</div>
					<div class="str-f-7">
						<a href="${ctp}/used/usedStore?mid=${usedVO.mid}" >
							<div style="width: 100%">
								<div>${memVO.nickName}</div>
								<div class="f-d">
									<div class="w-5">상품 : ${usedCnt}</div>
									<div class="w-5">팔로워 : ${follower }</div>
								</div>
							</div>
						</a>
					</div>
				</div>
				<c:if test="${sMid != usedVO.mid && sMid != null }">
					<div class="f-d f-center">
						<c:if test="${!empty fVO}">
							<a href="javascript:followNo('${usedVO.mid}')" style="background-color: #eee;"><div>팔로잉 <i class="fa-solid fa-user-check"></i></div></a>
						</c:if>
						<c:if test="${empty fVO}">
							<a href="javascript:followYes('${usedVO.mid}')"><div>팔로우 <i class="fa-solid fa-user-plus"></i></div></a>
						</c:if>
					</div>
				</c:if>
				<hr/>
				<div class="f-d f-u">
					<c:forEach var="saleVO" items="${saleUsedVOS}" begin="0" end="3">
					<c:set var="imgs" value="${saleVO.imgs.split('/')}" />
						<div class="f-w-5">
							<div>
								<div><a href="${ctp}/used/usedContent?idx=${saleVO.idx}"><img src="${ctp}/data/used/${imgs[0]}"/></a></div>
							</div>
						</div>
					</c:forEach>
					<c:if test="${saleCnt > 4}">
						<div class="see-more-div">
							<a href="${ctp}/used/usedStore?mid=${usedVO.mid}" class="see-more-btn"><div >${usedCnt}개 상품 더 보기 <i class="fa-solid fa-chevron-right"></i></div></a>
						</div>
					</c:if>	
				</div>
			</div>
		</div>
	</div>
	<hr class="bor-b" />
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