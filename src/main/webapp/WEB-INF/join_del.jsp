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
  <link rel="stylesheet" href="assets/css/join_del.css">
</head>
<body>
  <div class="center">
    <div class="card">
      <h1 class="title">탈퇴가 완료되었습니다.</h1>
      <p class="desc"><b><%=name%>님</b>, 이용해주셔서 감사합니다.</p>
      <p class="desc">앞으로 더 좋은 모습으로 만나뵐 수 있도록 계속 노력하겠습니다.</p>
      <a class="btn" href="<%=ctx%>/login.jsp">홈</a>
    </div>
  </div>
</body>
</html>
