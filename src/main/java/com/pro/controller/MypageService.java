package com.pro.controller;

import javax.servlet.http.*;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class MypageService implements Command {

    // 세션에서 로그인 이메일 얻기 (네 로그인서비스에서 setAttribute 해두세요: "LOGIN_EMAIL")
    private String getLoginEmail(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object e1 = session.getAttribute("LOGIN_EMAIL");
            if (e1 instanceof String) return (String)e1;
            // 혹시 기존에 MemberVO를 저장했다면 이름이 info라고 가정
            Object info = session.getAttribute("info");
            if (info instanceof MemberVO) return ((MemberVO)info).getEmail();
        }
        // 임시 우회(디버그용): ?email= 로 접근하면 보여주기
        String q = request.getParameter("email");
        return (q!=null && !q.isBlank()) ? q : null;
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String email = getLoginEmail(request);
        if (email == null) return "redirect:/login.jsp";

        MemberDAO dao = new MemberDAO();

        // POST → 프로필 수정
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String tel = request.getParameter("tel");
            String address = request.getParameter("address");
            MemberVO vo = new MemberVO(email, null, tel, address);
            int row = dao.updateProfile(vo);
            return "redirect:/Mypage.do?ok=" + (row>0?1:0);
        }

        // GET → 화면 데이터 세팅
        MemberVO me = dao.selectByEmail(email);
        request.setAttribute("me", me);
        return "/WEB-INF/views/mypage.jsp";
    }
}
