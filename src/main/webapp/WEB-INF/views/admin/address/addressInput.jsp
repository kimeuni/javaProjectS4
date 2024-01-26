<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>찾아오는 길 등록</title>
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
    		margin-top: 80px; 
    		margin-bottom: 20px; 
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
    	.f-d{
    		display: flex;
    	}
    </style>
    <script>
    	'use strict'
    	
    	function addressSave(latitude,longitude){
    		let place = $("#place").val();
    		let address = $("#address").val();
    		
    		if(place.trim() == ""){
    			alert("장소명을 입력하세요.")
    			$("#place").focus();
	    		return false;
    		}
    		else if(address.trim() == ""){
    			alert("주소를 입력하세요.")
    			$("#address").focus();
	    		return false;
    		}
    		else{
    			let query = {
   					place : place,
   	   				address : address,
   	   				latitude : latitude,
   	   				longitude : longitude
   	    		}
   	    		
   	    		$.ajax({
   	    			url : "${ctp}/admin/addressInput",
   	    			type : "post",
   	    			data : query,
   	    			success : function(res){
   	    				if(res == "1"){
   	    					alert("선택한 지점이 찾아오는 길에 등록되었습니다.")
   	    					location.reload();
   	    				}
   	    				else {
   	    					alert("찾아오는 길 등록에 실패하였습니다.")
   	    				}
   	    			},
   	    			error : function(){
   	    				alert("전송 오류(addressInput.jsp)")
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
			<div id="top-menu-str">찾아오는 길 등록</div>
			<div id="admin-main-right-inner-content">
				<div id="admin-main-menu">
					<div id="admin-main-menu-str">찾아오는 길 등록 <i class="fa-solid fa-file-pen"></i></div>
					<div class="f-d">
						<div style="width: 100%">
							<h2>클릭한 지점에 마커를 표시하여 찾오는 길 등록</h2>
							<hr/>
							<div id="map" style="width:100%;height:350px;"></div>
							<p><b>지도의 위치를 클릭하여 찾아오는 길을 등록해주세요. </b></p>
							<c:if test="${mapVO != null }">
								<div class="f-d">
									<div style="width: 100%">
										<div>현재 위치한 위도 : ${mapVO.latitude }</div>
										<div>현재 위치한 경도 : ${mapVO.longitude }</div>
										<div>현재 등록된 장소명 : ${mapVO.place }</div>
										<div>현재 등록된 주소 : ${mapVO.address }</div>
									</div>
								</div>
							</c:if>
							<div id="clickLatlng"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb7c4c19e6c057416316d3cdb528c05"></script>
	<script>
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(36.635101862975255, 127.45949880590659), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	var marker = new kakao.maps.Marker({ 
	    position: map.getCenter() 
	}); 
	marker.setMap(map);
	
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    message += '<input type="button" value="처음위치로복귀" onclick="location.reload()"; /> <br/>';
	    message += '<p>선택한 지점의 장소명 : <input type="text" name="place" id="place" /></p>';
	    message += '<p>선택한 지점의 주소 : <input type="text" name="address" id="address" /></p>';
	    message += '<p><input type="button" value="장소저장" onclick="addressSave('+ latlng.getLat() +', '+ latlng.getLng() +')" class="btn btn-success btn-sm" /></p>';
	    message += '';
	    message += '';
	    
	    var resultDiv = document.getElementById('clickLatlng'); 
	    resultDiv.innerHTML = message;
	    
	});
	</script>
</body>
</html>