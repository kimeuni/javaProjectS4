<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	#profile-img-div{
		display: flex;
		width: 30%;
		border-right: 1px solid #ccc;
		text-align: center;
		padding: 20px;
	}
	#profile-img-div img{
		border-radius: 100%;
		width: 315px;
		height: 315px;
	}
	#user-store-soge-div{
		display: flex;
		width: 70%;
		padding: 25px;
	}
	.f-d{
		display: flex;
	}
	#f-nick{
		display : flex;
		margin-top: 10px;
		font-size: 2em;
		font-weight: bold;
	}
	.f-follow{
		display : flex;
		margin-left: auto;
		line-height: 55px;
		text-align: center;
	}
	.f-follow a{
		padding-right: 15px;
		border: 1px solid;
		width: 150px;
		height: 40px;
		line-height: 40px;
		margin-top: 10px;
		text-decoration: none;
		color: #000;
	}
	.store-info-str{
		padding-right: 20px;
	}
	#f-follow-alarm{
		display : flex;
		line-height: 55px;
		padding-left: 20px;
		text-align: center;
	}
	#f-follow-alarm a{
		width: 40px;
		height: 40px;
		line-height : 40px;
		border: 1px solid;
		text-decoration: none;
		color: #000;
		margin: 10px;
	}
	.f-alarm-ok{
		background-color: #faf1f2;
		color: red !important;
		border: 1px solid red !important;
	}
	#store-soge-update, #store-soge-update-ok{
		border: 1px solid;
		width: 120px;
		height: 35px;
		line-height : 35px;
		margin-bottom: 10px;
		text-align: center;
	}
	#store-soge-update-ok{
		background-color: #EBDDCC;
	}
	#store-soge-update a, #store-soge-update-ok a{
		text-decoration: none;
		color: #000;
	}
	.show-store-soge-div-m{
		width: 789px;
		height: 94px;
		overflow: auto;
	}
	.show-store-soge-div{
		width: 789px;
		height: 130px;
		overflow: auto;
	}
	#store-soge{
		resize: none;
	}
</style>
<script>
	'use strict'
	
	$(function(){
		$(".input-store-div").hide();
		$("#store-soge-update-ok").hide();
	});
	
	// 수정 화면 보이기
	function storeUpdateShow(){
		$(".show-store-soge-div").hide();
		$(".show-store-soge-div-m").hide();
		$(".input-store-div").show();
		$("#store-soge-update-ok").show();
		$("#store-soge-update").hide();
	}
	
	// 상점 소개 수정하기
	function storeUpdate(mid){
		let storeIntroduce = $("#store-soge").val();
		let query = {
			storeIntroduce : storeIntroduce,
			mid : mid
		}
		$.ajax({
			url : "${ctp}/used/StoreSogeUpdate",
			type : "post",
			data : query,
			success : function(res){
				if(res == "1") location.reload();
				else if(res == "2") alert("상점 소개 저장에 실패하였습니다.");
			},
			error : function(){
				alert("전송오류(usedStoreSoge.jsp)")
			}
		});
	}
	
	// 해당 상점 알림 N
	function fAlarmNo(sMid,followingMid){
		let query = {
			sMid : sMid,
			followingMid : followingMid,
			flag : 'N'
		}
		$.ajax({
			url : "${ctp}/used/followAlarmYN",
			type : "post",
			data : query,
			success : function(res){
				if(res == "1") location.reload();
				else if(res == "2") alert("알림 끄기에 실패하였습니다.")
			},
			error : function(){
				alert("전송오류(usedStoreSoge.jsp)")
			}
		});
	}
	
	// 해당 상점 알림 Y
	function fAlarmYes(sMid,followingMid){
		let query = {
			sMid : sMid,
			followingMid : followingMid,
			flag : 'Y'
		}
		$.ajax({
			url : "${ctp}/used/followAlarmYN",
			type : "post",
			data : query,
			success : function(res){
				if(res == "1") location.reload();
				else if(res == "2") alert("알림 켜기에 실패하였습니다.")
			},
			error : function(){
				alert("전송오류(usedStoreSoge.jsp)")
			}
		});
	}
	
	// 팔로우 취소
	function followNo(followingMid){
		let query = {
				followerMid : '${sMid}',
				followingMid : followingMid,
				flag : "No"
		}
		$.ajax({
			url : "${ctp}/used/usedFollow",
			type : "post",
			data : query,
			success : function(res){
				if(res == "1") location.reload();
				else if(res == "2") alert("팔로우 취소에 실패하였습니다.");
			},
			error : function(){
				alert("전송오류(usedContent.jsp)");
			}
		});
	}
	
	// 팔로우 하기
	function followYes(followingMid){
		let query = {
				followerMid : '${sMid}',
				followingMid : followingMid,
				flag : "Yes"
		}
		$.ajax({
			url : "${ctp}/used/usedFollow",
			type : "post",
			data : query,
			success : function(res){
				if(res == "1") location.reload();
				else if(res == "2") alert("팔로우에 실패하였습니다.");
			},
			error : function(){
				alert("전송오류(usedContent.jsp)");
			}
		});
	}
</script>
<div id="profile-img-div">
	<img src="${ctp}/data/member/${memVO.profile}"/>
</div>
<div id="user-store-soge-div">
	<div style="width: 100%">
		<div class="f-d">
			<div id="f-nick">${memVO.nickName}</div>
			<c:if test="${sMid != memVO.mid && sMid != null}">
				<c:if test="${empty fVO }">
					<div class="f-follow"><a href="javascript:followYes('${memVO.mid}')"><i class="fa-solid fa-user-plus"></i> 팔로우</a></div>
				</c:if>
				<c:if test="${!empty fVO }">
					<div id="f-follow-alarm">
						<c:if test="${fVO.alarm == 'Y' }">
							<a href="javascript:fAlarmNo('${sMid}','${memVO.mid}')" class="f-alarm-ok"><div><i class="fa-regular fa-bell-slash"></i></div></a>
						</c:if>
						<c:if test="${fVO.alarm != 'Y' }">
							<a href="javascript:fAlarmYes('${sMid}','${memVO.mid}')"><div><i class="fa-solid fa-bell"></i></div></a>
						</c:if>
					</div>
					<div class="f-follow"><a href="javascript:followNo('${memVO.mid}')"><i class="fa-solid fa-user-check"></i> 팔로잉</a></div>
				</c:if>
			</c:if>
		</div>
		<hr/>
			<div class="f-d">
				<div class="store-info-str"><i class="fa-solid fa-store"></i> 상점 오픈일 ${memVO.start_date_diff }일전</div>
				<div class="store-info-str"><i class="fa-solid fa-bag-shopping"></i> 상품 ${usedCnt }개</div>
				<c:if test="${sMid == memVO.mid }">
					<div class="store-info-str"><i class="fa-solid fa-heart"></i> 찜 ${likeCnt}개</div>
				</c:if>
				<div class="store-info-str"><i class="fa-solid fa-user-plus"></i> 팔로워 ${ferCnt }명</div>
			</div>
		<hr/>
		<div class="f-d">
			<div style="width: 100%">
				<c:if test="${sMid == memVO.mid }">
					<div id="store-soge-update"><a href="javascript:storeUpdateShow()">상점소개 수정</a></div>
					<div id="store-soge-update-ok"><a href="javascript:storeUpdate('${stVO.mid }')">상점소개 저장</a></div>
				</c:if>
				<c:if test="${sMid == memVO.mid }">
					<div class="show-store-soge-div-m">${stVO.storeIntroduce }</div>
				</c:if>
				<c:if test="${sMid != memVO.mid || empty sMid }">
					<div class="show-store-soge-div">${stVO.storeIntroduce }</div>
				</c:if>
				<div class="input-store-div">
					<textarea rows="4" style="width: 100%" id="store-soge">${stVO.storeIntroduce }</textarea>
				</div>
			</div>
		</div>
	</div>
</div>