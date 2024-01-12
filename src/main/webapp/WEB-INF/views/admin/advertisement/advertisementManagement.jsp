<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인화면 광고 관리</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-advertisement-right-content{
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
    	#admin-advertisement-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 90px; 
    		margin-bottom: 40px; 
    	}
    	#admin-advertisement-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-advertisement-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	.advertisement-list-div{
    		border: 1px solid gray;
    		border-radius: 5px;
    		min-height: 220px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#advertisement-input-go{
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
    	#advertisement-input-go a{
    		color: #fff;
    		text-decoration: none;
    	}
    	.advertisement-content-view{
    		width : 60%;
    		border: 1px solid gray;
    		border-radius: 5px;
    		min-height: 250px;
    		padding: 10px 15px;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-advertisement-container">
		<div id="admin-advertisement-right-content">
			<div id="top-menu-str">메인화면 광고 관리</div>
			<div id="admin-advertisement-right-inner-content">
				<div id="admin-advertisement-menu">
					<div id="admin-advertisement-menu-str">메인화면 광고 관리 <i class="fa-solid fa-file-pen"></i></div>
					<hr/>
					<div id="go-btn-div">
						<div id="advertisement-input-go">
							<a href="${ctp}/admin/advertisementInput">메인화면 광고 등록 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<hr/>
						<div>
							<h4 style="text-align: left;">전체 메인광고 리스트</h4>
						</div>
					<div class="advertisement-list-div">
						<c:forEach var="vo" items="${vos}" varStatus="st">
							
						</c:forEach>
					</div>
					<hr/>
					<h4 style="text-align: left;">선택 메인광고 미리보기</h4>
					<div class="advertisement-content-div">
						<div class="advertisement-content-view">
							<div><img src="${ctp}/data/advertisement/광고준비.png" width="160px" height="160px"></div>
							<div style="text-align: left; margin-top: 5px;">이동 할 주소 : 
								<a href="https://www.naver.com/">https://mail.naver.com/v2/read/0/17999</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>