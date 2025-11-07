package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;

public class Checkid implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		MemberDAO dao = new MemberDAO(); 
		String moveurl = "fetch:/"+"{\"result\" : \"false\"}";
//		프론트에서 입력한 id, pw값 받아오기 
		String id = request.getParameter("id");

		boolean chk = dao.existsId(id);
		if(chk) {
			return moveurl = "fetch:/"+"{\"result\" : \"true\"}";
		}
		
	
		return moveurl;
	}

}
