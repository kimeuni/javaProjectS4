<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-noticeMag-right-content{
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
    	#admin-noticeMag-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#admin-noticeMag-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-notice-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#noticeInput-go{
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
    	#noticeInput-go a{
    		text-decoration: none;
    		color: #fff;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-noticeMag-container">
		<div id="admin-noticeMag-right-content">
			<div id="top-menu-str">공지사항 관리</div>
			<div id="admin-noticeMag-right-inner-content">
				<div id="admin-noticeMag-menu">
					<div id="admin-notice-menu-str">공지사항 관리 <i class="fa-solid fa-file-pen"></i></div>
					<hr/>
						<div style="text-align: left">
							1. 해당 페이지에서는 공지사항을 <span style="color: red">수정, 삭제</span>할 수 있습니다.<br/>
							2. 공지사항 등록은 <span style="color: red">공지사항-공지 작성</span> 에서 가능합니다.
						</div>
					<hr/>
					<div id="go-btn-div">
						<div id="noticeInput-go">
							<a href="${ctp}/admin/noticeInput">공지 작성 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<div id="choice-Del-btn">
						<a href="javascript:choiceDel()">선택 삭제</a>
					</div>
					<form name="userDelForm">
						<table class="table table-hover text-center">
							<thead>
								<tr>
									<th><input type="checkbox" name="ckAll" id="ckAll" value="all" onclick="checkAll()"/></th>
									<th>번호</th>
									<th>제목</th>
									<th>작성일</th>
									<th>조회수</th>
									<th>공개유무</th>
									<th>상세보기</th>
									<th>수정</th>
									<th>삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"></c:set>
								<c:forEach var="nVO" items="${nVOS}" varStatus="st">
									<tr>
										<td><input type="checkbox" name="ckS" class="ckS" value="${mVO.mid}/${mVO.nickName}"/></td>
										<td>${curScrStartNo}</td>
										<c:if test="${fn:length(nVO.title) > 25 }">
											<td style="text-align: left;">${fn:substring(nVO.title,0,23)}...</td>
										</c:if>
										<c:if test="${fn:length(nVO.title) <= 25 }">
											<td style="text-align: left;">${nVO.title}</td>
										</c:if>
										<td>${fn:substring(nVO.NDate,0,10)}</td>
										<td>${nVO.readNum }</td>
										<td>${nVO.openSw == 'Y'? '공개' : '비공개' }</td>
										<td><a href="">상세보기</a></td>
										<td><a href="${ctp}/admin/noticeUpdate?idx=${nVO.idx}">수정</a></td>
										<td><a href="">삭제</a></td>
									</tr>
									<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
								</c:forEach>
							</tbody>
						</table>
					</form>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="memberList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>