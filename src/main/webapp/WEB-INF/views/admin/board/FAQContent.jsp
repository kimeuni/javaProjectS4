<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FAQ | ${vo.question}</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-content-right-content{
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
    	#admin-content-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-content-menu{
    		margin: 0 auto;
    		width : 100%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-content-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#admin-content-menu-str{
    		width: 68%; 
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    		display: inline-block;
    	}
    	.go-btn{
    		width: 80px;
    		background-color: #fff;
    		border : 1px solid #315eb2;
    		color: #315eb2;
    		font-weight: bold;
    		height: 27px;
    		line-height : 27px;
    		display: inline-block;
    		border-radius: 5px;
    		margin-right: 10px;
    	}
    	.update-btn{
    		border : 1px solid orange;
    		color: orange;
    	}
    	.delete-btn{
    		border : 1px solid red;
    		color: red;
    	}
    	#FAQ-content-div{
    		border-bottom: 1px solid #5E5756;
    		text-align: left;
    	}
    	div #FAQ-content img{
    	max-width: 600px; 
    	height: auto !important; 
    	}
    	#FAQ-str-div{
    		margin-top: 50px;
    		margin-bottom: 40px;
    	}
    	#FAQ-str{
    		width: 90%;
    		display: inline-block;
    	}
    	#FAQ-list{
    		width: 8%;
    		display: inline-block;
    	}
    	#FAQ-list-btn{
    		width: 100px;
    		height: 40px;
    		line-height: 40px;
    		background-color: #eee;
    		border-radius: 5px;
    		text-align: center;
    		border: 1px solid #5E5756;
    	}
    	#FAQ-list a{
    		text-decoration: none;
    		color: #000;
    	}
    	#FAQ-title-div{
    		border-bottom: 1px solid #5E5756;
    		border-top: 1px solid #5E5756;
    		height: 80px;
    		font-size: 1.5em;
    		line-height: 80px;
    		padding: 0px 15px;
    		color: #5E5756;
    		background-color: #eee;
    	}
    	#FAQ-content{
    		margin: 20px 40px;
    	}
    	.content-flex-div{
    		display: flex;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function contetnDelete(question,idx){
    		let ans = confirm("<"+question+">의 질문을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/FAQDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					alert("삭제되었습니다.");
						location.href="${ctp}/admin/FAQManagement";
    				},
    				error : function(){
    					alert("전송오류(FAQcontent.jsp)")
    				}
    			});
    		}
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-content-container">
		<div id="admin-content-right-content">
			<div id="top-menu-str">자주하는 질문 상세보기</div>
			<div id="admin-content-right-inner-content">
				<div id="admin-content-menu">
					<div class="content-flex-div">
						<div id="admin-content-menu-str">자주하는 질문 상세보기 <i class="fa-solid fa-book-open"></i></div>
						<a href="${ctp}/admin/FAQManagement"><div class="go-btn">돌아가기</div></a>
						<a href="${ctp}/admin/FAQUpdate?idx=${vo.idx}"><div class="go-btn update-btn">수정</div></a>
						<a href="javascript:contetnDelete('${vo.question }',${vo.idx})"><div class="go-btn delete-btn">삭제</div></a>
					</div>
					<div id="FAQ-content-div">
						<div id="FAQ-title-div">
							<div id="FAQ-title-str">${vo.question}</div>
						</div>
						<div id="FAQ-content">${vo.answer}</div>
			    	</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>