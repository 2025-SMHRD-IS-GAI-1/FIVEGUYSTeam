package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class ChangePasswordService implements Command {

    @Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
        // 1) 로그인 사용자 확인
        HttpSession session = request.getSession(false);
        String email = null;
        if (session != null) {
            Object e = session.getAttribute("LOGIN_EMAIL");
            if (e instanceof String) email = (String) e;
            if (email == null) {
                Object info = session.getAttribute("info");
                if (info instanceof MemberVO) {
                    email = ((MemberVO) info).getEmail();
                }
            }
        }
        if (email == null) {
            // 로그인 상태가 아니면 로그인 페이지로
            return "redirect:/login.jsp";
        }

        // 2) 파라미터
        String curPw = trimOrNull(request.getParameter("curPw"));
        String newPw = trimOrNull(request.getParameter("newPw"));
        String newPw2 = trimOrNull(request.getParameter("newPw2"));

        // 3) 기본 검증
        if (curPw == null || newPw == null || newPw2 == null
                || !equalsSafe(newPw, newPw2) || newPw.length() < 8) {
            return "redirect:/Mypage.do?pwerr=1";
        }

        // 4) 현재 비번 확인
        MemberDAO dao = new MemberDAO();
        MemberVO me = dao.selectByEmail(email);
        if (me == null || me.getPw() == null || !me.getPw().equals(curPw)) {
            return "redirect:/Mypage.do?pwerr=1";
        }

        // 5) 비번 업데이트
        int row = dao.updatePassword(email, newPw);
        if (row > 0) {
            return "redirect:/Mypage.do?pwok=1";
        }
        return "redirect:/Mypage.do?pwerr=1";
    }

    private static String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private static boolean equalsSafe(String a, String b) {
        return a != null && a.equals(b);
    }
}
