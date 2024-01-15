<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의내역 | ${askVO.title}</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#askContent-right-content{
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
    	#askContent-right-inner-content{
    		margin: 0 auto;
    		width: 85%;
    		margin-top: 65px; 
    		margin-bottom: 35px; 
    	}
    	#askContent-myinfo-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#askContent-myinfo-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#askContent-inner-container{
    		border-top: 1px solid gray;
    		border-bottom: 1px solid gray;
    	}
    	.askContent-flex-div{
    		display: flex;
    	}
    	.askContent-4{
    		width: 25%;
    		margin: 15px 0px;
    	}
    	.fontB{
    		font-weight: bold;
    	}
    	.askContent-2{
    		width: 25%;
    		margin: 15px 0px;
    	}
    	.askContent-8{
    		text-align : left;	
    		width: 75%;
    		margin: 15px 0px;
    	}
    	#askContent-inner-container hr{
    		margin: 0px;
    	}
    	#ansContent-inner-container hr{
    		margin: 0px;
    	}
    	.askContent-flex-div button{
    		margin-left: auto;
    		margin-top: 10px;
    		margin-bottom: 10px;
    		background-color: #eee;
    		border : 1px solid gray;
    		width: 90px;
    		height: 40px;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="askContent-container">
		<div id="askContent-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="askContent-right-inner-content">
				<div id="askContent-myinfo-menu">
					<div id="askContent-myinfo-menu-str">내 문의 내역 <i class="fa-solid fa-clipboard-list"></i></div>
					<div class="askContent-flex-div"><button onclick="location.href='${ctp}/member/ask/myAskList?pag=${pag}&pageSize=${pageSize}'">목록</button></div>
					<div id="askContent-inner-container">
						<div class="askContent-flex-div">
							<div class="askContent-4 fontB">등록일</div>
							<div class="askContent-4">${fn:substring(askVO.askDate,0,16)}</div>
							<div class="askContent-4 fontB">처리상태</div>
							<div class="askContent-4">${askVO.status}</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">유형</div>
							<div class="askContent-8">${askVO.category}</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">제목</div>
							<div class="askContent-8">${askVO.title}</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">내용</div>
							<div class="askContent-8">
								${askVO.content}
								
								<c:if test="${!empty askVO.imgs}">
									<br/><br/><br/><br/>
									<div>[참고 이미지]</div>
									<div><img src="${ctp}/data/ask/${askVO.imgs}" width="350px"/></div>
								</c:if>
							</div>
						</div>
					</div>
					<div id="ansContent-inner-container">
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">답변일</div>
							<div class="askContent-8">${ansVO.ansDate}</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">답변</div>
							<div class="askContent-8">
								<c:if test="${empty ansVO }">
									<img src="${ctp}/data/ask/답변준비중.png" />
								</c:if>
								<c:if test="${!empty ansVO }">
									${ansVO.content}
								</c:if>
							</div>
						</div>
						<hr/>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>