<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 문의 내역 | 답변완료</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#myAskList-right-content{
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
    		background-color: #5E5756;
			height: 50px;
			color: #fff;
			font-weight: bold;
			font-size: 1.5em;
			padding-left: 30px;
			line-height: 50px;
    	}
    	#myAskList-right-inner-content{
    		margin: 0 auto;
    		width: 85%;
    		margin-top: 65px; 
    		margin-bottom: 35px; 
    	}
    	#myAskList-myinfo-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myAskList-myinfo-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#myAsk-select-div {
    		text-align: right;
    		padding-right: 20px;
    	}
    	#myAsk-select-div select {
    		margin-bottom: 10px;
			width: 150px;
			border: 1px solid gray;
			border-radius: 5px;
			height: 35px;
		}
		.no-status{
			color: #ccc;
		}
		.ok-status{
			color: red;
		}
    </style>
    <script>
    	'use strict'
    	
    	function selectCategory(){
    		let status = $("#status").val();
    		if(status.trim() == ""){
    			alert("검색할 유형을 선택하세요.")
    			return false;
    		}
    		else {
    			location.href="${ctp}/member/ask/myAskListSearch?part="+status;
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myAskList-container">
		<div id="myAskList-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myAskList-right-inner-content">
				<div id="myAskList-myinfo-menu">
					<div id="myAskList-myinfo-menu-str">내 문의 내역 | 답변완료 <i class="fa-solid fa-clipboard-list"></i></div>
					<hr/>
						<div style="text-align: left">
							<span style="color:red">제목을 클릭</span>시 상세보기로 이동가능합니다. | 답변 완료 후 <span style="color: red">6개월(180일)이 지난 문의는 삭제</span>됩니다.<br/>
							※ 문의 내용 중 개인정보가 포함되었거나 중복된 문의인 경우 삭제될 수 있습니다.
						</div>
					<hr/>
					<div id="myAsk-select-div">
						선택 검색 : 
						<select name="status" id="status" onchange="selectCategory()">
							<option value="">유형 선택</option>
							<option value="전체">전체</option>
							<option value="답변대기">답변대기</option>
							<option value="답변완료">답변완료</option>
						</select>
					</div>
					<div>
						<table class="table table-hover">
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>날짜</th>
									<th>처리상태</th>
								</tr>
							</thead>
							<c:if test="${empty vos}">
								<tr >
									<td colspan="4">답변완료된 문의 내역이 존재하지 않습니다.</td>
								</tr>
							</c:if>
							<c:if test="${!empty vos}">
								<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
								<c:forEach var="askVO" items="${vos}" varStatus="st">
									<tr>
										<td>${curScrStartNo}</td>
										<td style="text-align: left;"><a href="${ctp}/member/ask/askContent?idx=${askVO.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${askVO.title} <span style="color: #eee"><c:if test="${askVO.imgs != ''}"><i class="fa-solid fa-paperclip"></i></c:if></span></a></td>
										<td>${fn:substring(askVO.askDate,0,11)}</td>
										<c:if test="${askVO.status=='답변대기'}">
											<td class="no-status">${askVO.status}</td>
										</c:if>
										<c:if test="${askVO.status=='답변완료'}">
											<td class="ok-status">${askVO.status}</td>
										</c:if>
									</tr>
									<c:set var="curScrStartNo" value="${curScrStartNo - 1 }" />
								</c:forEach>
							</c:if>
						</table>
					</div>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="myAskListSearch?pag=1&pageSize=${pageVO.pageSize}&part=${part}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="myAskListSearch?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&part=${part}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="myAskListSearch?pag=${i}&pageSize=${pageVO.pageSize}&part=${part}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="myAskListSearch?pag=${i}&pageSize=${pageVO.pageSize}&part=${part}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="myAskListSearch?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&part=${part}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="myAskListSearch?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&part=${part}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>