<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- 폰트어썸 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
<style>
	footer{
		background-color: #252525;
		height: 150px;
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
	}
</style>
<script>

</script>
<footer>
	<div id="footer-div">
		<div style="width: 100%">
			<div class="f-f-d f-c-fff">
				<div class="f-f-d-7">
					<div><a href="${ctp}/address">찾아오는 길</a></div>
				</div>
			</div>
		</div>
	</div>
</footer>