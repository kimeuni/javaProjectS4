<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>답변완료 문의 내역</title>
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
    		margin-top: 70px; 
    		margin-bottom: 20px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 90%;
    		border: 1px solid;
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
		
		// 개별 삭제
		function askDel(idx,curScrStartNo){
			let ans = confirm(curScrStartNo+"번의 문의를 삭제하시겠습니까?");
			if(ans){
				$.ajax({
					url : "${ctp}/admin/askStatusYesDel",
					type : "post",
					data : {idx : idx},
					success : function(res){
						alert("삭제되었습니다.");
						location.reload();
					},
					error : function(){
						alert("전송오류(askStatusYes.jsp)")
					}
				});
			}
		}
		
		// 선택 삭제
		function choiceDel(){
			let idx = '';
			let curScrStartNo = '';
			
			
			$("input[name=ckS]:checked").each(function(){
				let str = $(this).val().split("/");
				let idxStr = str[0];
				let curScrStartNoStr = str[1];
				
				idx += idxStr+"/";
				curScrStartNo += curScrStartNoStr+"/";
			})
			idx = idx.substring(0,idx.length-1);
			curScrStartNo = curScrStartNo.substring(0,curScrStartNo.length-1);
			
			//alert(idx);
			//alert(curScrStartNo);
			
			if(idx.trim() == ""){
				alert("삭제할 문의를 선택해주세요.");
				return false;
			}
			
			let ans = confirm(curScrStartNo+"번의 문의를 삭제하시겠습니까?");
			if(ans){
				$.ajax({
					url : "${ctp}/admin/askStatusYesDel",
					type : "post",
					data : {idx : idx},
					success : function(res){
						alert("삭제되었습니다.");
						location.reload();
					},
					error : function(){
						alert("전송오류(askStatusYes.jsp)")
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
			<div id="top-menu-str">답변완료 문의 내역</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">답변완료 문의 내역 <i class="fa-solid fa-file-pen"></i></div>
					<div style="text-align: left">
						<hr/>
							1. 답변완료 후 6개월(180일)이 지난 <span style="color: red">문의는 삭제</span>해주세요.<br/>
							2. 6개월이 지난 문의는 <span style="color: red">분홍색으로 제일 상단에 표시</span>됩니다.
						<hr/>
					</div>
					<div>
					<div id="choice-Del-btn">
						<a href="javascript:choiceDel()">선택 삭제</a>
					</div>
							<table class="table table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
										<th>번호</th>
										<th>제목</th>
										<th>날짜</th>
										<th>처리상태</th>
										<th>작성자</th>
										<th>유형</th>
										<th>처리경과</th>
										<th>삭제</th>
									</tr>
								</thead>
								<c:if test="${empty vos}">
									<tr >
										<td colspan="8">답변대기 중인 문의가 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<c:if test="${!empty vos}">
									<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
									<c:forEach var="askVO" items="${vos}" varStatus="st">
										<c:if test="${askVO.ans_date_diff > 180 }">
											<tr style="background-color: pink">
												<td><input type="checkbox" name="ckS" class="ckS" value="${askVO.idx}/${curScrStartNo}"/></td>
												<td>${curScrStartNo}</td>
												<td style="text-align: left;"><a href="${ctp}/admin/askAnsContent?idx=${askVO.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">
													<c:if test="${fn:length(askVO.title) > 14}">
														${fn:substring(askVO.title,0,14)} 
													</c:if>
													<c:if test="${fn:length(askVO.title) <= 14}">
														${askVO.title} 
													</c:if>
													<span style="color: #eee"><c:if test="${askVO.imgs != ''}"><i class="fa-solid fa-paperclip"></i></c:if></span></a>
												</td>
												<td>
													<c:if test="${askVO.hour_diff <= 24 }">
														${askVO.date_diff == 0 ? fn:substring(askVO.askDate,11,16) : fn:substring(askVO.askDate,5,16)}
													</c:if>
													<c:if test="${askVO.hour_diff > 24 }">
														${fn:substring(askVO.askDate,0,10)}
													</c:if>
												</td>
												<td class="no-status">${askVO.status}</td>
												<td class="no-status">${askVO.mid}</td>
												<td class="no-status">${askVO.category}</td>
												<td class="no-status">${askVO.ans_date_diff}</td>
												<td><a href="javascript:askDel('${askVO.idx}','${curScrStartNo}')">삭제</a></td>
											</tr>
											<c:set var="curScrStartNo" value="${curScrStartNo - 1 }" />
										</c:if>
										<c:if test="${askVO.ans_date_diff <= 180 }">
											<tr>
												<td>x</td>
												<td>${curScrStartNo}</td>
												<td style="text-align: left;"><a href="${ctp}/admin/askAnsContent?idx=${askVO.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">
													<c:if test="${fn:length(askVO.title) > 14}">
														${fn:substring(askVO.title,0,14)} 
													</c:if>
													<c:if test="${fn:length(askVO.title) <= 14}">
														${askVO.title} 
													</c:if>
													<span style="color: #eee"><c:if test="${askVO.imgs != ''}"><i class="fa-solid fa-paperclip"></i></c:if></span></a>
												</td>
												<td>
													<c:if test="${askVO.hour_diff <= 24 }">
														${askVO.date_diff == 0 ? fn:substring(askVO.askDate,11,16) : fn:substring(askVO.askDate,5,16)}
													</c:if>
													<c:if test="${askVO.hour_diff > 24 }">
														${fn:substring(askVO.askDate,0,10)}
													</c:if>
												</td>
												<td class="no-status">${askVO.status}</td>
												<td class="no-status">${askVO.mid}</td>
												<td class="no-status">${askVO.category}</td>
												<td class="no-status">${askVO.ans_date_diff}</td>
												<td>삭제 불가</td>
											</tr>
											<c:set var="curScrStartNo" value="${curScrStartNo - 1 }" />
										</c:if>
									</c:forEach>
								</c:if>
							</table>
						
					</div>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="askStatusYes?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="askStatusYes?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="askStatusYes?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="askStatusYes?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="askStatusYes?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="askStatusYes?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>