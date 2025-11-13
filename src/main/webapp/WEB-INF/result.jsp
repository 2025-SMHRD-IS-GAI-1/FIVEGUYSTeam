<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.pro.model.MemberVO" %>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>FIVE GUYS · Menu Translator</title>
<!-- 공통 스타일 -->
<link rel="stylesheet" href="assets/css/result.css">
<!-- 이 페이지 전용 스타일 -->
<link rel="stylesheet" href="assets/css/upload.css">

</head>
<body>
	<c:if test="${info!=null }">
	<script>
	let userId = '<%= (   (MemberVO)session.getAttribute("info")   ).getId() %>';
	</script>
	</c:if>
	<c:if test="${info==null }">
    <script>
	let userId = 'anonymous';
	</script>        
	</c:if>
	<!-- 상단 미니 헤더 (두번째 이미지 톤 맞춤) -->
	<header class="mini-header">
		<div class="mini-inner">
			<div class="mini-logo">
				<img src="${pageContext.request.contextPath}/img/팀로고.png" alt="logo">
				<span>FIVE GUYS · Menu Translator</span>
			</div>
			<nav class="mini-nav">
				 
            <c:if test="${info==null }">
               <a href = "<%=ctx%>/Gologin.do">홈</a>
               <a href = "<%=ctx%>/Gojoin.do">회원가입</a>
               
               
            </c:if>
             <c:if test="${info!=null }">
                 <c:if test="${info.adminYN != 'A'}">
                  <a href="<%=ctx%>/Gomypage.do">마이페이지</a>
                </c:if>
              
               <a href="logout.do">로그아웃</a>
            </c:if> 
                 <!-- 경로 바꿔줘야함!!  -->
			</nav>
		</div>
	</header>

	<!-- 두번째 이미지 같은 레이아웃: 왼쪽(브랜드/일러스트) + 오른쪽(카드형 폼) -->
	<main class="auth-wrap">


		<!-- 우측 카드 -->
		<section class="card-side">
			<div class="card">
				<h2 class="card-title">사진 업로드 & 언어 선택</h2>
				<p class="card-desc">JPG, PNG, WEBP</p>
		<section class="page-title">
			<h1>메뉴판 사진만 올리면 바로 번역</h1>
			<p>업로드 → 언어 선택 → 번역하기, 단 3단계로 끝!</p>
		</section>
					
					<div id="dropzone" class="dropzone"
						data-placeholder="사진 끌어놓기 또는 클릭하여 업로드">
						
    					
    					<canvas id="captureCanvas" style="display: none;"></canvas>
    
						
						
						
						<div id="dropper" class="drop-hint">
							<span class="icon">🖼️</span> <strong>이미지 선택</strong> <small>또는
								드래그 앤 드롭</small>
						</div>
					</div>
					<input id="file" name="menuImage" type="file" accept="image/*">
					<button id="ocrButton" >이미지 처리 (OCR)</button>
  					<button id="saveButton">DB에 저장</button>
					<!-- 언어 선택 -->
					<select id="lang"
						name="targetLang" class="select" required>
						<option value="Korean">한글</option>
					    <option value="English" selected>English</option>
					    <option value="Japanese">日本語</option>
					    <option value="French">Français</option>
					    <option value="中文普通話">中文普通話</option>
					    <option value="中文广东话">中文广东话</option>
					</select>
					<!-- 체크/가이드 라인 -->
					<div class="helper-row">
						<span class="helper">지원 언어 계속 추가 중</span> <span class="helper">원본
							이미지는 서버에 안전하게 보관</span> <span class="helper">번역 결과 저장 및 공유 가능</span>
					</div>

					
					
									
			</div>

		</section>
	</main>
	<!-- 커스텀 모달 HTML -->
  <div id="infoModal" class="modal">
    <div class="modal-content">
      <span class="close-button">&times;</span>
      <div id="modalText"></div>
    </div>
  </div>
	<!-- 추가된 JavaScript: 파일 핸들링 및 캔버스 드로잉 -->
	<script src="assets/js/dropzone.js"></script>
	<script src="assets/js/capture.js"></script>
	
</body>
</html>