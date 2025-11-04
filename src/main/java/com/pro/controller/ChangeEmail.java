package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class ChangeEmail implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Gologin.do";
		String newEmail = request.getParameter("newEmail");
		String pw = request.getParameter("pw");
		MemberDAO dao =new MemberDAO();
		MemberVO mvo = new MemberVO();
		
		mvo.setEmail(newEmail);
		mvo.setPw(pw);
		HttpSession session = request.getSession(false);
		MemberVO vo = (MemberVO)session.getAttribute("info");
		mvo.setId(vo.getId());
		
		int row = dao.changeemail(mvo);
		if(row>0) {
			
		}
		
		return moveurl;
	}

}
