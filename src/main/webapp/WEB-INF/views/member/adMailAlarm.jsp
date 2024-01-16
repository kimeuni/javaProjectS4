<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#myPage-right-content{
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
    	#myPage-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 110px; 
    		margin-bottom: 60px; 
    	}
    	#myPage-alarm-menu hr{
    		margin: 0px;
    	}
    	#myPage-alarm-menu{
    		margin-top: 20px !important;
    		margin: 0 auto;
    		width : 80%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myPage-alarm-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	.flex-div{
    		display: flex;
    		height: 50px;
    	}
    	.c-8{
    		width: 75%;
    		text-align: center;
    		font-size: 1.2em;
    		line-height: 50px;
    	}
    	.c-2{
    		width: 25%;
    		text-align: center;
    		font-size: 1.2em;
    		line-height: 50px;
    	}
    	.c-2 .no-btn div{
    		width: 120px;
    		height: 40px;
    		border: 1px solid #eee;
    		line-height: 40px;
    		background-color: black;
    		color: #fff;
    		text-decoration: none;
    		margin-top: 5px;
    	}
    	.c-2 .yes-btn div{
    		width: 120px;
    		height: 40px;
    		border: 1px solid green;
    		line-height: 40px;
    		background-color: green;
    		color: #fff;
    		text-decoration: none;
    		margin-top: 5px;
    	}
    	.c-2 a{
    		text-decoration: none;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function adYN(adYN){
    		let query = {
    			adYN : adYN,
    			mid : '${vo.mid}'
    		}
    		
    		$.ajax({
    			url : "${ctp}/member/adYN",
    			type : "post",
    			data : query,
    			success : function(res){
    				if(res == "1") location.reload();
    				else alert("메일 알람 끄기/켜지 실패")
    			},
    			error : function(){
    				alert("전송오류(adMailAlarm.jsp)")
    			}
    		});
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myPage-container">
		<div id="myPage-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myPage-right-inner-content">
				<div id="myPage-alarm-menu">
					<div id="myPage-alarm-menu-str">알림 관리 <i class="fa-regular fa-bell"></i></div>
					<hr/>
						<div class="flex-div">
							<div class="c-8">(광고/이메일)메일 알림</div>
							<div class="c-2">
								<c:if test="${vo.adYN == 'Y' }"><a href="javascript:adYN('N')" class="no-btn"><div>알림 끄기</div></a></c:if>
								<c:if test="${vo.adYN != 'Y' }"><a href="javascript:adYN('Y')" class="yes-btn"><div>알림 켜기</div></a></c:if>
							</div>
						</div>
					<hr/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>