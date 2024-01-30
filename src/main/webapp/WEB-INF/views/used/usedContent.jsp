<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    		width: 138px;
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
    	
    	/* 신고창 */
		#complaint{
			position: fixed;
			top:25%;
			left: 50%;
    		transform: translate(-50%, 0);
			width: 450px;
			border: 1px solid gray;
			background-color:#fff;
		}
		#cpstyle{
			text-align:center;
			padding: 30px;
		}
		.complaint-top-str{
			text-align:center; 
			background-color:#252525; 
			color:#fff; 
			height:50px; 
			line-height:50px;
		}
		.cp-mid-str1{
			text-align: left; 
			margin-bottom: 5px;
		}
		.cp-mid-str2{
			text-align: left; 
			margin-bottom: 15px;
		}
		#otherWhy{
			resize: none;
		}
		
		.item-box{
		    position: relative;
		}
		  
		.sold-out{
		    position: absolute;
		    left: 0px;
		    top: 0px;
		    width: 100%;
		    height: 100%;
		    display: table;
		    background: rgba(0, 0, 0, 0.4);
		    color: #fff;
		}
		
		.sold-out > p{
		    display: table-cell;
		    vertical-align: middle;
		    text-align: center;
		    font-size: 1.2em;
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
    		let mid = '${sMid}';
			if(mid == ""){
				alert("로그인 후 이용 가능한 서비스 입니다.");
				location.href="${ctp}/member/login"
			}
			else{
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
    	
    	
    	
    	//게시판 들어왔을 때 신고창 숨기기 및 신고기타사유 적는 곳 숨기기
		$(function() {
			$("#complaint").hide();
			$("#cpWhyOther").hide();
		});
		
		// 신고버튼 눌렀을 시, 신고창 뜨게 하기
		function cpCheck(){
			let mid = '${sMid}';
			if(mid == ""){
				alert("로그인 후 이용 가능한 서비스 입니다.");
				location.href="${ctp}/member/login"
			}
			else{
				$("#complaint").show();
			}
		}
		
		// "기타"를 선택했을 시, 화면 보이기 혹은 가리기
		function cpWhyCheck(){
			let cpWhy = $("#cpWhy").val();
			if(cpWhy == '기타'){
				$("#cpWhyOther").show();
			}
			else {
				$("#cpWhyOther").hide();
			}
		};
		
		// 신고창에서 취소 버튼
		function cCheck(){
			$("#complaint").hide();
			$("#cpWhyOther").hide();
		}
		
		// 신고창 신고하기 버튼
		function cpCheckOk() {
			let cpWhy = $("#cpWhy").val();
			let otherWhy =$("#otherWhy").val();
			
			if(cpWhy.trim() == "" ){
				alert("신고 사유를 선택해주세요.")
				return false;
			}
			else if(cpWhy == "기타" && otherWhy.trim() == ""){
				alert("신고 사유를 선택해주세요.")
				$("#otherWhy").focus();
				return false;
			}
			else {
				let cpWhy = $("#cpWhy").val();
				let otherWhy = $("#otherWhy").val();
				
				let query = {
					idx : ${usedVO.idx},
					cpWhy : cpWhy,
					otherWhy : otherWhy,
					mid : '${sMid}',
					usedMid : '${usedVO.mid}'
				}
				$.ajax({
					url : "${ctp}/used/usedReport",
					type : "post",
					data : query,
					success : function(res){
						if(res == "1") {
							alert("신고가 완료되었습니다.")
							location.reload();
						}
						else alert("신고에 실패하였습니다.")
					},
					error : function(){
						alert("전송 오류");
					}
				});
			}
		}
		
		//채팅하기
		function chatGoBtn(usedIdx,mid,state){
			let sMid = '${sMid}';
			
			if(sMid.trim() == ""){
				alert("로그인 후 이용 가능합니다.");
				location.href="${ctp}/member/login";
				return false;
			}
			else if(state != '판매중'){
				alert("판매중이 아닌 상품은 채팅을 할 수 없습니다.");
				return false;
			}
			else {
				location.href='${ctp}/chat/chatContent?usedIdx='+usedIdx+'&mid='+mid+'&sMid='+sMid;
			}
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
				<div class="item-box">
				    <div class="image">
					<c:forEach var="imgs"  items="${imgss}">
						<img class="mySlides" src="${ctp}/data/used/${imgs}" height="350px" style="width:350px">
					</c:forEach>
				    </div>
				    <c:if test="${usedVO.state == '예약중' }">
					    <div class="sold-out">
					    	<p>예약중</p>
					    </div>
				    </c:if>
				    <c:if test="${usedVO.state == '판매완료' }">
					    <div class="sold-out">
					    	<p>판매완료</p>
					    </div>
				    </c:if>
					<button class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
					<button class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
				</div>
			</div>
		</div>
		<div class="used-content-flex-right">
			<div style="width: 100%;">
				<div class="u-title">${usedVO.title}</div>
				<div class="u-money"><fmt:formatNumber value="${usedVO.money }"/>원</div>
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
						<div class="u-btns-flex"><a href="javascript:chatGoBtn('${usedVO.idx}','${usedVO.mid}','${usedVO.state }')" class="chat-btn"><i class="fa-solid fa-comments"></i> 채팅하기</a></div>
					</c:if>
					<c:if test="${sMid != usedVO.mid }">
						<div class="u-btns-flex"><a href="javascript:cpCheck()" class="report-btn"><i class="fa-solid fa-triangle-exclamation"></i> 신고</a></div>
					</c:if>
					<c:if test="${sMid == usedVO.mid }">
						<div class="u-btns-flex"><a href="${ctp}/used/usedStoreManagement?mid=${usedVO.mid}" class="management-btn"><i class="fa-solid fa-store"></i> 상점관리</a></div>
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
						<c:if test="${midCategoryName == '0' && btmCategoryName == '0' }"><a href="${ctp}/used/usedCategorySearch?top=${top}&mid=${mid}&btm=${btm}"> ${topCategoryName} &nbsp;<i class="fa-solid fa-chevron-right"></i></a></c:if>
						<c:if test="${midCategoryName != '0' && btmCategoryName == '0' }"><a href="${ctp}/used/usedCategorySearch?top=${top}&mid=${mid}&btm=${btm}"> ${midCategoryName} &nbsp;<i class="fa-solid fa-chevron-right"></i></a></c:if>
						<c:if test="${midCategoryName != '0' && btmCategoryName != '0' }"><a href="${ctp}/used/usedCategorySearch?top=${top}&mid=${mid}&btm=${btm}"> ${btmCategoryName} &nbsp;<i class="fa-solid fa-chevron-right"></i></a></c:if>
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
<!-- 게시글 신고창 -->
<div id="complaint">
	<div class="complaint-top-str">신고하기</div>
	<div id="cpstyle">
		<div class="cp-mid-str1" >신고 게시판 : ${usedVO.title}</div>
		<div class="cp-mid-str2" >신고자 : ${sMid}</div>
		<div>
			<select name="cpWhy" id="cpWhy" class="form-control" onchange="cpWhyCheck()">
				<option value="">신고 사유</option>
				<option value="광고성 콘텐츠(상점)예요">광고성 콘텐츠(상점)예요</option>
				<option value="상품 정보가 부정확해요">상품 정보가 부정확해요</option>
				<option value="거래금지 품목으로 판단돼요">거래금지 품목으로 판단돼요</option>
				<option value="사기가 의심돼요(외부 채널 유도)">사기가 의심돼요(외부 채널 유도)</option>
				<option value="전문 업자 같아요">전문 업자 같아요</option>
				<option value="기타">기타</option>
			</select>
		</div>
		<div id="cpWhyOther" class="mt-2">
			<hr/>
			<textarea rows="4" id="otherWhy" class="form-control" maxlength="300"></textarea>
			<div></div>
		</div>
		<div class="text-center mt-3">
			<a href="javascript:cpCheckOk()" class="btn btn-danger">신고하기</a>
			<a href="javascript:cCheck()" class="btn btn-secondary">취소하기</a>
		</div>
	</div>
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