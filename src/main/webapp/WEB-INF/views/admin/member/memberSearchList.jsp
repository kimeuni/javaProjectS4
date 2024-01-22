<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 검색 리스트</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <style>
    	body{
    		margin: 0px;
    		padding: 0px;
    	}
    	#admin-memberList-right-content{
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
    	#admin-memberList-right-inner-content{
    		margin: 0 auto;
    		width: 70%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-memberList-inner-content{
    		margin: 0 auto;
    		width : 100%;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	#memberInfo-container{
    		border: 1px solid gray;
    		margin: 10px 50px;
    	}
    	#memberInfor-div{
    		margin: 0 auto;
    		width: 75%;
    		border: 1px solid gray;
    		margin-bottom: 20px;
    	}
    	#search-member-container{
    		margin: 20px 0px;
    		text-align: right;
    	}
    	#search-member-container div, #search-member-container select{
    		display: inline-block;
    	}
    	#memberInfo-container{
    		padding: 10px;
    	}
    	#memberInfor-div{
    		padding: 10px;
    	}
    	.member-str{
    		width: 25%;
    		display: inline-block;
    	}
    	.member-input{
    		width: 70%;
    		display: inline-block;
    		text-align: left;
    	}
    	.member-input img{
    		width: 100px;
    		border-radius: 100%;
    	}
    	.member-str-input-div{
    		padding : 5px 0px;
    		border-top: 1px solid gray;
    	}
    	#admin-memberList-menu-str{
    		font-size: 1.2em;
    		color : gray;
    		text-align: left;
    		margin-bottom: 20px;
    	}
    	#go-btn-div{
    		text-align: right;
    		margin-bottom: 20px;
    	}
    	#userDel-go, #memberReport-go{
    		display: inline-block;
    		height: 40px;
    		border: 1px solid gray;
    		width: 200px;
    		line-height: 40px;
    		border-radius: 5px;
    		text-align: center;
    	}
    	#userDel-go a, #memberReport-go a{
    		text-decoration: none;
    	}
    	#userDel-go{
    		background-color: #315eb2;
    		color: #fff;
    		font-weight: bold;
    	}
    	#userDel-go a{
    		color: #fff;
    	}
    	#memberReport-go a{
    		color: #000;
    	}
    </style>
    <script>
    	'use strict'
    	
    	$(function() {
    		$(".info-hide").hide();
    		$(".memberInfoDown").show();
    		$(".memberInfoUp").hide();
    	});
    	
    	// 상세 보기 열기
    	function memberInfoDown(idx){
    		$(".memberInfoDown").hide();
    		$(".memberInfoUp").show();
    		$("#memberInfo"+idx).show();
    	}
    	
    	// 상세 보기 닫기
    	function memberInfoUp(idx){
    		$(".memberInfoDown").show();
    		$(".memberInfoUp").hide();
    		$("#memberInfo"+idx).hide();
    	}
    	
    	// 개별 검색
    	function searchMembers(){
    		let searchString = $("#searchString").val();
    		let part = $("#part").val();
    		
    		if(searchString.trim() == ""){
    			alert("검색할 단어를 입력하세요.");
    			$("#searchString").focus();
    			return false;
    		}
    		else if(part.trim() == ""){
    			alert("검색한 구분을 선택해주세요.");
    			return false;
    		}
    		else {
    			location.href='${ctp}/admin/memberSearchList?searchString='+searchString+"&part="+part;
    		}
    	}
    	
    	$(function() {
    		$("#searchString").on("keydown",function(e) {
    			if(e.keyCode == 13){
    				searchMembers();
    			}
    		});
    	});
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-memberListcontainer">
		<div id="admin-memberList-right-content">
			<div id="top-menu-str">회원 리스트</div>
			<div id="admin-memberList-right-inner-content">
				<div id="admin-memberList-inner-content">
					<div id="admin-memberList-menu-str">검색 회원 조회 <i class="fa-solid fa-users"></i> <i class="fa-solid fa-magnifying-glass"></i></div>
					<div id="go-btn-div">
						<div id="userDel-go">
							<a href="${ctp}/admin/memberUserDel">회원 탈퇴 신청 이동 <i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
						<div id="memberReport-go">
							<a href="${ctp}/admin/memberReport">회원 신고 관리 이동<i class="fa-solid fa-right-from-bracket"></i></a>
						</div>
					</div>
					<div>
						<div id="search-member-container">
							<select id="part" name="part">
								<option value="">구분선택</option>
								<option value="name">성명</option>
								<option value="nickName">닉네임</option>
								<option value="email">이메일</option>
							</select>
							<div>
								<input type="text" name="searchString" id="searchString" />
							</div>
							<div>
								<input type="button" onclick="searchMembers()" value="검색"/>
							</div>
						</div>
					</div>
					<table class="table table-hover text-center">
						<thead>
							<tr>
								<th>성명</th>
								<th>닉네임</th>
								<th>이메일</th>
								<th>광고 수신 동의</th>
								<th>가입일</th>
								<th>상태</th>
								<th>총 신고수</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty mVOS}"><tr><td colspan="9"><span style="color:red">${partStr}</span>(으)로 검색하신 <span style="color:red">${searchString}</span>은(는) 없는 회원입니다.</td></tr></c:if>
							<c:if test="${mVOS != null }">
								<c:forEach var="mVO" items="${mVOS}" varStatus="st">
									<tr>
										<td>${mVO.name}</td>
										<td>${mVO.nickName}</td>
										<td>${mVO.email}</td>
										<td>${mVO.adYN}</td>
										<td>${fn:substring(mVO.startDate,0,10)}</td>
										<td>${mVO.userDel=='N'? '활동중' : '탈퇴' }</td>
										<td>${mVO.totReportCnt}</td>
										<td class="memberInfoDown" class="down-hide"><button onclick="memberInfoDown(${mVO.idx})"><i class="fa-solid fa-sort-down"></i></button></td>
										<td class="memberInfoUp" class="up-hide"><button onclick="memberInfoUp(${mVO.idx})"><i class="fa-solid fa-caret-up"></i></button></td>
									</tr>
									<tr id="memberInfo${mVO.idx}" class="info-hide">
										<td colspan="9">
											<div id="memberInfo-container">
												<h3>회원 상세정보</h3>
												<hr/>
												<div id="memberInfor-div">
													<div class="member-str-input-div">
														<div class="member-str">고유번호</div>
														<div class="member-input">${mVO.idx }</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">프로필 사진</div>
														<div class="member-input"><img src="${ctp}/data/images/${mVO.profile}"></div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">아이디</div>
														<div class="member-input">${mVO.mid}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">성명</div>
														<div class="member-input">${mVO.name}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">닉네임</div>
														<div class="member-input">${mVO.nickName}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">이메일</div>
														<div class="member-input">${mVO.email}</div>
													</div>
													<c:set var="adrs" value="${fn:split(mVO.address,'/')}"></c:set>
													<div class="member-str-input-div">
														<div class="member-str">주소</div>
														<div class="member-input">${adrs[0]} / ${adrs[1]}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">상세 주소</div>
														<div class="member-input">${adrs[2]} / ${adrs[3]}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">최근 접속일</div>
														<div class="member-input">${fn:substring(mVO.lastDate,0,16)}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">이메일 수신여부</div>
														<div class="member-input">${mVO.adYN}</div>
													</div>
													<div class="member-str-input-div">
														<div class="member-str">누적 신고수</div>
														<div class="member-input">${mVO.totReportCnt}</div>
													</div>
												</div>
											</div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<br/>
					<div class="text-center">
						<ul class="pagination justify-content-center">
						    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="memberSearchList?pag=1&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-left"></i></a></li></c:if>
						  	<c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="memberSearchList?pag=${(pageVO.curBlock-1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angle-left"></i></a></li></c:if>
						  	<c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}" varStatus="st">
							    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="memberSearchList?pag=${i}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}">${i}</a></li></c:if>
							    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="memberSearchList?pag=${i}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}">${i}</a></li></c:if>
						  	</c:forEach>
						  	<c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="memberSearchList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  	<c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="memberSearchList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&part=${part}&searchString=${searchString}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>