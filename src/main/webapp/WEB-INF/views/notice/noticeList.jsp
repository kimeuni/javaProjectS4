<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#notice-list-container{
    		max-width: 1200px;
    		min-height: 200px;
    		margin: 0 auto;
    	}
    	#notice-list-container h3{
    		padding-left: 30px;
    	}
    	#search-notice-container{
    		margin: 20px 0px;
    		text-align: right;
    	}
    	#search-notice-container div, #search-notice-container select{
    		display: inline-block;
    	}
    	#ul-li-container ul{
    		text-align: center;
    		margin: 0px;
    		padding: 0px;
    		margin-bottom: 20px;
    	}
    	.notice-list-li{
    		background-color: #fff;
		    display: inline-block;
		    padding: 5px 10px;
		    width: 33.3%;
		    height: 60px;
		    text-align: center;
	        border-top: 5px solid #5E5756;
		    border-right: 1px solid #eaeaee;
		    font-size: 1.2em;
		    line-height: 50px;
		    font-weight: bold;
    	}
    	.event-li{
    		background-color: #fafafc;;
		    display: inline-block;
		    padding: 5px 10px;
		    width: 33.3%;
		    height: 60px;
		    text-align: center;
	        border-top: 1px solid #eaeaee;
		    border-right: 1px solid #eaeaee;
		    border-bottom: 1px solid #c8c8d5;
		    font-size: 1.2em;
		    line-height: 50px;
		    font-weight: bold;
    	}
    	.FAQ-li{
    		background-color: #fafafc;;
		    display: inline-block;
		    padding: 5px 10px;
		    width: 33.3%;
		    height: 60px;
		    text-align: center;
	        border-top: 1px solid #eaeaee;
		    border-right: 1px solid #eaeaee;
		    border-bottom: 1px solid #c8c8d5;
		    font-size: 1.2em;
		    line-height: 50px;
		    font-weight: bold;
    	}
    	#ul-li-container ul a{
    		color: #252525;
    		text-decoration: none;
    	}
    	#notice-list-ul-li ul li:hover{
    		background-color: #f1f3f5;
    	}
    	#notice-list-ul-li ul{
    		text-align: center;
    		margin: 0px;
    		padding: 0px;
    	}
    	#notice-list-ul-li ul li{
   		    background-color: #fff;;
		    display: inline-block;
		    padding: 5px 10px;
		    width: 100%;
		    height: 60px;
		    text-align: center;
	        border-top: 1px solid #c8c8d5;
		    font-size: 1.1em;
		    line-height: 50px;
    	}
    	#notice-list-ul-li ul li a{
    		text-decoration: none;
    		color: #000;
    	}
    	.notice-list-ul-li-div{
    		display: inline-block;
    	}
    	.no-div{
    		width: 5%;
    	}
    	.title-div{
    		width: 80%;
    		text-align: left;
    	}
    	.date-div{
    		width: 10%;
    	}
    	.new-str{
    		border-radius: 100%;
    		color: #fff;
    		background-color: orange;
    		padding: 2px 5px;
    		height: 25px;
    		line-height: 25px;
    		margin-left: 10px;
    		font-weight: bolder;
    		font-size: 0.8em
    	}
    </style>
    <script>
    	'use strict'
    	
    	$(function() {
	    	$("#searchString").on("keydown",function(e) {
	    		if(e.keyCode == 13){
	    			searchNotices();
	    		}
	    	});
    	});
    	
    	function searchNotices(){
    		let searchString = $("#searchString").val();
    		
    		if(searchString.trim() == ""){
    			alert("검색할 내용을 입력하세요.");
    			$("#searchString").focus();
    			return false;
    		}
    		else{
    			location.href="${ctp}/board/noticeSearch?part=title&searchString="+searchString;
    		}
    	}
    	
    	function eventBtn(){
    		alert("현재 이벤트 준비중 입니다.")
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="notice-list-container">
		<hr/>
		    <h3>공지사항</h3>
		<hr/>
		<div>
			<div id="search-notice-container">
				<div>
					<input type="text" name="searchString" id="searchString" />
				</div>
				<div>
					<input type="button" onclick="searchNotices()" value="검색"/>
				</div>
			</div>
		</div>
		<div id="ul-li-container">
			<ul>
				<a href="${ctp}/board/noticeList"><li class="notice-list-li">공지사항</li></a><a href="javascript:eventBtn()"><li class="event-li">이벤트</li></a><a href="${ctp}/board/FAQList"><li class="FAQ-li">자주하는 질문</li></a>
			</ul>
		</div>
		<div id="notice-list-ul-li">
			<c:set var="curScrStartNo" value="${pageVO.curScrStartNo }"></c:set>
			<ul>
				<c:forEach var="mVO" items="${vos}" varStatus="st">
					<li>
						<div class="notice-list-ul-li-div no-div">${curScrStartNo}</div>
						<a href="${ctp}/board/noticeContent?idx=${mVO.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><div class="notice-list-ul-li-div title-div">${mVO.title}<c:if test="${mVO.hour_diff <=24}"><span class="new-str">N</span></c:if>  </div></a>
						<div class="notice-list-ul-li-div date-div">
							<c:if test="${mVO.hour_diff <= 24 }">
								${mVO.date_diff == 0 ? fn:substring(mVO.NDate,11,16) : fn:substring(mVO.NDate,5,16)}
							</c:if>
							<c:if test="${mVO.hour_diff > 24 }">
								${fn:substring(mVO.NDate,0,10)}
							</c:if>
						</div>
					</li>
					<c:set var="curScrStartNo" value="${curScrStartNo-1}"></c:set>
				</c:forEach>
			</ul>
		</div>
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="noticeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>