<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<link rel="stylesheet" href="${ctx}/assets/css/mypage.css" />
</head>
<body>
	<div class="wrap">
		<!-- 상단 브랜드 바 -->
		<div class="brand">
			<img src="${ctx}/img/팀로고.png" alt="FIVE GUYS" />
			<div class="t">FIVE GUYS - Menu Translator</div>
			<div class="spacer"></div>
			
			<a href="${ctx}/Goresult.do" class="mini-nav">홈</a> 
			<a href="${ctx}/logout.do" class="link">로그아웃</a>
		</div>

		<!-- 메인 카드 -->
		<div class="card">
			<!-- 왼쪽: 프로필/보안 -->
			<div class="left">
				<h2>프로필</h2>
				
				<!-- 현재 이메일 표시 -->
				<div class="form">
					<div class="row">
						<label>이메일 : </label>
						<div>${sessionScope.info.name}</div>
						<label>이름 : </label>
						<div>${sessionScope.info.email}</div>
						
					</div>
				</div>

				

				

				            <!-- 비밀번호 변경 -->
            <div class="box">
               <h3>비밀번호 변경</h3>
               <form method="post" class="form" autocomplete="off"
                  onsubmit="return false;">
                  <div class="row">
                     <label>현재 비번</label><input name="curPw" id="curPw"
                        type="password" required />
                  </div>
                  <div class="row">
                     <label>새 비번</label><input name="newPw" id="newPw" type="password"
                        minlength="8" required />
                  </div>
                  <div class="row">
                     <label>확인</label><input name="newPw2" id="newPw2" type="password"
                        minlength="8" required />
                  </div>
                  <button class="btn outline" id="Pwbtn">비밀번호 변경</button>
                  <c:if test="${param.pwok=='1'}">
                     <div class="ok">비밀번호가 변경되었습니다.</div>
                  </c:if>
                  <c:if test="${param.pwerr=='1'}">
                     <div class="err">비밀번호 변경에 실패했습니다. 입력값을 확인하세요.</div>
                  </c:if>
                  </form>
            </div>

            <!-- 회원 탈퇴 -->
            <div class="box">
               <h3>회원 탈퇴</h3>
               <form method="post" action="${ctx}/DeleteAccount.do" class="form"
                  onsubmit="return confirm('정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.');"
                  autocomplete="off" id="delbtn">
                  <div class="row">
                     <label>비밀번호</label><input name="pw" type="password" id="delpw"
                        required />
                  </div>
                  <button class="btn outline">탈퇴하기</button>
                  <c:if test="${delErr=='1'}">
                     <div class="err">비밀번호가 올바르지 않거나 탈퇴에 실패했습니다.</div>
                  </c:if>
               </form>
            </div>
         </div>
			
		

			<!-- 오른쪽: 내 활동 -->
			<div class="right">
				<div class="panel">
					<h2>내 활동</h2>

					<!-- 내 사진 목록 -->
					<h3 style="margin-top: 0">내 사진</h3>
					<c:choose>
						<c:when test="${not empty myImages}">
							<ul style="list-style: none; padding: 0; margin: 0 0 12px 0;">
								<c:forEach var="i" items="${myImages}">
									<li
										style="display: flex; align-items: center; justify-content: space-between; border: 1px solid #e5e7ef; border-radius: 12px; padding: 10px 12px; margin: 8px 0;">
										<div>
											<div style="font-weight: 600">${i.RES_NAME}</div>
											<div style="color: #6b7280; font-size: 12px">${i.IMG_NAME}
												<c:if test="${not empty i.UPLOAD_DT}">
                        · <fmt:formatDate value="${i.UPLOAD_DT}"
														pattern="yyyy-MM-dd HH:mm" />
												</c:if>
											</div>
										</div>
										<div style="display: flex; gap: 8px;">
											<a class="btn ghost"
												href="${ctx}/ImageView.do?imgId=${i.IMG_ID}">열기</a>
											<form method="post" action="${ctx}/FavoriteToggle.do"
												style="margin: 0">
												<input type="hidden" name="imgId" value="${i.IMG_ID}" /> <input
													type="hidden" name="act" value="add" />
												<button class="btn">즐겨찾기</button>
											</form>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<p class="muted">아직 업로드한 사진이 없습니다.</p>
						</c:otherwise>
					</c:choose>

					<!-- 즐겨찾기 목록 -->
					<h3>즐겨찾기</h3>
					<c:choose>
						<c:when test="${not empty favs}">
							<ul style="list-style: none; padding: 0; margin: 0;">
								<c:forEach var="f" items="${favs}">
									<li
										style="display: flex; align-items: center; justify-content: space-between; border: 1px solid #e5e7ef; border-radius: 12px; padding: 10px 12px; margin: 8px 0;">
										<div>
											<div style="font-weight: 600">${f.RES_NAME}</div>
											<div style="color: #6b7280; font-size: 12px">${f.IMG_NAME}
												<c:if test="${not empty f.REG_DT}">
                        · <fmt:formatDate value="${f.REG_DT}"
														pattern="yyyy-MM-dd HH:mm" />
												</c:if>
											</div>
										</div>
										<div style="display: flex; gap: 8px;">
											<a class="btn ghost"
												href="${ctx}/ImageView.do?imgId=${f.IMG_ID}">열기</a>
											<form method="post" action="${ctx}/FavoriteToggle.do"
												style="margin: 0">
												<input type="hidden" name="imgId" value="${f.IMG_ID}" /> <input
													type="hidden" name="act" value="remove" />
												<button class="btn outline">해제</button>
											</form>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<p class="muted">즐겨찾기한 항목이 없습니다.</p>
						</c:otherwise>
					</c:choose>

					<!-- 업로드 바로가기 -->
					<div style="margin-top: 12px;">
						<a class="btn ghost" href="${ctx}/Upload.do">이미지 업로드 바로가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	
	let Pwbtn = document.getElementById("Pwbtn");
	let url = "ChangePw.do";
	Pwbtn.addEventListener("click", () => {
		let curPw = document.getElementById("curPw").value;
		let newPw  = document.getElementById("newPw").value;
		let newPw2 = document.getElementById("newPw2").value;
		fetch("ChangePw.do",{
			method: "POST",
			headers:{ "Content-Type": "application/x-www-form-urlencoded"},
			body :new URLSearchParams({curPw,newPw,newPw2})
		})
		.then(function(res) {
				// console.log("받아온 데이터 >> ", res);
				return res.json();
			})
			.then(function(result) {
	            if (result.result == "false") {
	               alert("다시 확인해주세요");
	            }else if(result.result =="false2"){
	               alert("기존비번안맞음요");
	            }else {
	               alert("비밀번호가 변경되었습니다!");
	               location.href = "Gologin.do";
	            }

	         })
	         .catch(function(err) {
	            console.error(err);
	         })
	   })


	</script>
</html>
