<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String ctx  = request.getContextPath();
  String name = (String)request.getAttribute("name");
  if(name == null || name.trim().isEmpty()) name = "회원";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>가입 완료</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="assets/css/join_success.css">
</head>
<body>
  <div class="center">
    <div class="card">
      <h1 class="title">환영합니다!</h1>
      <p class="desc"><b><%=name%>님</b>, 회원가입을 축하합니다.</p>
      <p class="desc">메시지시스템의 새로운 이메일은 입니다.</p>
      <a class="btn" href="<%=ctx%>/login.jsp">시작하기</a>
    </div>
  </div>
</body>
</html>
