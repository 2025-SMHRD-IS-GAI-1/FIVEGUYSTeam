<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class SubscriberManagerApp {
    // 가입자 모델
    static class Subscriber {
        private String name;
        private String email;
        private LocalDate joinDate;
        private boolean active;

        public Subscriber(String name, String email, LocalDate joinDate, boolean active) {
            this.name = name;
            this.email = email;
            this.joinDate = joinDate;
            this.active = active;
        }

        public String getName() { return name; }
        public String getEmail() { return email; }
        public LocalDate getJoinDate() { return joinDate; }
        public boolean isActive() { return active; }

        @Override
        public String toString() {
            DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return String.format("이름: %s | 이메일: %s | 가입일: %s | 활성: %s",
                    name, email, joinDate.format(fmt), active ? "예" : "아니오");
        }
    }

    // 가입자 관리(간단한 in-memory)
    static class SubscriberManager {
        private final List<Subscriber> subscribers = new ArrayList<>();

        public void addSubscriber(Subscriber s) {
            subscribers.add(s);
        }

        public List<Subscriber> listAll() {
            return new ArrayList<>(subscribers);
        }

        public Subscriber findByEmail(String email) {
            for (Subscriber s : subscribers) {
                if (s.getEmail().equalsIgnoreCase(email.trim())) {
                    return s;
                }
            }
            return null;
        }
    }

    // 콘솔 UI
    public static void main(String[] args) {
        SubscriberManager manager = new SubscriberManager();
        Scanner sc = new Scanner(System.in);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 예제 데이터 몇 개 추가
        manager.addSubscriber(new Subscriber("홍길동", "hong@example.com", LocalDate.now().minusDays(10), true));
        manager.addSubscriber(new Subscriber("김영희", "kim@example.com", LocalDate.now().minusDays(30), false));

        while (true) {
            System.out.println("\n== 가입자 관리 ==");
            System.out.println("1. 가입자 추가");
            System.out.println("2. 가입자 전체 보기");
            System.out.println("3. 이메일로 검색");
            System.out.println("4. 종료");
            System.out.print("선택: ");

            String choice = sc.nextLine().trim();
            switch (choice) {
                case "1":
                    System.out.print("이름: ");
                    String name = sc.nextLine().trim();
                    System.out.print("이메일: ");
                    String email = sc.nextLine().trim();
                    System.out.print("가입일 (yyyy-MM-dd) — 빈칸이면 오늘: ");
                    String dateInput = sc.nextLine().trim();
                    LocalDate joinDate;
                    if (dateInput.isEmpty()) {
                        joinDate = LocalDate.now();
                    } else {
                        try {
                            joinDate = LocalDate.parse(dateInput, fmt);
                        } catch (Exception e) {
                            System.out.println("잘못된 날짜 형식. 오늘 날짜로 설정합니다.");
                            joinDate = LocalDate.now();
                        }
                    }
                    System.out.print("활성화 여부 (y/n): ");
                    String activeInput = sc.nextLine().trim().toLowerCase();
                    boolean active = activeInput.equals("y") || activeInput.equals("yes") || activeInput.equals("예");
                    Subscriber s = new Subscriber(name, email, joinDate, active);
                    manager.addSubscriber(s);
                    System.out.println("가입자 추가 완료.");
                    break;
                case "2":
                    List<Subscriber> all = manager.listAll();
                    if (all.isEmpty()) {
                        System.out.println("가입자가 없습니다.");
                    } else {
                        System.out.println("== 가입자 목록 ==");
                        for (Subscriber sub : all) {
                            System.out.println(sub);
                        }
                    }
                    break;
                case "3":
                    System.out.print("검색할 이메일: ");
                    String q = sc.nextLine().trim();
                    Subscriber found = manager.findByEmail(q);
                    if (found == null) {
                        System.out.println("해당 이메일의 가입자를 찾을 수 없습니다.");
                    } else {
                        System.out.println("찾음: " + found);
                    }
                    break;
                case "4":
                    System.out.println("종료합니다.");
                    sc.close();
                    return;
                default:
                    System.out.println("잘못된 선택입니다. 1-4 중 하나를 입력하세요.");
            }
        }
    }
}

</body>
</html>
=======
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<img src="${pageContext.request.contextPath}/img/팀로고.png"
				alt="FIVE GUYS" />
			<div class="t">FIVE GUYS - Menu Translator</div>
		</div>

		<!-- 카드 : 왼쪽 로고/설명 + 오른쪽 로그인 폼 -->
		<div class="card">
			<!-- 왼쪽 : 로고 & 캡션 -->
			<div class="left">
				<img class="logo"
					src="<%=ctx %>/img/팀로고.png"
					alt="FIVE GUYS Logo" />
				<div class="caption">다국어 메뉴판 번역 서비스</div>
			</div>

			<!-- 오른쪽 : 로그인 폼 -->
			<div class="right">
				<h2>계정에 접속하여 번역을 시작하세요</h2>

				<!-- 로그인 처리 주소는 프로젝트에 맞게 변경 -->
				<form method="post" action="<%=ctx%>/login.do" autocomplete="on">
					<!-- 아이디 -->
					<div class="form-row">
						<label for="uid" class="link">아이디</label> <input id="uid"
							name="id" type="text" class="input" placeholder="아이디 또는 이메일"
							required />
					</div>

					<!-- 비밀번호 -->
					<div class="form-row">
						<label for="upw" class="link">비밀번호</label> <input id="upw"
							name="pw" type="password" class="input" placeholder="비밀번호"
							required />
					</div>

					<!-- 로그인실패 메시지(빨간 글씨) -->
					<c:if test="${not empty errorMsg}">
						<p class="error-msg">
							<c:out value="${errorMsg}" />
						</p>
					</c:if>



					<!-- 자동 로그인 / 비밀번호 찾기 -->
					<div class="row-between">
						<label class="checkbox"> <input type="checkbox"
							name="remember" value="Y" /> <span>자동 로그인</span>
						</label> <a class="link" href="${pageContext.request.contextPath}/pw_find.jsp">비밀번호 찾기</a>

					</div>

					<!-- 로그인 버튼 -->
					<button type="submit" class="btn btn-primary">로그인 ➜</button>

					<!-- 회원가입 버튼 (아웃라인) -->
					<a class="btn btn-outline" href="<%=ctx%>/join.jsp"
						style="display: block; text-align: center; margin-top: 12px;">
						회원가입 </a>

					<!-- 구분선 + 게스트 버튼 -->
					<div class="or">또는</div>
					<a class="btn btn-ghost" href="<%=ctx%>/guest.do"
						style="display: block; text-align: center;"> 게스트로 계속하기 </a>
				</form>

				<!-- 푸터 -->
				<div class="footer">
					© 2025 FIVE GUYS. All rights reserved.
					<div class="legal">
						<a class="link" href="#" id="openTermsLink">이용약관</a>
						
					
						<a
							class="link" href="<%=ctx%>/policy/privacy.jsp">개인정보</a> <a
							class="link" href="<%=ctx%>/policy/help.jsp">문의</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 이용약관은 모든 div의 제일 아래에 넣고 스타일로 감춘 후 클릭하면 노출되도록 한다. -->
	<div id="termsModal" class="modal-overlay">
		<div class="modal-content">
			<span class="close-btn">&times;</span>
			<h2>이용약관</h2>
	        <div id="rules_text"></div>
    	</div>
	</div><!--  이용약관 끝 -->
	<script src="assets/js/terms.js" ></script> <!-- 20251103 cyonn -->

</body>
</html>
>>>>>>> 3940ba9b87f534acf44b9eff3efd1cd470eccbc9
