<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고거래 | 신고된 글 리스트</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
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
    		width : 90%;
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
    						location.reload();
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
    						location.reload();
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
			<div id="top-menu-str">중고거래 | 신고 리스트</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">신고 리스트 <i class="fa-solid fa-triangle-exclamation"></i></div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>신고자</th>
								<th>사유</th>
								<th>신고일</th>
								<th>기능</th>
							</tr>
						</thead>
						<c:set var="curScrStartNo" value="${pageVO.curScrStartNo }"></c:set>
						<c:forEach var="usedRVO" items="${usedRVOS }">
							<tr>
								<td>${curScrStartNo }</td>
								<td>
									<c:if test="${fn:length(usedRVO.title) >10 }">
										${fn:substring(usedRVO.title,0,10) }...
									</c:if>
									<c:if test="${fn:length(usedRVO.title) <=10 }">
										${usedRVO.title}
									</c:if>
								</td>
								<td>${usedRVO.reportMid }</td>
								<td>
									<c:if test="${fn:length(usedRVO.reason) >10 }">
										${fn:substring(usedRVO.reason,0,10) }...
									</c:if>
									<c:if test="${fn:length(usedRVO.reason) <=10 }">
										${usedRVO.reason }
									</c:if>
								</td>
								<td>${fn:substring(usedRVO.RDate,0,10) }</td>
								<td>
									<a href="${ctp}/admin/usedReportContent?idx=${usedRVO.idx}&pag=${pageVO.pag}&pageSize=${pageSize}" class="">상세보기</a>
									<a href="javascript:usedReportNo(${usedRVO.usedIdx})" class="">문제없음</a>
									<a href="javascript:usedReportYes('${usedRVO.usedMid}','${usedRVO.usedIdx}','${usedRVO.reason}')" class="">신고처리</a>
								</td>
							</tr>
							<c:set var="curScrStartNo" value="${curScrStartNo - 1 }"></c:set>
						</c:forEach>
					</table>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="usedReportList?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="usedReportList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="usedReportList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="usedReportList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="usedReportList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="usedReportList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>