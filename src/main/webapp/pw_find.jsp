<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <!-- 기존 로그인 스타일 재사용 -->
  <link rel="stylesheet" href="${ctx}/assets/css/login.css" />
</head>
<body>
  <div class="wrap">
    <div class="brand">
      <img src="${ctx}/img/팀로고.png" alt="FIVE GUYS" />
      <div class="t">FIVE GUYS - Menu Translator</div>
      <div style="margin-left:auto">
        <a class="link" href="${ctx}/login.jsp">로그인</a>
        <a class="link" href="${ctx}/index.jsp">홈</a>
      </div>
    </div>

    <div class="card">
      <div class="left">
        <img class="logo" src="${ctx}/img/팀로고.png" alt="FIVE GUYS Logo" />
        <div class="caption">비밀번호 찾기</div>
      </div>
      <div class="right">
        <h2>아이디와 가입 이메일을 입력하세요</h2>
        <form method="post" action="${ctx}/findPassword.do" autocomplete="off">
          <div class="form-row">
            <label class="link">아이디</label>
            <input name="id" type="text" class="input" placeholder="ID" required />
          </div>
          <div class="form-row">
            <label class="link">이메일</label>
            <input name="email" type="email" class="input" placeholder="email@example.com" required />
          </div>
          <button type="submit" class="btn btn-primary">임시 비밀번호 받기</button>

          <c:if test="${param.err=='1'}">
            <div class="or"></div>
            <div class="legal" style="color:#ef4444">일치하는 회원 정보를 찾을 수 없습니다.</div>
          </c:if>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
