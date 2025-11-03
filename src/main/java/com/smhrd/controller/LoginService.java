package com.smhrd.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.frontcontroller.Command;
import com.smhrd.model.MemberDAO;
import com.smhrd.model.MemberVO;

public class LoginService implements Command {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String email = request.getParameter("email");
        String pw    = request.getParameter("pw");

        MemberDAO dao = new MemberDAO();
        MemberVO mvo  = new MemberVO();
        mvo.setEmail(email);
        mvo.setPw(pw);

        MemberVO info = dao.login(mvo);

        if (info != null) {
            HttpSession session = request.getSession();
            session.setAttribute("LOGIN_EMAIL", info.getEmail());
            session.setAttribute("info", info); // 선택

            return "redirect:/Mypage.do"; // ✅ 성공 시 마이페이지 고정
        } else {
            return "redirect:/login.jsp?err=1";
        }
    }
}
