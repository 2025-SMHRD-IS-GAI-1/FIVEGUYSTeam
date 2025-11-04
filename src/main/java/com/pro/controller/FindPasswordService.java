package com.pro.controller;

import java.security.SecureRandom;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;

// 선택: 메일 발송이 준비되어 있으면 사용
// import com.pro.email_test.MailSenderService;

public class FindPasswordService implements Command {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String id    = trimOrNull(request.getParameter("id"));
        String email = trimOrNull(request.getParameter("email"));

        // 1) 기본 검증
        if (id == null || email == null) {
            return "redirect:/pw_find.jsp?err=1";
        }

        // 2) 아이디+이메일 일치 확인
        MemberDAO dao = new MemberDAO();
        MemberVO vo = dao.findByIdEmail(id, email);
        if (vo == null) {
            return "redirect:/pw_find.jsp?err=1";
        }

        // 3) 임시 비밀번호 생성
        String tempPw = generateTempPassword(10);

        // 4) 해시 후 DB 반영 (Salt로 ID 사용)
        String hashed = PasswordUtils.hashPassword(tempPw, id);
        int row = dao.updatePasswordById(id, hashed);
        if (row <= 0) {
            return "redirect:/pw_find.jsp?err=1";
        }

        // 5) (선택) 메일 발송 — 준비 안 되어 있으면 이 블록 주석 처리 가능
        /*
        try {
            String subject = "[FIVE GUYS] 임시 비밀번호 안내";
            String body = "<p>안녕하세요, FIVE GUYS 입니다.</p>"
                        + "<p>요청하신 임시 비밀번호는 <b>" + tempPw + "</b> 입니다.</p>"
                        + "<p>로그인 후 즉시 비밀번호를 변경해 주세요.</p>";
            MailSenderService sender = new MailSenderService();
            sender.sendEmail(email, subject, body);
        } catch (Exception ignore) {
            // 메일 실패해도 비밀번호는 이미 변경됨
        }
        */

        // 6) 로그인으로 안내
        return "redirect:/login.jsp?resetOk=1";
    }

    // ---------- helpers ----------
    private static String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private static String generateTempPassword(int len) {
        final String chars = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789!@#$%^&*";
        SecureRandom r = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(r.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
