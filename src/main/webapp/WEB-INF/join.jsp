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
<title>FIVE GUYS - 회원가입</title>
<link rel="stylesheet" href="assets/css/join.css" />
</head>
<body>
	<div class="wrap">
		<!-- 상단 브랜드 바는 심플하게 -->
		<div class="brand">
			<img src="${pageContext.request.contextPath}/img/팀로고.png">
			<div class="t">FIVE GUYS - Menu Translator</div>
			<div style="margin-left: auto; display: flex; gap: 8px;">
				<a class="link" href="<%=ctx%>/login.do">로그인</a> <a class="link"
					href="<%=ctx%>/index.jsp">홈</a>
			</div>
		</div>

		<!-- 단일 카드 -->
		<div class="card--single">
			<h2 class="page-title">회원가입</h2>

			<div class="inner-panel">
				<form method="post" action="<%=ctx%>/join.do" autocomplete="off">
					<div class="form-grid">
						<!-- 왼쪽: 계정정보 / 오른쪽: 기본정보 -->
						<div class="section-title">계정 정보</div>
						<div class="section-title">기본 정보</div>

						<!-- 아이디 -->
						<div class="form-row">
							<label for="userid" class="link">아이디</label> <input id="userid"
								name="id" type="text" class="input" placeholder="ID를 입력하세요."
								required />
						</div>

						<!-- 이름 -->
						<div class="form-row">
							<label for="username" class="link">이름</label> <input
								id="username" name="name" type="text" class="input"
								placeholder="홍길동" required />
						</div>

						<!-- 비밀번호 -->
						<div class="form-row">
							<label for="pw" class="link">비밀번호</label> <input id="pw"
								name="pw" type="password" class="input"
								placeholder="영문/숫자/특수문자 8자 이상" minlength="8" required />
						</div>

						<!-- 이메일 -->
						<div class="form-row">
							<label for="email" class="link">이메일</label> <input id="email"
								name="email" type="email" class="input"
								placeholder="email@example.com" required />
						</div>

						<!-- 비밀번호 확인 -->
						<div class="form-row">
							<label for="pw2" class="link">비밀번호 확인</label> <input id="pw2"
								name="pw2" type="password" class="input"
								placeholder="Password 확인" minlength="8" required />
						</div>

						<!-- 선호 언어 -->
						<div class="form-row">
							<label for="lang" class="link">선호 언어</label> <select id="lang"
								name="prefLang" class="input">
								<option value="ko">한국어</option>
								<option value="en">English</option>
								<option value="ja">日本語</option>
								<option value="zh">中文</option>
							</select>
						</div>

						<!-- 버튼: 좌/우 열에 배치 -->
						<div class="btn-left">
							<button type="submit" class="btn btn-primary">회원가입 완료</button>
						</div>
						<div class="btn-right">
							<a href="<%=ctx%>/login.jsp" class="btn btn-ghost"
								style="display: inline-block; text-align: center;">돌아가기</a>
						</div>
					</div>
				</form>
			</div>

			<div class="footer" style="margin-top: 16px;">
				© 2025 FIVE GUYS. All rights reserved.
				<div class="legal">
					<a class="link" href="<%=ctx%>/policy/terms.jsp">이용약관</a> <a
						class="link" href="<%=ctx%>/policy/privacy.jsp">개인정보</a> <a
						class="link" href="<%=ctx%>/policy/help.jsp">문의</a>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
