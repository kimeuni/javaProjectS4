<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 | ${vo.title}</title>
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
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#admin-content-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
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
    	#notice-content-div{
    		border-bottom: 1px solid #5E5756;
    		text-align: left;
    	}
    	div #notice-content img{
    	max-width: 600px; 
    	height: auto !important; 
    	}
    	#notice-str-div{
    		margin-top: 50px;
    		margin-bottom: 40px;
    	}
    	#notice-str{
    		width: 90%;
    		display: inline-block;
    	}
    	#notice-list{
    		width: 8%;
    		display: inline-block;
    	}
    	#notice-list-btn{
    		width: 100px;
    		height: 40px;
    		line-height: 40px;
    		background-color: #eee;
    		border-radius: 5px;
    		text-align: center;
    		border: 1px solid #5E5756;
    	}
    	#notice-list a{
    		text-decoration: none;
    		color: #000;
    	}
    	#notice-title-div{
    		border-bottom: 1px solid #5E5756;
    		border-top: 1px solid #5E5756;
    		background-color: #F1E5D4;
    		height: 80px;
    		font-size: 1.5em;
    		line-height: 80px;
    		padding: 0px 15px;
    		color: #5E5756;
    	}
    	#notice-read-date{
    		height: 60px;
    		line-height: 60px;
    		border-top: 1px solid #5E5756;
    		text-align: right;
    		width: 100%;
    		color: #CEBAAD;
    	}
    	#notice-read{
    		width: 20%;
    		display: inline-block;
    	}
    	#notice-date{
    		padding-right: 20px;
    		width: 17%;
    		display: inline-block;
    	}
    	#notice-content{
    		margin: 20px 40px;
    	}
    	.content-flex-div{
    		display: flex;
    	}
    </style>
    <script>
    	'use strict'
    	function contetnDelete(title,idx){
    		let ans = confirm("<"+title+">의 공지사항을 삭제하시겠습니까?");
    		if(ans){
    			$.ajax({
    				url : "${ctp}/admin/noticeDel",
    				type : "post",
    				data : {idx : idx},
    				success : function(res){
    					alert("삭제되었습니다.");
						location.href="${ctp}/admin/noticeManagement";
    				},
    				error : function(){
    					alert("전송오류(noticecontent.jsp)")
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
			<div id="top-menu-str">공지사항 상세보기</div>
			<div id="admin-content-right-inner-content">
				<div id="admin-content-menu">
					<div class="content-flex-div">
						<div id="admin-content-menu-str">공지사항 상세보기 <i class="fa-solid fa-book-open"></i></div>
						<a href="${ctp}/admin/noticeManagement"><div class="go-btn">돌아가기</div></a>
						<a href="${ctp}/admin/noticeUpdate?idx=${vo.idx}"><div class="go-btn update-btn">수정</div></a>
						<a href="javascript:contetnDelete('${vo.title }',${vo.idx})"><div class="go-btn delete-btn">삭제</div></a>
					</div>
					<div id="notice-content-div">
						<div id="notice-read-date">
							<div id="notice-read"><i class="fa-solid fa-eye"></i>${vo.readNum}</div>
							<div id="notice-date"><i class="fa-regular fa-calendar-days"></i>${fn:substring(vo.NDate,0,10)}</div>
						</div>
						<div id="notice-title-div">
							<div id="notice-title-str">${vo.title}</div>
						</div>
						<div id="notice-content">${vo.content}</div>
			    	</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>