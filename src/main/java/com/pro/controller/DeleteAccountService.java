package com.pro.controller;

import javax.servlet.http.*;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;

public class DeleteAccountService implements Command {
  @Override
  public String execute(HttpServletRequest req, HttpServletResponse resp) {
    HttpSession session = req.getSession(false);
    String email = (session==null)? null : (String) session.getAttribute("LOGIN_EMAIL");
    if (email == null) return "redirect:/login.jsp";

    String pw = req.getParameter("pw");
    MemberDAO dao = new MemberDAO();
    int row = dao.softDelete(email, pw);

    if (row > 0){
      if (session != null) session.invalidate();
      return "redirect:/goodbye.jsp"; // 간단한 완료 페이지 하나 만들어 두세요
    }
    return "redirect:/Mypage.do?delErr=1";
  }
}
