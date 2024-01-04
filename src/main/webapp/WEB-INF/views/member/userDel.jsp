<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계정탈퇴 안내</title>
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
    		margin-top: 60px; 
    	}
    	#myPage-userDel{
    		margin: 0 auto;
    		width : 75%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: left;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#myPage-userDel-str{
    		font-size: 1.2em;
    		color : gray;
    		margin-bottom: 20px;
    	}
    	#DelBtn{
    		margin: 15px 0px;
			width: 435px;
			height: 50px;
			background: #402F1D;
			color: #fff;
			font-size: 1.2em;
			border-radius: 10px;
			font-weight: bold;
    	}
    	#DelBtn-div{
    		text-align: center;
    	}
    	#myPage-userDel input[type="password"], #myPage-userDel select{
    		width: 300px;
    		height: 38px;
    	}
    	.check-no{
    		height: 30px;
    		color: red;
    	}
    	#otherWhy{
    		margin-top: 10px;
    		resize: none;
    	}
    	#otherWhy textarea{
    		resize: none;
    	}
    	#demo-Del{
    		color: red;
    		font-size: 16px;
    		text-align: center;
    	}
    </style>
    <script>
    	'use strict'
    	
    	let str ='';
    	
    	$(function() {
    		$("#otherWhy").hide();
    	});
    	$(function() {
    		$("#whyDel").on("click",function() {
    			let whyDel =$("#whyDel").val();
    			if(whyDel == "기타"){
    				$("#otherWhy").show();
    			}
    			else $("#otherWhy").hide();
    		})
    	});
    	
    	// 값이 공백이 아닐 시, 메세지 삭제
    	$(function() {
    		$("#whyDel").on("click",function() {
    			let whyDel =$("#whyDel").val();
    			if(whyDel != ""){
    				str = '';
    				$("#demo-whyDel").html(str);
    			}
    		})
    	});
    	$(function() {
    		$("#pwd").on("keyup",function(){
    			let pwd = $("#pwd").val()
    			if(pwd.trim() != ""){
    				str = '';
    				$("#demo-pwd").html(str);
    			}
    		});
    	});
    	$(function() {
    		$("#why").on("keyup",function(){
    			let why = $("#why").val()
    			if(why.trim() != ""){
    				str = '';
    				$("#demo-whyDel").html(str);
    			}
    		});
    	});
    	$(function() {
    		$("#DelOk").on("click",function(){
    			let DelOk = '';
        		if(document.getElementsByName("DelOk")[0].checked) DelOk = "yes";
    			if(DelOk != ""){
    				str = '';
    				$("#demo-DelOk").html(str);
    			}
    		});
    	});
    	
    	function userDelOk(){
    		let pwd = $("#pwd").val()
    		let whyDel =$("#whyDel").val();
    		let DelOk = '';
    		if(document.getElementsByName("DelOk")[0].checked) DelOk = "yes";
    		let why = $("#why").val();
    		
    		if(pwd.trim() == ""){
    			str = '비밀번호를 입력해주세요.';
    			$("#demo-pwd").html(str);
    			return false;
    		}
    		else if(whyDel == ""){
    			str = '탈퇴 사유를 선택해주세요.';
    			$("#demo-whyDel").html(str);
    			return false;
    		}
    		else if(whyDel == "기타" && why.trim() == ""){
    			str = '탈퇴 사유를 입력해주세요.';
    			$("#demo-whyDel").html(str);
    			return false;
    		}
    		else if(DelOk == ""){
    			str = '동의 사항을 체크해주세요.';
    			$("#demo-DelOk").html(str);
    			return false;
    		}
    		else{
    			let query = {
    				pwd : pwd,
    				whyDel : whyDel,
    				why : why
    			}
    			$.ajax({
    				url : "${ctp}/member/userDelOk",
    				type : "post",
    				data : query,
    				success : function(res){
    					if(res == "1"){
    						str = '입력하신 비밀번호를 다시 확인해주세요.';
    						$("#demo-Del").html(str);
    					}
    					else if(res == "2"){
    						str = '회원탈퇴';
    						$("#demo-Del").html(str);
    					}
    				},
    				error : function(){
    					alert("전송오류(userDel.jsp)")
    				}
    			});
    		}
    		
    		
    	}
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/myPageMenu.jsp" />
	<div id="myPage-container">
		<div id="myPage-right-content">
			<div id="top-menu-str">${menuStr}</div>
			<div id="myPage-right-inner-content">
				<div id="myPage-userDel">
					<div id="myPage-userDel-str">계정탈퇴 안내 <i class="fa-solid fa-user-slash"></i><c:if test="${sMid == 'admin'}"> <span style="color:red">(관리자는 회원 탈퇴 불가)</span></c:if></div>
					<div style="color:gray">안내사항을 반드시 숙지 후 진행 바랍니다.</div><br/>
					<div>
						1.사용하고 계신 아이디(<span style="color:red">${vo.mid}</span>)는 탈퇴하실 경우 30일간 동일한 아이디로 재가입이 불가능합니다.<br/>
						<span style="color:red">탈퇴하신 계정은 복구가 불가능</span>하오니, 신중하게 선택 바랍니다.<br/><br/>
						
						2.탈퇴하신 경우 이용하신 내역 수정 및 확인이 어려울 수 있이며 로그인 후 가능한 모든 기능은 사용이 불가능합니다. 
						<span style="color:red">기존에 거래중인 상품이 있는지 확인 후 탈퇴</span>해주시기 바랍니다.<br/><br/>
					</div>
					<hr/>
					<div>사용중인 비밀번호</div>
					<div><input type="password" name="pwd" id="pwd" placeholder="비밀번호" /></div>
					<div id="demo-pwd" class="check-no"></div>
					<select name="whyDel" id="whyDel">
						<option value="">탈퇴 사유를 선택해주세요.</option>
						<option value="찾는 물건 없음">찾는 물품이 없어요</option>
						<option value="물품 안 팔림">물품이 안 팔려요</option>
						<option value="비매너 사용자 만남">비매너 사용자를 만났어요</option>
						<option value="새상점 만들기">새 상점을 만들고 싶어요</option>
						<option value="개인정보 삭제">개인정보를 삭제하고 싶어요</option>
						<option value="이용 불편">이용이 불편하고 장애가 많아요</option>
						<option value="사용 빈도 낮음">사용 빈도가 낮아요</option>
						<option value="기타">기타</option>
					</select>
					<div id="otherWhy"><textarea rows="4" cols="50" id="why"></textarea></div>
					<div id="demo-whyDel" class="check-no"></div>
					<div><input type="checkbox" name="DelOk" id="DelOk" value="yes"><label for="DelOk"><span style="color:red"> (필수)</span>위의 내용을 모두 확인하였으며, 이에 동의합니다.</label></div>
					<div id="demo-DelOk" class="check-no"></div>
					<div id="DelBtn-div" ><input type="button" name="DelBtn" id="DelBtn" onclick="userDelOk()" value="탈퇴하기"/></div>
					<div id="demo-Del"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>