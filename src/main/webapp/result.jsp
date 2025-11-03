<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<!-- 상단 중앙 타이틀 -->
	<section class="page-title">
		<h1>메뉴판 사진만 올리면 바로 번역</h1>
		<p>업로드 → 언어 선택 → 번역하기, 단 3단계로 끝!</p>
	</section>
	<!-- 상단 미니 헤더 (두번째 이미지 톤 맞춤) -->
	<header class="mini-header">
		<div class="mini-inner">
			<div class="mini-logo">
				<img src="${pageContext.request.contextPath}/img/팀로고.png" alt="logo">
				<span>FIVE GUYS · Menu Translator</span>
			</div>
			<nav class="mini-nav">
				<a href="<%=ctx%>/home.jsp">홈</a> <a class="primary-outline"
					href="<%=ctx%>/join.jsp">회원가입</a>
			</nav>
		</div>
	</header>

	<!-- 두번째 이미지 같은 레이아웃: 왼쪽(브랜드/일러스트) + 오른쪽(카드형 폼) -->
	<main class="auth-wrap">


		<!-- 우측 카드 -->
		<section class="card-side">
			<div class="card">
				<h2 class="card-title">사진 업로드 & 언어 선택</h2>
				<p class="card-desc">JPG, PNG, HEIC / 최대 10MB</p>

				<!-- 드롭존 -->
				<form action="<%=ctx%>/translate.do" method="post"
					enctype="multipart/form-data" class="form">
					<div id="dropzone" class="dropzone"
						data-placeholder="사진 끌어놓기 또는 클릭하여 업로드">
						<input id="file" name="menuImage" type="file" accept="image/*"
							required>
						<div class="drop-hint">
							<span class="icon">🖼️</span> <strong>이미지 선택</strong> <small>또는
								드래그 앤 드롭</small>
						</div>
					</div>

					<!-- 언어 선택 -->
					<label class="label" for="lang">번역할 언어</label> <select id="lang"
						name="targetLang" class="select" required>
						<option value="" selected disabled>예: 영어, 일본어, 중국어…</option>
						<option value="en">영어 (English)</option>
					</select>

					<!-- 체크/가이드 라인 -->
					<div class="helper-row">
						<span class="helper">지원 언어 계속 추가 중</span> <span class="helper">원본
							이미지는 서버에 안전하게 보관</span> <span class="helper">번역 결과 저장 및 공유 가능</span>
					</div>

					<!-- 버튼 -->
					<button type="submit" class="btn-primary">번역하기 ➜</button>
				</form>
			</div>

			<!-- 푸터 라인 -->
			<footer class="legal">
				<span>© 2025 FIVE GUYS. All rights reserved.</span> <a href="#">이용약관</a>
				<a href="#">개인정보</a> <a href="#">문의</a>
			</footer>
		</section>
	</main>
</body>
</html>