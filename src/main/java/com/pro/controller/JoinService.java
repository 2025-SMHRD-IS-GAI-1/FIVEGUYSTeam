package com.pro.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class JoinService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Gomain.do";
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		프론트에서 입력한 id, pw값 받아오기 
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setPw(pw);
		mvo.setName(name);
		mvo.setEmail(email);
	
		MemberDAO dao = new MemberDAO();
		
		int row = dao.join(mvo);
	
		if(row>0) {
			request.setAttribute("id",id);
			request.setAttribute("pw", pw);
			moveurl= "join_success.jsp";
		}
		return moveurl;
	}

}
