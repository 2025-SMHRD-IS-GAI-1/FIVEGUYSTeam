<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 컨텍스트 경로 (배포 경로가 바뀌어도 링크가 안 깨지게)
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>FIVE GUYS - Menu Translator</title>
  <!-- CSS 경로 -->
  <link rel="stylesheet" href="assets/css/login.css" />
</head>

<body>
  <div class="wrap">
    <!-- 상단 브랜드 바 -->
    <div class="brand">
      <img src="${pageContext.request.contextPath}/img/팀로고.png" alt="FIVE GUYS" />
      <div class="t">FIVE GUYS - Menu Translator</div>
    </div>

    <!-- 카드 : 왼쪽 로고/설명 + 오른쪽 로그인 폼 -->
    <div class="card">
      <!-- 왼쪽 : 로고 & 캡션 -->
      <div class="left">
        <img class="logo" src="${pageContext.request.contextPath}/img/팀로고.png" alt="FIVE GUYS Logo" />
        <div class="caption">다국어 메뉴판 번역 서비스</div>
      </div>

      <!-- 오른쪽 : 로그인 폼 -->
      <div class="right">
        <h2>계정에 접속하여 번역을 시작하세요</h2>

        <!-- 로그인 처리 주소는 프로젝트에 맞게 변경 -->
        <form method="post" action="<%=ctx%>/login.do" autocomplete="on">
          <!-- 아이디 -->
          <div class="form-row">
            <label for="uid" class="link">아이디</label>
            <input id="uid" name="id" type="text" class="input" placeholder="아이디 또는 이메일" required />
          </div>

          <!-- 비밀번호 -->
          <div class="form-row">
            <label for="upw" class="link">비밀번호</label>
            <input id="upw" name="pw" type="password" class="input" placeholder="비밀번호" required />
          </div>

          <!-- 자동 로그인 / 비밀번호 찾기 -->
          <div class="row-between">
            <label class="checkbox">
              <input type="checkbox" name="remember" value="Y" />
              <span>자동 로그인</span>
            </label>
            <a class="link" href="<%=ctx%>/find-password.jsp">비밀번호 찾기</a>
          </div>

          <!-- 로그인 버튼 -->
          <button type="submit" class="btn btn-primary">로그인 ➜</button>

          <!-- 회원가입 버튼 (아웃라인) -->
          <a class="btn btn-outline" href="<%=ctx%>/join.jsp" style="display:block; text-align:center; margin-top:12px;">
            회원가입
          </a>

          <!-- 구분선 + 게스트 버튼 -->
          <div class="or">또는</div>
          <a class="btn btn-ghost" href="<%=ctx%>/guest.do" style="display:block; text-align:center;">
            게스트로 계속하기
          </a>
        </form>

        <!-- 푸터 -->
        <div class="footer">
          © 2025 FIVE GUYS. All rights reserved.
          <div class="legal">
            <a class="link" href="<%=ctx%>/policy/terms.jsp">이용약관</a>
            <a class="link" href="<%=ctx%>/policy/privacy.jsp">개인정보</a>
            <a class="link" href="<%=ctx%>/policy/help.jsp">문의</a>
          </div>
        </div>
      </div>
    </div>
  </div>

 
</body>
</html>
