<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자주하는 질문</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#FAQ-categorySearch-container{
    		max-width: 1200px;
    		min-height: 200px;
    		margin: 0 auto;
    	}
    	#FAQ-categorySearch-container h3{
    		padding-left: 30px;
    	}
    	#search-FAQ-container{
    		margin: 20px 0px;
    		text-align: right;
    	}
    	#search-FAQ-container div, #search-FAQ-container select{
    		display: inline-block;
    	}
    	#ul-li-container ul{
    		text-align: center;
    		margin: 0px;
    		padding: 0px;
    		margin-bottom: 20px;
    	}
    	.notice-list-li{
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
    	#ul-li-container ul a{
    		color: #252525;
    		text-decoration: none;
    	}
		
		.accordion{
			margin-bottom: 50px;
		}
		input[id*="answer"]{
			display: none;
		}
		input[id*="answer"] + label{
			display: block;
			padding: 20px;
			border: 1px solid #ccc;
			color: #000;
			font-weight: 900;
			background: #fff;
			cursor: pointer;
			margin: 0px;
		}
		input[id*="answer"] + label + div{
			max-height: 0;
			transition: all .35s;
			overflow: hidden;
			background: #eee;
			font-size: 14px;
		}
		input[id*="answer"] + label + div p {
			display: inline-block;
			padding: 20px;
		}
		input[id*="answer"]:checked + label + div {
			max-height: 300px;
			overflow: auto;
		}
		#category-div{
			height: 70px;
			line-height: 70px;
			text-align: center;
			margin-top: 30px; 
			border-top: 1px solid;
			border-bottom: 1px solid;
		}
		.category-div-a{
			display: inline-block;
			width: 16.3%;
			border-right: 1px solid;
		}
		#category-div a{
			text-decoration: none;
			color : #000;
		}
		#FAQ-categorySearch-container h3{
			margin-top: 50px;
			margin-bottom: 20px;
		}
		#search-no{
    		font-size: 1.2em;
    		text-align: center;
    		margin: 20px 0px; 
    		padding: 0px 30px;
    	}
    	#search-no a{
    		color: red;
    	}
    </style>
    <script>
    	'use strict'
    	
    	$(function() {
    		$("#searchString").on("keydown",function(e) {
    			if(e.keyCode == 13){
    				searchFAQ()
    			}
    		});
    	});
    	
    	function searchFAQ(){
    		let searchString = $("#searchString").val()
    			
			if(searchString.trim() == ""){
				alert("검색할 단어를 입력해주세요.");
				$("#searchString").focus();
				return false;
			}    		
			else {
				location.href="${ctp}/board/FAQStringSearch?part=string&searchString="+searchString;
			}
    	}
    	
		// 1:1 문의하기 화면 띄우기
    	function askInputOpen(){
    		let mid = '${sMid}';
    		
			if(mid == ""){
				alert("로그인 후 이용 가능한 서비스 입니다.");
				location.href="${ctp}/member/login"
			}
			else{
	    		let url = "${ctp}/ask/askInput";
	        	let winName = "1:1 문의하기";
	        	let opt = "width=600px, height=850px, top=100px, left=500px " 
	        	
	       		childWindow = window.open(url,winName,opt)
			}
			
    	}
    	
    	function eventBtn(){
    		alert("현재 이벤트 준비중 입니다.")
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="FAQ-categorySearch-container">
		<hr/>
		    <h3>자주하는 질문</h3>
		<hr/>
		<div>
			<div id="search-FAQ-container">
				<div>
					<input type="text" name="searchString" id="searchString" placeholder="궁금한 것을 검색해보세요."/>
				</div>
				<div>
					<input type="button" onclick="searchFAQ()" value="검색"/>
				</div>
			</div>
		</div>
		<div id="ul-li-container">
			<ul>
				<a href="${ctp}/board/noticeList"><li class="notice-list-li">공지사항</li></a><a href="javascript:eventBtn()"><li class="event-li">이벤트</li></a><a href="${ctp}/board/FAQList"><li class="FAQ-li">자주하는 질문</li></a>
			</ul>
		</div>
		<div>
			<h4>카테고리로 찾기</h4>
			<div id="category-div">
				<a href="${ctp}/board/FAQList"><div class="category-div-a" style="border-left: 1px solid;">전체 <i class="fa-solid fa-right-to-bracket"></i></div></a>
				<a href="${ctp}/board/FAQCategorySearch?part=category&searchString=채팅"><div class="category-div-a">채팅 <i class="fa-solid fa-right-to-bracket"></i></div></a>
				<a href="${ctp}/board/FAQCategorySearch?part=category&searchString=알림"><div class="category-div-a">알림 <i class="fa-solid fa-right-to-bracket"></i></div></a>
				<a href="${ctp}/board/FAQCategorySearch?part=category&searchString=검색"><div class="category-div-a">검색 <i class="fa-solid fa-right-to-bracket"></i></div></a>
				<a href="${ctp}/board/FAQCategorySearch?part=category&searchString=계정/로그인"><div class="category-div-a">계정/로그인 <i class="fa-solid fa-right-to-bracket"></i></div></a>
				<a href="${ctp}/board/FAQCategorySearch?part=category&searchString=기타"><div class="category-div-a">기타 <i class="fa-solid fa-right-to-bracket"></i></div></a>
			</div>
		</div>
		<h3>'${searchString}' 검색결과</h3>
		<c:if test="${empty vos }"><div id="search-no">검색하신 내용이 존재하지 않습니다.<br/><br/>
			<c:if test="${sMid != null }">
				<a href="javascript:askInputOpen()">1:1 문의하러 가기</a></div>
			</c:if>
		</c:if>
		<c:if test="${!empty  vos}">
			<div class="accordion">
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<input type="checkbox" name="answer" id="answer${vo.idx}">
					<label for="answer${vo.idx}">${vo.question}</label>
					<div><p>${vo.answer }</p></div>
				</c:forEach>
			</div>
		</c:if>
		<br/>
		<div class="text-center">
			<ul class="pagination justify-content-center">
			    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="FAQStringSearch?pag=1&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
			  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="FAQStringSearch?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
			  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
				    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="FAQStringSearch?pag=${i}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}">${i}</a></li></c:if>
				    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="FAQStringSearch?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
			  	</c:forEach>
			  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="FAQStringSearch?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
			  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="FAQStringSearch?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			</ul>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>