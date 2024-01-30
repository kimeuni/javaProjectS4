<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- 폰트어썸 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
<style>
	footer{
		background-color: #252525;
		min-height: 150px;
		min-width: 100vW;
	}
	#footer-div{
		max-width: 1024px;
		margin: 0 auto;
	}
	.f-f-d{
		display: flex;
	}
	.f-c-fff{
		color: #fff;
	}
	.f-f-d-7{
		display: flex;
		width: 70%;
		margin: 0 auto;
		justify-content: center;
	}
	.f-f-d-7 a{
		text-decoration: none;
		color: #fff;
	}
	.footer-div hr{
		border: 1px solid #eee;
		margin-top: 0px
	}
	.f-f-d-5{
		display: flex;
		width: 50%;
	}
	.bre1{
		border-right: 1px solid #eee;
	}
</style>
<script>

</script>
<footer>
	<div id="footer-div">
		<div style="width: 100%">
			<div class="f-f-d f-c-fff">
				<div class="f-f-d-7 text-center mt-3 mb-3">
					<div><a href="${ctp}/address">찾아오는 길</a></div> &nbsp;&nbsp;|&nbsp;&nbsp; 
					<div><a href="${ctp}/used/usedMain">중고거래</a></div> &nbsp;&nbsp;|&nbsp;&nbsp;
					<div><a href="${ctp}/community/communityMain">커뮤니티</a></div> &nbsp;&nbsp;|&nbsp;&nbsp;
					<div><a href="${ctp}/board/noticeList">공지사항</a></div> &nbsp;&nbsp;|&nbsp;&nbsp;
					<div><a href="${ctp}/board/FAQList">자주하는 질문</a></div> &nbsp;&nbsp;|&nbsp;&nbsp;
					<div><a href="${ctp}/addressdd">404에러</a></div> &nbsp;&nbsp;|&nbsp;&nbsp;
					<div><a href="${ctp}/address">500에러</a></div> 
				</div>
			</div>
			<hr/>
			<div class="f-f-d pb-4" style="justify-content: center">
				<div class="f-f-d-5 text-center bre1">
					<div style="width: 100%; color: #eee">
						대표이사 : 다모아 | 개인정보보호책임자 : ooo <br/>
			  			사업자등록번호 : 000-00-0000 | 통신판매업신고 : 20xx-서울-0000 <br/>
			  			EMAIL : admin@damoa.kr | FAX : 00-000-000 <br/>
			  			주소: 충청북도 청주시 서원구 사직대로 109 4층
					</div>
				</div>
				<div class="f-f-d-5 text-center" style="color: #eee">
					<div style="width: 100%">
						<div style="font-size: 1.5em;">고객센터</div>
						<div style="margin-top: 10px">9:00~18:00 운영 (주말/공휴일 휴무,점심시간 12시-13시)</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>