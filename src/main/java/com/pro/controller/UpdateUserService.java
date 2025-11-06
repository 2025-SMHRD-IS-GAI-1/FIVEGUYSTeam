package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class UpdateUserService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Goadmin.do";
		
		String id = request.getParameter("edit_id");
		String name = request.getParameter("edit_name");
		String email = request.getParameter("edit_email");
		String adminyn = request.getParameter("edit_adminyn");
		
		MemberDAO dao =new MemberDAO();
		MemberVO mvo = new MemberVO();
		
		System.out.println(id+":"+name+":"+email+":"+adminyn);
		mvo.setId(id);
		mvo.setName(name);
		mvo.setEmail(email);
		mvo.setAdminYN(adminyn);
		
		HttpSession session = request.getSession(false);
		
		int row = dao.updateUser(mvo);
		if(row>0) {
			session.setAttribute("userupdate", "ok");
		}
		
		return moveurl;
	}

}
