<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String ctx = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<title>회원 관리 - FIVE GUYS</title>

<link rel="stylesheet" href="assets/css/admin.css" />

</head>

<body>

	<!-- 상단바 -->

	<div class="topbar">

		<img src="${pageContext.request.contextPath}/img/팀로고.png" class="logo"
			alt="logo">

		<div class="title">FIVE GUYS - Menu Translator (Admin)</div>

	</div>

	<div class="wrap">

		<div class="card">

			<!-- 왼쪽 패널: 서비스 소개 / 로고 -->

			<div class="left-panel">

				<!-- 실제 로고 경로로 바꿔줘 -->

				<img src="${pageContext.request.contextPath}/img/팀로고.png"
					alt="FIVE GUYS">

				<div class="caption">다국어 메뉴판 번역 서비스 관리자 페이지</div>

			</div>

			<!-- 오른쪽 패널: 회원 목록 -->

			<div class="right-panel">

				<div class="right-header">

					<div>

						<h2>회원 전체 목록</h2>

						<p>가입한 사용자들의 정보를 한눈에 확인하세요.</p>

					</div>

					<!-- 필요하면 버튼 하나 두기 -->

					<!-- <button class="btn-primary">새로고침</button> -->

				</div>

				<form action="SelectAll.do" method="post">

					<div class="search-box">

						<input type="text" id="searchInput" placeholder="이름 또는 이메일로 검색">

						<button class="btn-primary" type="submit" value="search"
							id="searchBtn">검색</button>

						<button class="btn-primary" id="all_find" type="submit"
							value="searchAll">회원전체검색</button>

					</div>

				</form>

				<div class="table-wrap">

					<table id="memberTable">

						<thead>

							<tr>

								<th>#</th>

								<th>아이디</th>

								<th>이름</th>

								<th>이메일</th>

								<th>권한</th>

								<th>가입날짜</th>

							</tr>

						</thead>

						<tbody>

							<c:forEach var="member" items="${memberList}" varStatus="st">

								<tr>

									<td>${st.index + 1}</td>

									<td>${member.name}</td>

									<td>${member.email}</td>

									<td><c:choose>

											<c:when test="${member.role eq 'A'}">

												<span class="role A">A</span>

											</c:when>

											<c:otherwise>

												<span class="role M">M</span>

											</c:otherwise>

										</c:choose></td>

									<td>${member.joinDate}</td>

									<td>
										<!-- 수정 --> <a
										href="${pageContext.request.contextPath}/memberEdit.do?id=${member.id}"
										class="btn-sm">수정</a> <!-- 삭제 --> <a
										href="${pageContext.request.contextPath}/memberDelete.do?id=${member.id}"
										class="btn-sm danger" onclick="return confirm('정말 삭제할까요?');">삭제</a>

									</td>

								</tr>

							</c:forEach>



							<c:choose>





								<c:when test="${not empty list}">

									<c:forEach var="m" items="${list}" varStatus="st">

										<tr>

											<td>${st.index + 1}</td>

											<td>${m.id}</td>

											<td>${m.name}</td>

											<td>${m.email}</td>

											<td>${m.adminYN}</td>

											<td>${m.joinDT}</td>


										</tr>

									</c:forEach>

								</c:when>





								<c:when test="${not empty memberList}">

									<c:forEach var="m" items="${memberList}" varStatus="st">

										<tr>

											<td>${st.index + 1}</td>

											<td>${m.id}</td>

											<td>${m.name}</td>

											<td>${m.email}</td>

											<td>${m.adminYN}</td>

											<td>${m.joinDT}</td>


										</tr>

									</c:forEach>

								</c:when>





								<c:otherwise>

									<tr>

										<td colspan="6">등록된 회원이 없습니다.</td>

									</tr>

								</c:otherwise>



							</c:choose>

						</tbody>

					</table>

				</div>

				<div class="actions">

					<a href="GoadminEdit.do" class="main-action-btn">회원 정보 수정 페이지 열기</a>

				</div>

				<div class="footer">© 2025 FIVE GUYS. All rights reserved.</div>

			</div>

		</div>

	</div>

</body>
</html>