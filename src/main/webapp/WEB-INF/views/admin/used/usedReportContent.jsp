<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>신고 상세보기 | ${usedVO.title }</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	.mySlides {
    		display:none;
    	}
    	#admin-main-right-content{
    		min-height : 100vh;
    		background-color: #eee;
    		margin-left : 20%;
    		display: inline-block;
    		width: 80%;
    		height : 100%;
    	}
    	#top-menu-str{
    		position: fixed;
    		width: 100%;
    		background-color: #fff;
			height: 50px;
			color: #000;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
			border-bottom: 1px solid;
			box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
    	}
    	#admin-main-right-inner-content{
    		margin: 0 auto;
    		width: 100%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 75%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-main-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	.f-d{
    		display: flex;	
    	}
    	.list-btn{
    		margin-left: auto;
    		margin-top: 10px;
    		margin-right : 10px;
    		margin-bottom: 10px;
    		background-color: #eee;
    		border : 1px solid gray;
    		width: 90px;
    		height: 40px;
    	}
    	.del-btn{
    		margin-top: 10px;
    		margin-bottom: 10px;
    		background-color: red;
    		border : 1px solid red;
    		color : #fff;
    		width: 90px;
    		height: 40px;
    	}
    	.reportNo-btn{
    		margin-right : 10px;
    		margin-top: 10px;
    		margin-bottom: 10px;
    		background-color: orange;
    		border : 1px solid orange;
    		color : #fff;
    		width: 90px;
    		height: 40px;
    	}
    	.f-d-4{
    		display: flex;
    		width: 25%;
    		justify-content: center;
    	}
    	.fn-b{
    		font-weight: bolder;
    	}
    	.f-d-6{
    		display: flex;
    		width: 75%;
    	}
    </style>
    <script>
    	'use strict'
    	
    	
    	// 문제없음 처리
    	function usedReportNo(idx){
    		let ans = confirm("해당 글은 문제가 없음이 확인되었나요? 확인시, 해당 게시물과 관련된 신고는 모두 삭제됩니다.");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/usedReportNo",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					if(res == "1"){
    						alert("문제 없음 처리되었습니다.");
    						location.href="${ctp}/admin/usedReportList";
    					}
    					else if(res == "2"){
    						alert("문제 없음 처리에 실패하였습니다.");
    					}
    				},
    				error : function(){
    					alert("전송오류(usedReportList.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 신고처리
    	function usedReportYes(usedMid,usedIdx,reason){
    		let ans = confirm("해당 글에 문제가 있음이 확인되었습니다. 작성한 회원을 신고처리 하시겠습니까?");
    		if(ans){
    			let query = {
    				usedMid : usedMid,
    				usedIdx : usedIdx,
    				reason : reason
    			}
    			$.ajax({
    				url : "${ctp}/admin/usedReportYes",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
    						alert("신고처리 되었습니다.");
    						location.href="${ctp}/admin/usedReportList";
    					}
    					else if(res == "2") alert("신고처리에 실패하였습니다.");
    				},
    				error : function(){
    					alert("전송오류(usedReportList.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-main-container">
		<div id="admin-main-right-content">
			<div id="top-menu-str">중고거래 신고 상세보기</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">중고거래 신고 | ${usedVO.title}</div>
						<div>
							<div class="f-d">
								<button onclick="location.href='${ctp}/admin/usedReportList?pag=${pag}&pageSize=${pageSize}'" class="list-btn">목록</button>
								<button onclick="usedReportNo(${usedRVO.usedIdx})" class="reportNo-btn">문제없음</button>
								<button onclick="usedReportYes('${usedRVO.usedMid}','${usedRVO.usedIdx}','${usedRVO.reason}')" class="del-btn">신고처리</button>
							</div>
							<hr/>
							<div class="f-d">
								<div class="f-d-4 fn-b">신고자</div>
								<div class="f-d-4">${usedRVO.reportMid }</div>
								<div class="f-d-4 fn-b">신고일</div>
								<div class="f-d-4">${usedRVO.RDate }</div>
							</div>
							<hr/>
							<div class="f-d">
								<div class="f-d-4 fn-b">신고 사유</div>
								<div class="f-d-6 text-left">${usedRVO.reason}</div>
							</div>
							<hr/>
							
							<h3 style="margin-top: 80px;">신고된 게시글 상세보기</h3>
							<hr/>
								<div class="f-d">
									<div class="f-d-4 fn-b">제목</div>
									<div class="f-d-6">${usedVO.title}</div>
								</div>
								<hr/>
								<div class="f-d">
									<div class="f-d-4 fn-b">카테고리</div>
									<div class="f-d-6">
										<div>${topCategoryName}</div>
										<c:if test="${midCategoryName != '0' }"><div>&nbsp; <i class="fa-solid fa-chevron-right"></i> &nbsp;${midCategoryName }</div></c:if>
										<c:if test="${btmCategoryName != '0' }"><div>&nbsp; <i class="fa-solid fa-chevron-right"></i> &nbsp;${btmCategoryName }</div></c:if>
									</div>
								</div>
								<hr/>
								<div class="f-d">
									<div class="f-d-4 fn-b">가격</div>
									<div class="f-d-4">${usedVO.money }원</div>
									<div class="f-d-4 fn-b">배송비</div>
									<div class="f-d-4">
										<c:if test="${usedVO.delivery == 0}">배송비 포함</c:if>
										<c:if test="${usedVO.delivery != 0}">배송비 별도 (${usedVO.delivery}원)</c:if>
									</div>
								</div>
								<hr/>
								<div class="f-d">
									<div class="f-d-4 fn-b">상품 사진</div>
									<div class="f-d-6">
										<div class="w3-content w3-display-container">
											<c:set var="imgss" value="${fn:split(usedVO.imgs,'/') }"/>
											<c:forEach var="imgs"  items="${imgss}">
												<img class="mySlides" src="${ctp}/data/used/${imgs}" height="350px" style="width:350px">
											</c:forEach>
											
											<button class="w3-button w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
											<button class="w3-button w3-display-right" onclick="plusDivs(+1)">&#10095;</button>
										</div>
									</div>
								</div>
								<hr/>
								<div class="f-d">
									<div class="f-d-4 fn-b">내용</div>
									<div class="f-d-6 text-left">${usedVO.content }</div>
								</div>
							<hr/>
						</div>
				</div>
			</div>
		</div>
	</div>
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