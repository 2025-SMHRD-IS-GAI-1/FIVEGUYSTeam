<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
<link rel="stylesheet" href="assets/css/adminEdit.css"/>
</head>
<body>
  <div class="wrap">
    <h2>회원 정보 수정</h2>
    <!-- memberEdit.do 에서 넘겨준 member 객체 사용 -->
    <form action="<%=ctx%>/memberUpdate.do" method="post">
      <!-- 아이디는 PK니까 보통 수정 안 하고 hidden 으로 보냄 -->
      <input type="hidden" name="id" value="${member.id}" />

      <label>이름</label>
      <input type="text" name="name" value="${member.name}" required />

      <label>이메일</label>
      <input type="email" name="email" value="${member.email}" required />

      <label>권한</label>
      <select name="role">
        <option value="M" ${member.role == 'M' ? 'selected' : ''}>일반회원(M)</option>
        <option value="A" ${member.role == 'A' ? 'selected' : ''}>관리자(A)</option>
      </select>

      <button type="submit">수정 저장하기</button>
    </form>
    <div class="back-link">
      <a href="<%=ctx%>/Goadmin.do">← 목록으로 돌아가기</a>
    </div>
  </div>
</body>
</html>
