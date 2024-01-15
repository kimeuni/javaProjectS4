<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 문의 내역</title>
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
    		margin-top: 90px; 
    		margin-bottom: 60px; 
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
    	
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myAskList-container">
		<div id="myAskList-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myAskList-right-inner-content">
				<div id="myAskList-myinfo-menu">
					<div id="myAskList-myinfo-menu-str">내 문의 내역 <i class="fa-solid fa-clipboard-list"></i></div>
					<hr/>
						<div style="text-align: left">
							<span style="color:red">제목을 클릭</span>하면 상세보기로 이동가능합니다.<br/>
							※ 문의 내용 중 개인정보가 포함되었거나 중복된 문의인 경우 삭제될 수 있습니다.
						</div>
					<hr/>
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
							<c:forEach var="askVO" items="${vos}" varStatus="st">
								<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
								<tr>
									<td>${curScrStartNo}</td>
									<td style="text-align: left;"><a href="">${askVO.title}</a></td>
									<td>${fn:substring(askVO.askDate,0,11)}</td>
									<td>${askVO.status}</td>
								</tr>
								<c:set var="curScrStartNo" value="${curScrStartNo - 1 }" />
							</c:forEach>
						</table>
					</div>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="myAskList?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="myAskList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="myAskList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="myAskList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="myAskList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="myAskList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>