package com.smhrd.controller;

import javax.servlet.http.*;
import com.smhrd.frontcontroller.Command;
import com.smhrd.model.MemberDAO;

public class ChangeEmailService implements Command {
  @Override
  public String execute(HttpServletRequest req, HttpServletResponse resp) {
    HttpSession session = req.getSession(false);
    String oldEmail = (session==null)? null : (String) session.getAttribute("LOGIN_EMAIL");
    if (oldEmail == null) return "redirect:/login.jsp";

    String newEmail = req.getParameter("newEmail");
    String pw       = req.getParameter("pw");

    MemberDAO dao = new MemberDAO();

    // 비번 확인
    String curPw = dao.selectPwByEmail(oldEmail);
    if (curPw==null || !curPw.equals(pw)) return "redirect:/Mypage.do?emailErr=pw";

    // 중복 검사
    if (dao.countByEmail(newEmail) > 0) return "redirect:/Mypage.do?emailErr=dup";

    int row = dao.changeEmail(oldEmail, newEmail);
    if (row > 0){
      session.setAttribute("LOGIN_EMAIL", newEmail); // 세션 갱신
      return "redirect:/Mypage.do?emailOk=1";
    }
    return "redirect:/Mypage.do?emailErr=fail";
  }
}
