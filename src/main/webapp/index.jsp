<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <c:choose>
      <c:when test="${empty info}">
         <c:redirect url="/Gologin.do" />
      </c:when>
   <%--    <c:otherwise>
         <c:redirect url="/Gologin.do" />
      </c:otherwise> --%>
   </c:choose>
</body>
</html>

