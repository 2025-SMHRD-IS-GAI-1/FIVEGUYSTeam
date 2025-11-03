package com.smhrd.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.frontcontroller.Command;
import com.smhrd.model.MemberDAO;
import com.smhrd.model.MemberVO;

public class LoginService implements Command {
	// FC --> 일을 시키는 일반 자바 클래스(POJO)
	// Planin Old Java Object

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		String email = request.getParameter("email");
		String pw = request.getParameter("pw");

		MemberVO mvo = new MemberVO();
		mvo.setEmail(email);
		mvo.setPw(pw);

		MemberDAO dao = new MemberDAO();
		MemberVO info = dao.login(mvo);

		// 로그인에 따른 결과화면 연결!
		if (info != null) {
			// 로그인에 성공한 회원의 모든 정보를 가지고 main.jsp 이동!
			// => session에 정보 저장!
			HttpSession session = request.getSession();
			session.setAttribute("info", info);
			System.out.println("info : " + info.getEmail());

		}
		// main.jsp
		// FC가 이동해야하는 경로를 되돌려 주기
		return "redirect:/main.jsp";

	}
}
