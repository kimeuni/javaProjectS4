<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>찾아오시는 길 | ${mapVO.place }</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
    <div class="f-d">
    	<div style="width: 100%">
    		<h2>찾아오는 길</h2>
			<hr/>
			<div id="map" style="width:100%;height:350px;"></div>
    	</div>
    </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=feb7c4c19e6c057416316d3cdb528c05"></script>
	<script>
	 // 주소로 장소표시하기
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(${mapVO.latitude}, ${mapVO.longitude}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

	// 지도를 생성합
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
        var coords = new kakao.maps.LatLng(${mapVO.latitude}, ${mapVO.longitude});

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">${mapVO.place}</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
	</script>
</body>
</html>