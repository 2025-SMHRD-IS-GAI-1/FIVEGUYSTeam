<%@ page language="java" contentType="text/html; charset=UTF-8"
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