<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

import java.util.Scanner;

public class SimpleLogout {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // 로그인 시뮬레이션
        System.out.print("아이디를 입력하세요: ");
        String username = scanner.nextLine();

        System.out.println(username + "님, 로그인 되었습니다.");

        // 로그아웃 명령 대기
        while (true) {
            System.out.print("명령어를 입력하세요 (logout 입력 시 종료): ");
            String command = scanner.nextLine();

            if (command.equalsIgnoreCase("logout")) {
                System.out.println(username + "님, 로그아웃 되었습니다.");
                break;
            } else {
                System.out.println("알 수 없는 명령입니다. 다시 입력하세요.");
            }
        }

        scanner.close();
    }
}
























</body>
</html>