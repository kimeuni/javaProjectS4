<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>탈퇴 목록 등록</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-delTitle-right-content{
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
    	#admin-delTitle-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 90px; 
    		margin-bottom: 40px; 
    	}
    	#admin-delTitle-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#admin-delTitle-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#delTitle-input-container{
    		border: 1px solid gray;
    		border-radius: 5px;
    		min-height: 50px;
    	}
    	#delTitle-input-div h3{
    		color: gray;
    	}
    	#delTitle-input-str-div{
    		text-align: center;
    	}
    	.delTitle-input-str{
    		width: 24%;
    		display: inline-block;
    	}
    	#delTitle-input-div{
    		text-align: center;
    		margin: 10px 0px;
    	}
    	.delTitle-input{
    		width: 24%;
    		display: inline-block;
    	}
    	.delTitle-input input[type="text"]{
    		width: 80%;
   		    border: 0px;
    		padding: 0px 20px;
		    outline: none;
		    border-bottom: 1px solid;
    	}
    	#delTitle-title-list-content{
    		height: 400px;
    		padding: 20px 0px;
    	}
    	#delTitle-list{
    		width: 100%;
    		border: 1px solid;
    		border-radius: 5px;
    		overflow: auto;
    		height : 360px;
    		display: inline-block;
    	}
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-delTitle-container">
		<div id="admin-delTitle-right-content">
			<div id="top-menu-str">탈퇴 목록 등록</div>
			<div id="admin-delTitle-right-inner-content">
				<div id="admin-delTitle-menu">
					<div id="admin-delTitle-menu-str">탈퇴 목록 등록 <i class="fa-solid fa-list-check"></i></div>
					<hr/>
					<div style="text-align: left;">
						1. <span style="color:red">코드는 5글자</span>까지의 숫자,영문으로만 작성이 가능합니다. <br/>
						2. <span style="color:red">목차명은 29글자</span>까지 작성이 가능합니다. <br/>
						3. 목차를 삭제 시, 해당 <span style="color:red">목차로 탈퇴한 기록까지 모두 삭제</span>되오니 주의 바랍니다. <br/>
						4. 목차 비공개시, '다모아'를 이용중인 회원은 탈퇴 이유 선택 시, 해당 목차를 확인할 수 없습니다. <br/>
					</div>
					<hr/>
					<div id="delTitle-input-container">
						<h3>탈퇴 목록 추가 등록</h3>
						<hr/>
						<div id="delTitle-input-str-div">
							<div class="delTitle-input-str">코드</div>
							<div class="delTitle-input-str">목록명</div>
							<div class="delTitle-input-str">공개유무</div>
							<div class="delTitle-input-str">등록</div>
						</div>
						<div id="delTitle-input-div">
							<div class="delTitle-input"><input type="text" name="code" maxlength="5" required /></div>
							<div class="delTitle-input"><input type="text" name="title" maxlength="29" required /></div>
							<div class="delTitle-input">
								<input type="radio" name="displayNone" id="displayNoneY" value="Y" checked/><label for="displayNoneY">공개</label> &nbsp;&nbsp;
								<input type="radio" name="displayNone" id="displayNoneN" value="N"/><label for="displayNoneN">비공개</label>
							</div>
							<div class="delTitle-input"><input type="button" onclick="" value="목록 추가" /></div>
						</div>
					</div>
					<div id="delTitle-title-list-content">
						<div id="delTitle-list">
							<h3>탈퇴 목록 리스트</h3>
							<hr/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>