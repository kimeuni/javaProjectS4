<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 메인</title>
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
    		width: 90%;
    		margin-top: 80px; 
    		margin-bottom: 20px; 
    	}
    	#admin-main-menu{
    		margin: 0 auto;
    		width : 100%;
    		border: 1px solid;
    		border-radius : 5px;
    		padding: 20px;
    		background-color: #fff;
    		text-align: center;
    		box-shadow: 5px 5px 10px gray;
    	}
    	.f-d{
    		display: flex;
    	}
    	.f-d-4{
    		display: flex;
    		width: 25%
    	}
    	.top-go-btn-container{
    		width: 100%;
    		height: 200px;
    		margin: 30px;
    		margin-top: 0px;
    		margin-bottom: 10px;
    		border-radius: 5px;
    		background-color: #fff;
    	}
    	.f-d5{
    		display: flex;
    		width: 50%;
    	}
    	.visualization{
    		margin: 10px;
    		width : 540px;
    		background-color: #fff;
    		border-radius: 5px;
    	}
    	.piechart{
    		margin: 10px;
    		width : 540px;
    		background-color: #fff;
    		border-radius: 5px;
    	}
    	.text-r{
    		padding-left: 10px;
    		font-size: 1.1em;
    		font-weight: bold;
    		padding-top: 5px;
    		padding-bottom: 5px;
    	}
    	.member-table{
    		height: 600px;
    		background-color: #fff;
    		margin: 15px;
    	}
    	.text-r-a a{
    		text-decoration: none;
    		color: blue;
    	}
    	.text-r-a{
    		margin-left: auto;
    		padding-right: 10px;
    		font-size: 1.1em;
    		font-weight: bold;
    		padding-top: 5px;
    		padding-bottom: 5px;
    		color: blue
    	}
    </style>
    
</head>
<body>
<jsp:include page="/WEB-INF/views/include/adminMenu.jsp" />
	<div id="admin-main-container">
		<div id="admin-main-right-content">
			<div id="top-menu-str">관리자 메인</div>
			<div id="admin-main-right-inner-content">
				<div class="f-d">
					<div class="f-d-4 ">
						<div class="top-go-btn-container">
							ddd
						</div>
					</div>
					<div class="f-d-4">
						<div class="top-go-btn-container">
							ddd
						</div>
					</div>
					<div class="f-d-4">
						<div class="top-go-btn-container">
							ddd
						</div>
					</div>
					<div class="f-d-4">
						<div class="top-go-btn-container">
							ddd
						</div>
					</div>
				</div>
				<div class="f-d">
					<div class="f-d5">
						<div>
						<script type='text/javascript' src='http://www.google.com/jsapi'></script>
						<script type='text/javascript'>google.load('visualization', '1', {'packages': ['geochart']});
						</script >
						<div class="visualization">
							<div class="text-r">지역별 회원 수</div>
							<div id='visualization'></div>
						</div>
							<div class="piechart">
								<div class="text-r">탈퇴 사유</div>
								<div id="piechart" ></div>
							</div>
						</div>
					</div>
					<div class="f-d5">
						<div style="width: 100%">
							<div class="member-table">
							<div class="f-d">
								<div class="text-r">
									회원 정보
								</div>
								<div class="text-r-a">
									<a href="${ctp}/admin/memberList">회원 리스트로 이동</a>
								</div>
							</div>
								<div class="m-4">
									<table class="table table-bordered text-center">
										<tr>
											<th>성명</th>
											<th>닉네임</th>
											<th>이메일</th>
											<th>가일일</th>
										</tr>
										<tr>
											<c:forEach var="memVO" items="${memVOS}">
												<tr>
													<td>${memVO.name }</td>
													<td>${memVO.nickName }</td>
													<td>${memVO.email }</td>
													<td>${fn:substring(memVO.startDate,0,10) }</td>
												</tr>
											</c:forEach>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
   	'use strict'
   	// 지역차트
   	google.setOnLoadCallback(drawVisualization);
					
	function drawVisualization() {
		var data = new google.visualization.DataTable();
	
		data.addColumn('string', 'Country');
		data.addColumn('number', 'Value'); 
		data.addColumn({type:'string', role:'tooltip'});var ivalue = new Array();
		
		data.addRows([[{v:'KR-11', f:'서울'},0,'명']]);
		
		data.addRows([[{v:'KR-26', f:'부산'},1,'명']]);
		
		data.addRows([[{v:'KR-27',f:'대구'},2,'명']]);
		
		data.addRows([[{v:'KR-30',f:'대전'},3,'명']]);
		
		data.addRows([[{v:'KR-29',f:'광주'},4,'명']]);
		
		data.addRows([[{v:'KR-28',f:'인천'},5,'명']]);
		
		data.addRows([[{v:'KR-31',f:'울산'},6,'명']]);
		
		data.addRows([[{v:'KR-43',f:'충청북도'},7,'명']]);
		
		data.addRows([[{v:'KR-44',f:'충청남도'},52,'명']]);
		
		data.addRows([[{v:'KR-42',f:'강원도'},9,'명']]);
		
		data.addRows([[{v:'KR-41',f:'경기도'},10,'명']]);
		
		data.addRows([[{v:'KR-47',f:'경상북도'},11,'명']]);
		
		data.addRows([[{v:'KR-48',f:'경상남도'},12,'명']]);
		
		data.addRows([[{v:'KR-49',f:'제주'},13,'명']]);
		
		data.addRows([[{v:'KR-45',f:'전라북도'},14,'명']]);
		
		data.addRows([[{v:'KR-46',f:'전라남도'},15,'명']]);
	
		var options = {
			legend: 'none',	
			backgroundColor: {fill:'#FFFFFF',stroke:'#FFFFFF' ,strokeWidth:0 },	
			datalessRegionColor: '#f5f5f5',
			displayMode: 'regions', 
			enableRegionInteractivity: 'true', 
			resolution: 'provinces',
			sizeAxis: {minValue: 1, maxValue:1,minSize:10,  maxSize: 10},
			region:'KR', 
			keepAspectRatio: true,
			tooltip: {textStyle: {color: '#444444'}, trigger:'focus'},
	    	colorAxis: {colors: ['#00853f', 'black', '#e31b23']}
		};
		
	  
		var chart = new google.visualization.GeoChart(document.getElementById('visualization')); 
		google.visualization.events.addListener(chart, 'select', function() {
		 	var selection = chart.getSelection();
		 	if (selection.length == 1) {
		 		var selectedRow = selection[0].row;
		 		var selectedRegion = data.getValue(selectedRow, 0);
		 		if(ivalue[selectedRegion] != '') {
		 			document.getElementsByTagName('body')[0].style.background=ivalue[selectedRegion]; 
		 		}
		 	}
		});
		chart.draw(data, options);
	}
   </script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Language', 'Speakers (in millions)'],
          ['German',  5.85],
          ['French',  1.66],
          ['Italian', 0.316],
          ['Romansh', 0.0791]
        ]);

      var options = {
        legend: 'none',
        pieSliceText: 'label',
        pieStartAngle: 100,
      };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
      }
    </script>
</body>
</html>