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
<link href="assets/js/login.js" />
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

				<form method="post" onsubmit="return false;" autocomplete="on">
					<div class="form-row">
						<label for="idOrEmail">아이디</label> <input class="input" id="id"
							name="id" type="text" placeholder="ID" required />
					</div>

					<div class="form-row">
						<label for="pw">비밀번호</label> <input class="input" id="pw"
							name="pw" type="password" placeholder="Password" required />
					</div>

					<!-- 로그인실패 메시지(빨간 글씨) -->
					<c:if test="${not empty errorMsg}">
						<p class="error-msg">
							<c:out value="${errorMsg}" />
						</p>
					</c:if>

					<div class="row-between">
						<label class="checkbox"> <input type="checkbox"
							name="autoLogin" value="Y" /> 자동 로그인
						</label> <a class="link"
							href="${pageContext.request.contextPath}/Gopw_find.do">비밀번호
							찾기</a>
					</div>

					<button class="btn btn-primary" type="submit" id="login" onclick="">로그인
						➜</button>

					<div class="form-row">
						<button class="btn btn-outline" type="button"
							onclick="location.href='Gojoin.do'">회원가입</button>
					</div>

					<div class="or">또는</div>

					<button class="btn btn-ghost" type="button"
						onclick="location.href='Goresult.do'">게스트로 계속하기</button>
				</form>

				<div class="footer">
					© 2025 FIVE GUYS. All rights reserved.
					<div class="legal">
						<a class="link" href="#" id="openTermsLink">이용약관</a> <a
							class="link" href="${ctx}/privacy.do">개인정보</a> <a class="link"
							href="${ctx}/contact.do">문의</a>
					</div>
				</div>
			</div>
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
	<!-- 20251103 cyonn -->


</body>
<script>

let login = document.getElementById("login");
let url = "login.do";
login.addEventListener("click", () => {
	let id = document.getElementById("id").value;
	let pw = document.getElementById("pw").value;
	fetch("login.do", {
	    method: "POST",
	    headers: { "Content-Type": "application/x-www-form-urlencoded" },
	    body: new URLSearchParams({id,pw})
    })
		.then(function(res) {
			// console.log("받아온 데이터 >> ", res);
			return res.json();
		})
		.then(function(result) {
			if(result.result =="admin"){
				console.log("나관리자다");
				location.href="Goadmin.do";
			}
			else if (result.result == "false") {
				alert("다시 확인해주세요");
			}
			else {
				location.href = "Goresult.do";
			}

		})
		.catch(function(err) {
			console.error(err);
		})
});

</script>

</html>
