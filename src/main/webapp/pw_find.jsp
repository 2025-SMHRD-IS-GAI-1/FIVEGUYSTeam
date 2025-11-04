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
</head>
<body>
	<div class="wrap">
		<!-- 상단 브랜드 -->
		<div class="brand">
			<img src="${pageContext.request.contextPath}/img/팀로고.png" alt="FIVE GUYS" />
			<div class="t">FIVE GUYS - Menu Translator</div>
			<a class="link small" href="<%=ctx%>/login.jsp"
				style="margin-left: auto;">홈</a>
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
			<form method="post" action="<%=ctx%>/findPassword.do" id="findForm"
				autocomplete="on">
				<div class="grid">
					<div class="form-row">
						<label for="uid" class="label">아이디</label> <input id="uid"
							name="id" type="text" class="input" placeholder="ID (선택)" />
					</div>

					<div class="form-row">
						<label for="uemail" class="label">이메일</label> <input id="uemail"
							name="email" type="email" class="input"
							placeholder="email@example.com (선택)" />
					</div>
				</div>
				<script>
					let uid = document.getElementById("uid");
					let uemail = document.getElementById("uemail");
					
					uemail.addEventListener("input", ()=>{
						fetch("CheckEmail.do?email="+email.value)
						.then(function(res){
							//console.log(res);
							return res.json();
							
						})
						.then(function(data){
							console.log(data);
							let check = document.getElementById("check");
							if(document.getElementById("pid")!=null)
								check.removeChild(document.getElementById("pid"));
							let p = document.createElement("p");
							p.setAttribute("id", "pid");
							//if(data.email !=null){
							if(data.checkok == "ok"){
								//console.log("ok");
								p.innerText = "email을 정확하게 입력하셨습니다.";
								p.style.color = "#00ff00";
								send.disabled = false;
							}else{
								//console.log("not ok");
								p.innerText = "해당하는 email을 찾을 수 없습니다.";
								p.style.color = "#ff0000";
								send.disabled = true;
							}
							
							check.appendChild(p);
						})
						.catch(function(err){
							console.error(err);
						});
						
					});
				</script>
				<p class="hint">
					아이디와 이메일 <b>둘다</b> 입력해야 됩니다.
				</p>
				<br>
				<p class="hint">
					자동생성 방지를 위한 확인절차입니다.
				</p>
				<div class="row">
					<button type="submit" class="btn btn-primary">임시 비밀번호 보내기</button>
					<a class="btn btn-ghost" href="<%=ctx%>/login.jsp">돌아가기</a>
				</div>
			</form>

			<footer class="footer">
				© 2025 FIVE GUYS. All rights reserved.
				<div class="legal">
					<a class="link" href="<%=ctx%>/policy/terms.jsp">이용약관</a> <a
						class="link" href="<%=ctx%>/policy/privacy.jsp">개인정보</a> <a
						class="link" href="<%=ctx%>/policy/help.jsp">문의</a>
				</div>
			</footer>
		</div>
	</div>


</body>
</html>
