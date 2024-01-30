<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${memVO.nickName} | 상점관리</title>
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
		.f-d{
			display: flex;
		}
		.f-05{
			display: flex;
			width: 5%;
		}
		.f-search-str input[type="text"]{
			width: 350px;
			height: 40px;
			border: 1px solid #ddd;
			margin: 5px;
			padding-left: 10px;
		}
		.f-search-btn a{
			justify-content: center;
			text-decoration : none;
			color : #000;
			display: flex;
			width: 80px;
			height: 40px;
			line-height : 40px;
			border: 1px solid #ddd;
			margin: 5px;
		}
		.m-r-a-p{
			margin-left: auto;
		}
		.select-btn-del-up a{
			display : flex;
			border-radius: 5px;
			width: 100px;
			height: 30px;
			line-height : 30px;
			justify-content : center;
			margin: 5px;
			text-decoration: none;
			color: #fff;
			margin-bottom: 15px;
		}
		.select-del-btn a{
			background-color: red; 
		}
		.select-up-btn a{
			background-color: orange; 
		}
		.del-b a, .update-b a, .up-b a{
			display : flex;
			width: 80px;
			height: 25px;
			line-height: 25px;
			justify-content: center;
			margin: 10px 0px;
			text-decoration: none;
			color: #fff;
		}
		.del-b a{
			background-color: red;
		}
		.update-b a{
			background-color: gray;
		}
		.up-b a{
			background-color: orange;
		}
	</style>
	<script>
		'use strict'
		
    	// 선택박스 전부 선택하면 전체체크박스 체크, 전체 체크 아닐시 해제
    	$(function() {
    		$(".ckS").on("change", function() {
	    		if($('input:checkbox[name=ckS]').length == $('input:checkbox[name=ckS]:checked').length){
	    			$("#ckAll")[0].checked = true;
	    		}
	    		else {
	    			$("#ckAll")[0].checked = false;
	    		}
    		});
    	});
    	
    	// 전체 선택 및 전체 해제
    	function checkAll(){
    		let checkAll = "N";
    		if($("#ckAll")[0].checked) checkAll = "All"
    		
    		if(checkAll == "All"){
	    		for(let i=0; i<$('input:checkbox[name=ckS]').length; i++){
	    			$(".ckS")[i].checked = true;
	    		}
    		}
    		else{
	    		for(let i=0; i<$('input:checkbox[name=ckS]').length; i++){
	    			$(".ckS")[i].checked = false;
	    		}
    		}
    	}
    	
    	// 선택 UP
    	function selectUpBtn(){
    		let cnt = 0;
    		let idx = '';
    		
    		$("input[name=ckS]:checked").each(function(){
				let idxStr = $(this).val();
				
				idx += idxStr+"/";
				cnt++
			})
			
    		idx = idx.substring(0,idx.length-1);
    		
    		if(idx.trim() == ""){
    			alert("UP하실 글을 선택해주세요.");
    			return false;
    		}
    		
    		let ans = confirm(cnt+"개의 글을 UP하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/used/usedUpUpdate",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
						alert("선택하신 글이 UP되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(usedStoreManagement.jsp)")
    				}
    			});
    		}
    	}
    	
    	// Up
    	function upUpdateBtn(idx){

    		let ans = confirm("해당 글을 UP하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/used/usedUpUpdate",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
						alert("UP되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(usedStoreManagement.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 선택 삭제
    	function selectDelBtn(){
    		let cnt = 0;
    		let idx = '';
    		
    		$("input[name=ckS]:checked").each(function(){
				let idxStr = $(this).val();
				
				idx += idxStr+"/";
				cnt++
			})
			
    		idx = idx.substring(0,idx.length-1);
    		
    		if(idx.trim() == ""){
    			alert("삭제하실 글을 선택해주세요.");
    			return false;
    		}
    		
    		let ans = confirm(cnt+"개의 글을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/used/usedIdxDelete",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
						alert("선택하신 글이 삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(usedStoreManagement.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 삭제
    	function deleteBtn(idx){

    		let ans = confirm("해당 글을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/used/usedIdxDelete",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
						alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(usedStoreManagement.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 판매상태 수정
    	function stateChange(idx){
    		let state = $("#state"+idx).val();
    		
    		let query = {
    			idx : idx,
    			state : state
    		}
    		$.ajax({
    			url : "${ctp}/used/stateUpdate",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1") location.reload();
    				else if(res == "2") alert("판매상태 변경에 실패하였습니다.")
    			},
    			error : function(){
    				alert("전송오류(usedStoreManagement.jsp)");
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
				<a href="${ctp}/used/usedStoreManagement?mid=${memVO.mid}" class="f-check-y">상점관리</a>
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
		<div class="f-d">
			<div class="m-r-a-p">
				<div class="f-d select-btn-del-up">
					<div class="select-del-btn"><a href="javascript:selectDelBtn()">선택 삭제</a></div>
					<div class="select-up-btn"><a href="javascript:selectUpBtn()">선택 Up</a></div>
				</div>
			</div>
		</div>
		
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th style="width: 5%"><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
					<th style="width: 15%">사진</th>
					<th style="width: 15%">판매상태</th>
					<th style="width: 25%">상품명</th>
					<th style="width: 10%">가격</th>
					<th style="width: 10%">찜</th>
					<th style="width: 10%">업로드 날짜</th>
					<th style="width: 10%">기능</th>
				</tr>
			</thead>
			<c:forEach var="usedVO" items="${usedVOS}">
				<c:set var="sImg" value="${usedVO.imgs.split('/')}" />
				<tr>
					<td><input type="checkbox" name="ckS" class="ckS" value="${usedVO.idx}"/></td>
					<td><a href="${ctp}/used/usedContent?idx=${usedVO.idx}"><img src="${ctp}/data/used/${sImg[0]}" height="152px" width="152px"></a></td>
					<td>
						<select id="state${usedVO.idx}" name="state" onchange="stateChange(${usedVO.idx})">
							<option value="판매중" ${usedVO.state == '판매중'? 'selected' : '' }>판매중</option>
							<option value="예약중" ${usedVO.state == '예약중'? 'selected' : '' }>예약중</option>
							<option value="판매완료" ${usedVO.state == '판매완료'? 'selected' : '' }>판매완료</option>
						</select>
					</td>
					<td><a href="${ctp}/used/usedContent?idx=${usedVO.idx}">${usedVO.title}</a></td>
					<td><fmt:formatNumber value="${usedVO.money}" />원</td>
					<td>${usedVO.totLike}</td>
					<td>${fn:substring(usedVO.uploadDate,0,16)}</td>
					<td>
						<div class="del-b"><a href="javascript:deleteBtn(${usedVO.idx})">삭제</a></div>
						<div class="update-b"><a href="javascript:">수정</a></div>
						<div class="up-b"><a href="javascript:upUpdateBtn(${usedVO.idx})">UP</a></div>
					</td>
				</tr>
			</c:forEach>
		</table>
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreManagement?pag=1&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreManagement?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedStoreManagement?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreManagement?pag=${i}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreManagement?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedStoreManagement?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&mid=${memVO.mid}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>