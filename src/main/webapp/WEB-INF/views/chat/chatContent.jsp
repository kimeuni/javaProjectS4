<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅창</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	#chat-content-container{
    		margin: 0 auto;
    		width: 1024px;
    		display: flex;
    		border-top: 1px solid #ddd;
    		border-bottom: 1px solid #ddd;
    	}
    	#chat-left-container{
    		width: 50%;
    		height: 700px;
    		border-right: 1px solid #ddd;
    	}
    	#chat-right-container{
    		width: 50%;
    		height: 700px;
    	}
    	.c-nick-div-b{
    		font-size: 1.2em;
   			font-weight: bold;
    	}
    	.f-d-1{
    		display: flex;
    		width: 10%;
    	}
    	.f-d-9{
    		display: flex;
    		width: 90%;
    	}
    	.f-w{
    		flex-wrap: wrap;
    	}
    	.f-2{
    		display: flex;
    		width: 20%;
    	}
    	.f-2 img{
    		width: 100%;
    		padding: 5px;
    	}
    	.emo-s{
    		height: 120px;
    		overflow: auto;
    	}
    	.emo-s input[type="radio"]{
    		display: none;
    	}
    	.chat-input-btn{
    		position:relative;
    		border-bottom: 1px solid #ddd;
    		border-top: 1px solid #ddd;
    	}
    	.chat-input-btn input[type="text"]{
    		width: 80%;
    		padding-left: 10px;
    		border: 1px solid #ddd;
    		border-radius: 5px;
    		outline: none;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function emoticonChan(idx,img){
    		let emoticon = $("#emoticon"+idx).val();
    		let str= '';
    		
    		str += '<div class="f-d" style="position: absolute; bottom: 298px; width: 512px; display: table; background: rgba(0, 0, 0, 0.2); color: #fff;">';
    		str += '<div style="display: table-cell; vertical-align: middle; text-align: center; font-size: 1.2em; font-weight: bold;"><img src="${ctp}/data/emoticon/'+img+'" width="80px" height="80px"/></div>';
    		str += '</div>';
		
    		$("#emoticon-demo").html(str);
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div id="chat-content-container">
		<div id="chat-left-container">
			<jsp:include page="/WEB-INF/views/include/chatGroup.jsp" />
		</div>
		<div id="chat-right-container">
			<div class="f-d pl-3 pr-3 pt-3">
				<div style="width: 100%; padding-bottom: 3px; border-bottom: 1px solid #ddd; ">
					<div class="c-nick-div-b">닉네임</div>
					<div>최근 접속일</div>
					<div class="f-d">
						<div class="f-d-1"><a href=""><img src="${ctp}/data/images/다모아 캐릭터.png" width="40px" height="40px"></a></div>
						<div class="f-d-9 pl-2">
							<div style="width: 100%">
								<div>상품이름</div>
								<div>금액</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="p-2" style="height: 420px;">
				<div class="f-d">
					<div></div>
				</div>
			</div>
			<div id="emoticon-demo"></div>
			<div class="f-d p-2 chat-input-btn">
				<input type="text" name="chatInputB" id="chatInputB" placeholder="메세지를 입력하세요."/>
				<div><a href="javascript:"><i class="fa-solid fa-circle-up"></i></a></div>
			</div>
			<div class="f-d f-w emo-s">
				<c:forEach var="eVO" items="${eVOS}">
					<div class="f-2">
						<input type="radio" value="${eVO.idx}" name="emoti" id="emoticon${eVO.idx}" onclick="emoticonChan('${eVO.idx}','${eVO.img}')"  /><label for="emoticon${eVO.idx}"><img src="${ctp}/data/emoticon/${eVO.img}" /></label>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>