<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String ctx = request.getContextPath(); // 컨텍스트 경로
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 찾기 - FIVE GUYS</title>
<link rel="stylesheet" href="assets/css/pw_find.css">
<script src="assets/js/pw_find.js"></script>
</head>
<body>
	<div class="wrap">
		<!-- 상단 브랜드 -->
		<div class="brand">
			<img src="${pageContext.request.contextPath}/img/팀로고.png"
				alt="FIVE GUYS" />
			<div class="t">FIVE GUYS - Menu Translator</div>

		</div>

		<!-- 카드 -->
		<div class="card">
			<h2>비밀번호 찾기</h2>

			<!-- 안내문 / 결과메시지 -->
			<p class="desc">
				가입하신 <b>아이디 & 이메일</b>을 입력하면, 임시 비밀번호(또는 재설정 링크)를 보내드려요.
			</p>

			<!-- 서버에서 보낸 결과 메시지 -->
			<c:if test="${not empty errorMsg}">
				<p class="msg error">
					<c:out value="${errorMsg}" />
				</p>
			</c:if>
			<c:if test="${not empty infoMsg}">
				<p class="msg success">
					<c:out value="${infoMsg}" />
				</p>
			</c:if>

			<!-- 폼 -->
			<form method="post" action="<%=ctx%>/FindPassword.do" id="findForm"
				autocomplete="on">
				<div class="grid">
					<div class="form-row">
						<label for="uid" class="label">아이디</label> <input id="uid"
							name="id" type="text" class="input" placeholder="ID"
							required />
					</div>

					<div class="form-row">
						<label for="uemail" class="label">이메일</label> <input id="uemail"
							name="email" type="email" class="input"
							placeholder="email@example.com" required />
					</div>
				</div>

				<p class="hint">
					아이디와 이메일 <b>둘다</b> 입력해야 됩니다.
				</p>
				<br>
				<p class="hint">자동생성 방지를 위한 확인절차입니다.</p>
				<div id="humancheck">
					<div id="checkquestion" style="visibility: hidden;"></div>
					<input id="checkanswer" style="visibility: hidden;"
						oninput="calc_check()" />
				</div>

				<div class="row">
					<button id="send" type="submit" class="btn btn-primary">임시
						비밀번호 보내기(비활성)</button>
					<a class="btn btn-ghost" href="<%=ctx%>/Gologin.do">돌아가기</a>
				</div>

				<script>
					
				</script>
			</form>

			<!-- footer -->
			<div class="footer">
				© 2025 FIVE GUYS. All rights reserved.
				<div class="legal">
					<a href="#"
						onclick="document.getElementById('termsModal').style.display='flex';return false;">이용약관</a>
					<a href="#">개인정보</a> <a href="#">문의</a>
				</div>
			</div>

			<!-- 이용약관은 모든 div의 제일 아래에 넣고 스타일로 감춘 후 클릭하면 노출되도록 한다. -->
			<div id="termsModal" class="modal-overlay">
				<div class="modal-content">
					<span class="close-btn">&times;</span>
					<h2>이용약관</h2>
					<div id="rules_text"></div>
				</div>
			</div>
			<!--  이용약관 끝 -->
			<script src="assets/js/terms.js"></script>
			<!-- 20251104 cyonn -->
</body>
</html>
