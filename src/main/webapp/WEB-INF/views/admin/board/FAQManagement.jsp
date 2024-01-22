<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자주하는 질문 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-FAQMag-right-content{
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
    	#admin-FAQMag-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-FAQMag-menu{
    		margin: 0 auto;
    		width : 100%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-FAQ-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#FAQInput-go{
    		display: inline-block;
    		height: 40px;
    		border: 1px solid gray;
    		width: 200px;
    		line-height: 40px;
    		border-radius: 5px;
    		text-align: center;
    		background-color: #315eb2;
    		color: #fff;
    		font-weight: bold;
    	}
    	#FAQInput-go a{
    		text-decoration: none;
    		color: #fff;
    	}
    	#choice-Del-btn{
    		text-align: left;
    		padding-left: 30px;
    		margin: 10px 0px;
    		width: 120px;
    		height: 35px;
    		background-color: red;
    		color: #fff;
    		line-height: 35px;
    		border-radius: 5px;
    		font-weight: bold;
    	}
    	#choice-Del-btn a{
    		text-decoration: none;
    		color : #fff;
    	}
    </style>
    <script>
    	'use strict'
    	
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

    	//개별 삭제
    	function FAQDel(curScrStartNo,idx){
    		let ans = confirm(curScrStartNo+"번 FAQ를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/FAQDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(FAQManageMent.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 선택 삭제
    	function choiceDel(){
    		let curScrStartNo = '';
    		let idx = '';
    		
    		$("input[name=ckS]:checked").each(function(){
				let str = $(this).val().split("/");
				let curScrStartNoStr = str[0];
				let idxStr = str[1];
				
				curScrStartNo += curScrStartNoStr+"/";
				idx += idxStr+"/";
			})
    		curScrStartNo = curScrStartNo.substring(0,curScrStartNo.length-1);
    		idx = idx.substring(0,idx.length-1);
    		
    		if(curScrStartNo.trim() == ""){
    			alert("삭제할 계정을 선택해주세요.");
    			return false;
    		}
    		
    		let ans = confirm(curScrStartNo+"번의 FAQ를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/FAQDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
						alert("삭제되었습니다.");
						location.reload();
    				},
    				error : function(){
    					alert("전송오류(FAQManagement.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-FAQMag-container">
		<div id="admin-FAQMag-right-content">
			<div id="top-menu-str">자주하는 질문 관리</div>
			<div id="admin-FAQMag-right-inner-content">
				<div id="admin-FAQMag-menu">
					<div id="admin-FAQ-menu-str">자주하는 질문 관리 <i class="fa-solid fa-file-pen"></i></div>
					<hr/>
						<div style="text-align: left">
							1. 해당 페이지에서는 자주하는 질문을<span style="color: red">수정, 삭제</span>할 수 있습니다.<br/>
							2. 자주하는 질문 등록은 <span style="color: red">공지사항-FAQ 등록</span> 에서 가능합니다.
						</div>
					<hr/>
					<div id="go-btn-div">
						<div id="FAQInput-go">
							<a href="${ctp}/admin/FAQInput">FAQ 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<div id="choice-Del-btn">
						<a href="javascript:choiceDel()">선택 삭제</a>
					</div>
					<form name="FAQDelform">
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
									<th>번호</th>
									<th>질문</th>
									<th>상세보기</th>
									<th>수정</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
								<c:forEach var="fVO" items="${fVOS}" varStatus="st">
									<tr>
										<td><input type="checkbox" name="ckS" class="ckS" value="${curScrStartNo}/${fVO.idx}"/></td>
										<td>${curScrStartNo}</td>
										<c:if test="${fn:length(fVO.question) > 25 }">
											<td style="text-align: left;">${fn:substring(fVO.question,0,23)}...</td>
										</c:if>
										<c:if test="${fn:length(fVO.question) <= 25 }">
											<td style="text-align: left;">${fVO.question}</td>
										</c:if>
										<td><a href="${ctp}/admin/FAQContent?idx=${fVO.idx}">상세보기</a></td>
										<td><a href="${ctp}/admin/FAQUpdate?idx=${fVO.idx}">수정</a></td>
										<td><a href="javascript:FAQDel('${curScrStartNo}','${fVO.idx}')">삭제</a></td>
									</tr>
									<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
								</c:forEach>
							</tbody>
						</table>
					</form>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="FAQManagement?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="FAQManagement?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="FAQManagement?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="FAQManagement?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="FAQManagement?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="FAQManagement?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>