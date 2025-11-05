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

<%

if(session.getAttribute("userupdate")!=null){
	if(   ( (String)session.getAttribute("userupdate") ).equals("ok")      ){
%>
		<script>alert("업데이트 성공");</script>
<%
		session.setAttribute("userupdate", "notok");
	}
}
%>
	<!-- 상단바 -->
	<div class="topbar">
		<div class="topbar-inner">
			<div class="top-left">
				<img src="${pageContext.request.contextPath}/img/팀로고.png"
					class="logo" alt="logo">
				<div class="title">FIVE GUYS - Menu Translator (Admin)</div>
			</div>
			<div class="top-actions">
				<a class="link" href="${pageContext.request.contextPath}/Gologin.do">홈</a>
			</div>
		</div>
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





				<!-- 검색용 폼 -->
				<form action="SelectAll.do" method="post">

					<div class="search-box">

						<input type="text" id="searchInput" placeholder="ID 또는 이름으로 검색">

<<<<<<< HEAD
						<button type="button" class="btn-primary" type="submit" value="search" id="searchBtn">검색</button>
=======
						<button class="btn-primary" type="button" type="submit" value="search" id="searchBtn">검색</button>
>>>>>>> 123f350bbd986370d2db57cd43104255f94a39df

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
										 <a
										href="${pageContext.request.contextPath}/memberEdit.do?id=${member.id}"
										class="btn-sm">수정</a>  <a
										href="${pageContext.request.contextPath}/memberDelete.do?id=${member.id}"
										class="btn-sm danger" onclick="return confirm('정말 삭제할까요?');">삭제</a>

									</td>

								</tr>

							</c:forEach>



							<c:choose>
 




								<c:when test="${not empty list}">

									<c:forEach var="m" items="${list}" varStatus="st">

										<tr
											onclick="openEditor('${m.id}', '${m.name}', '${m.email}', '${m.adminYN}')">

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



				<div class="footer">© 2025 FIVE GUYS. All rights reserved.</div>
			</div>

		</div>

	</div>

	<!-- 이용약관용으로 만들었던 모달창을 정보수정용으로 스타일만 사용 -->
	<div id="termsModal" class="modal-overlay">
		<div class="modal-content">
			<span class="close-btn">&times;</span>
			<form action="UpdateUser.do" method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" id="dummyid" disabled="disabled" /><input
							type="text" id="edit_id" name="edit_id"
							style="visibility: hidden" /></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" id="edit_name" name="edit_name" /></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" id="edit_email" name="edit_email" /></td>
					</tr>
					<tr>
						<td>권한</td>
						<td><select id="edit_adminyn" name="edit_adminyn">
								<option value="M">일반유저</option>
								<option value="A">관리자</option>
						</select></td>
					</tr>
					<tr>
						<td colspan=2><input type="submit" value="정보수정" /></td>
					</tr>
				</table>
			</form>

		</div>
	</div>
	<script>
		// 1. 필요한 HTML 요소들을 찾습니다.
		const closeBtn = document.querySelector(".close-btn");
		const modal = document.getElementById("termsModal");

		// 2. 'X' 닫기 버튼을 클릭했을 때의 동작
		closeBtn.onclick = function() {
			modal.style.display = "none"; // 모달을 다시 숨깁니다.
		}

		function openEditor(userid, name, email, adminyn) {

			modal.style.display = "flex"; // 숨겨뒀던 모달 배경을 보여줍니다.

			let edit_id = document.getElementById("edit_id");
			let dummyid = document.getElementById("dummyid");
			let edit_name = document.getElementById("edit_name");
			let edit_email = document.getElementById("edit_email");
			let edit_adminyn = document.getElementById("edit_adminyn");

			edit_id.value = userid;
			dummyid.value = userid;
			edit_name.value = name;
			edit_email.value = email;
			edit_adminyn.value = adminyn;

		}
	</script>
	<!-- 20251105 cyonn -->
</body>
<script>
let searchBtn = document.getElementById("searchBtn");
let searchInput = document.getElementById("searchInput");
let url = "Search.do";
searchBtn.addEventListener("click", () => {
	fetch(url + "?value=" + searchInput.value)
	 .then(res => res.json())
        .then(data => {
        	
        	console.table(data);
            const tbody = document.querySelector("#memberTable tbody");
            tbody.innerHTML = "";
			/* data가 없을때 출력  */
            if (!data.length) {
            	  tbody.innerHTML = `<tr><td colspan="6">검색 결과가 없습니다.</td></tr>`;
            	  return;
            	}
            
            data.forEach((m, idx) => {
                tbody.innerHTML += `
                <tr onclick="openEditor('\${m.id}', '\${m.name}', '\${m.email}', '\${m.adminYN}')">
                	 <td>\${idx + 1}</td>
                    <td>\${m.id}</td>
                    <td>\${m.name}</td>
                    <td>\${m.email}</td>
                    <td>\${m.adminYN}</td>   <!-- 권한 -->
                    <td>\${m.joinDT}</td>    <!-- 가입날짜 -->
                </tr>`;
            });
        })
        .catch(err => console.error(err));
});

	
</script>


</html>