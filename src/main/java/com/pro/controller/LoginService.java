package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class LoginService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "fetch:/"+"{\"result\" : \"false\"}";
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setPw(pw);
		
		MemberDAO dao = new MemberDAO();
		MemberVO info = dao.login(mvo);
		
		if(info != null) {
			HttpSession session = request.getSession();
			session.setAttribute("info", info);
			moveurl = "fetch:/"+"{\"result\" : \"true\"}";
		}
		
		
		return moveurl;
	}

}
