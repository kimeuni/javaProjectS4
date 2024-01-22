<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 내역 | ${askVO.title}</title>
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
					url : "${ctp}/admin/askStatusYesDel",
					type : "post",
					data : {idx : idx},
					success : function(res){
						alert("삭제되었습니다.");
						location.href="${ctp}/admin/askStatusYes";
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
			<div id="top-menu-str">문의 답변 내역</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">문의 답변 내역 <i class="fa-solid fa-file-pen"></i></div>
					<div class="askContent-flex-div">
						<button onclick="location.href='${ctp}/admin/askStatusYes?pag=${pag}&pageSize=${pageSize}'" class="list-btn">목록</button>
						<c:if test="${askVO.ans_date_diff > 180 }">
							<button onclick="askDel(${askVO.idx})" class="del-btn">삭제</button>
						</c:if>
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
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">답변일</div>
							<div class="askContent-8">${fn:substring(ansVO.ansDate,0,16)}</div>
						</div>
						<hr/>
						<div class="askContent-flex-div">
							<div class="askContent-2 fontB">답변</div>
							<div class="askContent-8">
								${ansVO.content}
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