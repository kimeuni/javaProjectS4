<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 답변 | ${askVO.title}</title>
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
    		margin-top: 60px; 
    		margin-bottom: 30px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 75%;
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
    	.askContent-7{
    		text-align : left;	
    		width: 68%;
    		margin: 15px 0px;
    	}
    	.askContent-1{
    		width: 7%;
    		margin: 15px 0px;
    		width: 80px;
    		color: #fff;
    		background-color: red;
    		border : 1px solid red;
    		border-radius: 5px;
    		height: 40px;
    		line-height: 40px;
    	}
    	.askContent-1 a{
    		text-decoration: none;
    		color: #fff;
    	}
    	#askContent-inner-container hr{
    		margin: 0px;
    	}
    	#ansContent-inner-container hr{
    		margin: 0px;
    	}
    	.askContent-flex-div .list-btn{
    		margin-left: auto;
    		margin-top: 10px;
    		margin-right : 10px;
    		margin-bottom: 10px;
    		background-color: #eee;
    		border : 1px solid gray;
    		width: 90px;
    		height: 40px;
    	}
    	.askContent-flex-div .del-btn{
    		margin-top: 10px;
    		margin-bottom: 10px;
    		background-color: red;
    		border : 1px solid red;
    		color : #fff;
    		width: 90px;
    		height: 40px;
    	}
    	.report-ok-btn{
    		background-color: green;
    		border : 1px solid green;
    	}
    	.askContent-flex-div .ask-input{
    		width: 120px;
    		height: 40px;
    		border: 1px solid #eee;
    		line-height: 40px;
    		background-color: black;
    		color: #fff;
    		text-decoration: none;
    		margin-top: 10px;
    		margin-left: auto;
    		margin-right: 20px;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function askDel(idx){
    		let ans  = confirm("해당 문의를 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
					url : "${ctp}/admin/askStatusNoDel",
					type : "post",
					data : {idx : idx},
					success : function(res){
						alert("삭제되었습니다.");
						location.href="${ctp}/admin/askStatusNo";
					},
					error : function(){
						alert("전송오류(askStatusNo.jsp)")
					}
				});
    		}
    	}
    	
    	// 상점 신고처리
    	function shopReport(reportShop){
    		let ans = confirm("해당 상점을 신고처리 하시겠습니까?");
    		if(ans){
    			let query = {
   					reportShop : reportShop,
   					idx : '${askVO.idx}',
   					reason : '${askVO.content}'
    			}
    			
    			$.ajax({
    				url : "${ctp}/admin/askUserReport",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
	    					alert("신고처리 되었습니다.");
	    					location.reload();
    					}
    					else {
	    					alert("신고처리에 실패하였습니다.");
	    					location.reload();
    					}
    				},
    				error : function(){
    					alert("전송오류(askAnsInput.jsp)")
    				}
    			});
    		}
    	}
    	
    	// 문의 답변
    	function askAnsInput(){
    		let content = $("#content").val();
    		
    		if(content.trim() == ""){
    			alert("문의 답변 내용을 작성해주세요.");
    			$("#content").focus();
    			return false;
    		}
    		else {
    			let query = {
    				idx : '${askVO.idx}',
    				content : content
    			}
    			$.ajax({
    				url : "${ctp}/admin/askAnsInput",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
    						alert("답변완료 되었습니다.")
    						location.href="${ctp}/admin/askStatusNo";
    					}
    					else if(res == "2"){
    						alert("답변에 실패하였습니다.")
    						location.reload();
    					}
    				},
    				error : function(){
    					alert("전송오류(askAnsInput.jsp)")
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
			<div id="top-menu-str">문의 답변</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">문의 답변 <i class="fa-solid fa-file-pen"></i></div>
					<div class="askContent-flex-div">
						<button onclick="location.href='${ctp}/admin/askStatusNo?pag=${pag}&pageSize=${pageSize}'" class="list-btn">목록</button>
						<button onclick="askDel(${askVO.idx})" class="del-btn">삭제</button>
					</div>
					<div id="askContent-inner-container">
						<div class="askContent-flex-div">
							<div class="askContent-4 fontB">등록일</div>
							<div class="askContent-4">${fn:substring(askVO.askDate,0,16)}</div>
							<div class="askContent-4 fontB">처리상태</div>
							<div class="askContent-4">${askVO.status}</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-4 fontB">유형</div>
							<div class="askContent-4">${askVO.category}</div>
							<div class="askContent-4 fontB">문의자</div>
							<div class="askContent-4">${askVO.mid}</div>
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
					<hr/>
					<div id="ansContent-inner-container">
						<c:if test="${!empty askVO.reportShop }">
							<div class="askContent-flex-div">
								<!-- 여기 나중에 상점 만들면 상점 보러갈 수 있도록 추가 -->
								<div class="askContent-2 fontB">신고 상점명 </div>
								<div class="askContent-7"><a href="">${askVO.reportShop}</a></div>
								<c:if test="${empty reportVO }">
									<div class="askContent-1 report-btn"><a href="javascript:shopReport('${askVO.reportShop}')">신고처리</a></div>
								</c:if>
								<c:if test="${!empty reportVO }">
									<div class="askContent-1 report-ok-btn">신고완료</div>
								</c:if>
							</div>
						</c:if>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">답변</div>
							<div class="askContent-8">
								<textarea rows="6" style="width: 100%" name="content" id="content"></textarea>
							</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<a href="javascript:askAnsInput()" class="ask-input"><div>문의 답변</div></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>