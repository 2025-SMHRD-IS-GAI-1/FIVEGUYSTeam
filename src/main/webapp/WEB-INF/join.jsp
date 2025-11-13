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
			<a href="<%=ctx%>/Gologin.do" class="mini-nav">로그인</a> 
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

						<!-- 아이디 
						<div class="form-row" id="check">
							<label for="userid" class="link">아이디</label> <input id="userid"
								name="id" type="text" class="input" placeholder="ID를 입력하세요."
								required />
						</div> -->
					<div class="form-row">
    				<label for="userid" class="link">아이디</label>
    				<input id="userid" name="id" type="text" class="input" placeholder="ID를 입력하세요." required />
    				<div id="check" class="hint" style="font-size:14px; margin-top:4px;"></div> <!-- ✅ 메시지 표시 위치 -->
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
						<div class="form-row" >
							<label for="pw2" class="link">비밀번호 확인</label> <input id="pw2"
								name="pw2" type="password" class="input"
								placeholder="Password 확인" minlength="8" required />
							<button id="checkpw" type="button" class="btn-mini">일치여부</button>	
							<div id="pwMsg" class="hint mini-hint"></div> 
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
							<button type="submit" id="joinBtn"  class="btn btn-primary join-btn col-span-2" disabled>회원가입 완료</button>
						</div>
						<div class="btn-right">
							<a href="<%=ctx%>/Gologin.do" class="btn btn-ghost"
								style="display: inline-block; text-align: center;">돌아가기</a>
						</div>
					</div>
				</form>
			</div>

			<div class="footer" style="margin-top: 16px;">
				© 2025 FIVE GUYS. All rights reserved.
				<div class="legal">
					<a class="link" href="#" id="openTermsLink">이용약관</a>
					<a class="link" href="<%=ctx%>/policy/privacy.jsp">개인정보</a>
					<a class="link" href="<%=ctx%>/policy/help.jsp">문의</a>
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
	</div><!--  이용약관 끝 -->
	<script src="assets/js/terms.js" ></script> <!-- 20251104 cyonn -->
	<script>
	  	let userid = document.getElementById("userid")
	  	const check = document.getElementById("check")
	  	let joinBtn = document.getElementById("joinBtn"); 
	  	let idTimer = null;
	  	let idOk = false;
	  	let pwOk = false;
	  	
	  	// 버튼 활성화 함수 
	  	function updateBtn() {
    	const canJoin = idOk && pwOk;     // 둘 다 true여야 가입 가능
    	joinBtn.disabled = !canJoin;

   		if (canJoin) {
     	 joinBtn.classList.add("active");
    	} else {
      	joinBtn.classList.remove("active");
   	 	}
 		}
		
		userid.addEventListener("input",()=>{
			 const id = userid.value.trim();
				
				 if (idTimer) {
				    clearTimeout(idTimer);
				  }	
			    if(!id){ 
			        check.textContent = ""; 
			        idOk = false;          
			        updateBtn();
			        return; 
			    }
			    idTimer = setTimeout(() => {
			    fetch("check.do", {
				    method: "POST",
				    headers: { "Content-Type": "application/x-www-form-urlencoded" },
				    body: new URLSearchParams({id})
			    })
			    .then(res => res.json())
			    .then(result => {

			    	// 아이디가 중복일때
			        if(result.result === "true"){
			            check.textContent = "중복된 아이디입니다.";
			            check.style.color = "red";
			           	idOk= false; // 비활성화
			        
			        // 아이디가 중복이 아닐때
			        } else { 
			            check.textContent = "사용가능한 아이디입니다.";
			            idOk= true; // id는 OK
			            check.style.color = "green";
			        }
			        updateBtn();  // pwOK가 false이므로 비활성화
			    })
			    .catch(err => {
			        console.error(err);
			        check.textContent = "확인 중 오류 발생";
			        check.style.color = "red";
			        idOk = false;
			        updateBtn();
			    });
			    },300);
			});
			
		const Pw = document.getElementById("pw");  
		const Pw2 = document.getElementById("pw2");
		const checkpw = document.getElementById("checkpw")
		const pwMsg   = document.getElementById("pwMsg"); 
		/* const joinBtn = document.getElementById("joinBtn"); */
		
	
		
		function showPwMsg(text, color) {
				  pwMsg.textContent = text;
				  pwMsg.style.color = color;
				}

		
		
				checkpw.addEventListener("click", () => {
				  // e.preventDefault(); // type="button" 사용하면 불필요
				  const pw  = Pw.value.trim();  // 비번
				  const pw2 = Pw2.value.trim();  // 비번 확인

				  if (pw.length < 8) {
				    showPwMsg("비밀번호는 8자 이상이어야 합니다.", "red");
				    pwOk = false; // pw 비활
				    updateBtn();
				    return;
				  }
				  if (pw !== pw2) {
				    showPwMsg("비밀번호가 일치하지 않습니다.", "red");
				    pwOk = false;  // pw 비활
   					 updateBtn();
				    return;
				  }
				  showPwMsg("사용 가능한 비밀번호입니다.", "green");
				  pwOk=true;  // pw OK
				  updateBtn();
				  
				});
				 // 6. 사용자가 다시 입력을 바꿨을 때는 다시 꺼주기
				  Pw.addEventListener("input", () => {
				    pwOk = false;
				    updateBtn();
				  });
				  Pw2.addEventListener("input", () => {
				    pwOk = false;
				    updateBtn();
				  });

				  // 7. 시작할 때 한 번 꺼두기
				  updateBtn();

				
	
				
				
				
		
				
	</script>
</body>
</html>
