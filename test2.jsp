<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>FIVE GUYS - Menu Translator</title>
<style>
  :root{
    --bg:#f5f6fb; --card:#ffffff; --text:#1f2937; --sub:#6b7280;
    --primary:#6366f1; --primary-d:#4f46e5; --border:#e5e7eb;
  }
  *{box-sizing:border-box}
  body{margin:0;background:var(--bg);font-family:ui-sans-serif,system-ui,Segoe UI,Apple SD Gothic Neo,Roboto,AppleGothic,sans-serif;color:var(--text)}
  .wrap{max-width:1024px;margin:32px auto;padding:0 16px}
  .brand{display:flex;align-items:center;gap:10px;margin-bottom:16px}
  .brand img{width:28px;height:28px;border-radius:6px}
  .brand .t{font-weight:700}
  .card{display:grid;grid-template-columns:1.1fr 1fr;gap:0;background:var(--card);border:1px solid var(--border);
        border-radius:14px;box-shadow:0 6px 20px rgba(0,0,0,.06);overflow:hidden}
  .left{padding:36px 40px;border-right:1px solid var(--border);display:flex;justify-content:center;align-items:center;flex-direction:column}
  .left .logo{width:70%;max-width:380px;aspect-ratio:1/1;object-fit:contain;display:block;margin:0 auto 16px auto}
  .left .caption{color:var(--sub);font-size:14px;text-align:center;margin-top:8px}
  .right{padding:36px 40px}
  h2{margin:0 0 12px 0;font-size:20px}
  .form-row{display:flex;flex-direction:column;gap:8px;margin:14px 0}
  .input{width:100%;padding:12px 14px;border:1px solid var(--border);border-radius:10px;font-size:14px;outline:none;background:#fff}
  .input:focus{border-color:var(--primary);box-shadow:0 0 0 3px rgba(99,102,241,.15)}
  .row-between{display:flex;align-items:center;justify-content:space-between;margin:8px 0 16px 0}
  .checkbox{display:flex;align-items:center;gap:8px;color:var(--sub);font-size:14px}
  .link{font-size:14px;color:var(--sub);text-decoration:none}
  .link:hover{color:var(--text)}
  .btn{width:100%;padding:12px 14px;border-radius:10px;border:1px solid transparent;font-weight:700;font-size:15px;cursor:pointer}
  .btn-primary{background:var(--primary);color:#fff}
  .btn-primary:hover{background:var(--primary-d)}
  .btn-outline{background:#fff;border-color:var(--primary);color:var(--primary)}
  .btn-outline:hover{background:#eef2ff}
  .btn-ghost{background:#fff;border:1px solid var(--border);color:var(--text)}
  .btn-ghost:hover{background:#f9fafb}
  .or{display:flex;align-items:center;gap:12px;color:var(--sub);font-size:13px;margin:16px 0}
  .or:before,.or:after{content:"";flex:1;height:1px;background:var(--border)}
  .footer{margin-top:18px;text-align:center;color:var(--sub);font-size:12px}
  .legal{display:flex;gap:12px;justify-content:center;margin-top:8px}
  @media (max-width:900px){.card{grid-template-columns:1fr}.left{border-right:none;border-bottom:1px solid var(--border)}}
</style>
</head>
<body>
  <div class="wrap">
    <div class="brand">
      <!-- 작은 파비콘/로고 -->
      <img src="${pageContext.request.contextPath}/img/팀로고.png" alt="FIVE GUYS" />
      <div class="t">FIVE GUYS - Menu Translator</div>
    </div>

    <div class="card">
      <!-- 좌측: 로고/설명 -->
      <div class="left">
        <img class="logo" src="${pageContext.request.contextPath}/img/팀로고.png" alt="FIVE GUYS Logo" />
        <div class="caption">다국어 메뉴판 번역 서비스</div>
      </div>

      <!-- 우측: 로그인 폼 -->
      <div class="right">
        <h2>계정에 접속하여 번역을 시작하세요</h2>

        <!-- 에러 메시지(컨트롤러에서 request.setAttribute("msg","...") 로 전달) -->
        <c:if test="${not empty msg}">
          <div style="background:#fef2f2;border:1px solid #fecaca;color:#b91c1c;
                      padding:10px 12px;border-radius:10px;margin:10px 0;">
            ${msg}
          </div>
        </c:if>

        <form method="post" action="${ctx}/login.do" autocomplete="on">
          <div class="form-row">
            <label for="idOrEmail">아이디</label>
            <input class="input" id="idOrEmail" name="idOrEmail"
                   type="text" placeholder="ID 또는 이메일" required />
          </div>

          <div class="form-row">
            <label for="pw">비밀번호</label>
            <input class="input" id="pw" name="pw"
                   type="password" placeholder="Password" required />
          </div>

          <div class="row-between">
            <label class="checkbox">
              <input type="checkbox" name="autoLogin" value="Y" />
              자동 로그인
            </label>
            <a class="link" href="${ctx}/findPw.do">비밀번호 찾기</a>
          </div>

          <button class="btn btn-primary" type="submit">로그인 ➜</button>

          <div class="form-row">
            <button class="btn btn-outline" type="button"
                    onclick="location.href='${ctx}/join.do'">회원가입</button>
          </div>

          <div class="or">또는</div>

          <button class="btn btn-ghost" type="button"
                  onclick="location.href='${ctx}/guest.do'">게스트로 계속하기</button>
        </form>

        <div class="footer">
          © 2025 FIVE GUYS. All rights reserved.
          <div class="legal">
            <a class="link" href="${ctx}/terms.do">이용약관</a>
            <a class="link" href="${ctx}/privacy.do">개인정보</a>
            <a class="link" href="${ctx}/contact.do">문의</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
