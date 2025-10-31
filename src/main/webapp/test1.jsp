<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>FIVE GUYS - Menu Translator</title>
<link rel="stylesheet" href="assets/css/login.css" />
</head>
<body>
	<div class="wrap">
		<div class="brand">
			<!-- 작은 파비콘/로고 -->
			<img src="${pageContext.request.contextPath}/img/팀로고.png"
				alt="FIVE GUYS" />
			<div class="t">FIVE GUYS - Menu Translator</div>
		</div>

		<div class="card">
			<!-- 좌측: 로고/설명 -->
			<div class="left">
				<img class="logo"
					src="${pageContext.request.contextPath}/img/팀로고.png"
					alt="FIVE GUYS Logo" />
				<div class="caption">다국어 메뉴판 번역 서비스</div>
			</div>

			<!-- 우측: 로그인 폼 -->
			<div class="right">
				<h2>계정에 접속하여 번역을 시작하세요</h2>

				<!-- 에러 메시지(컨트롤러에서 request.setAttribute("msg","...") 로 전달) -->
				<c:if test="${not empty msg}">
					<div
						style="background: #fef2f2; border: 1px solid #fecaca; color: #b91c1c; padding: 10px 12px; border-radius: 10px; margin: 10px 0;">
						${msg}</div>
				</c:if>

				<form method="post" action="${ctx}/login.do" autocomplete="on">
					<div class="form-row">
						<label for="idOrEmail">아이디</label> <input class="input"
							id="idOrEmail" name="idOrEmail" type="text"
							placeholder="ID 또는 이메일" required />
					</div>

					<div class="form-row">
						<label for="pw">비밀번호</label> <input class="input" id="pw"
							name="pw" type="password" placeholder="Password" required />
					</div>

					<div class="row-between">
						<label class="checkbox"> <input type="checkbox"
							name="autoLogin" value="Y" /> 자동 로그인
						</label> <a class="link" href="${ctx}/findPw.do">비밀번호 찾기</a>
					</div>

					<button class="btn btn-primary" type="submit">로그인 ➜</button>

					<div class="form-row">
						<button class="btn btn-outline" type="button"
							onclick="location.href='${ctx}/join.do'">회원가입</button>
					</div>

					<div class="or">또는1</div>

					<button class="btn btn-ghost" type="button"
						onclick="location.href='${ctx}/guest.do'">게스트로 계속하기</button>
				</form>

				<div class="footer">
					© 2025 FIVE GUYS. All rights reserved.
					<div class="legal">
						<a class="link" href="${ctx}/terms.do">이용약관</a> <a class="link"
							href="${ctx}/privacy.do">개인정보</a> <a class="link"
							href="${ctx}/contact.do">문의</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
