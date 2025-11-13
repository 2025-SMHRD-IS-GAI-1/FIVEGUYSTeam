package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class CheckEmail implements Command{

	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		String email = request.getParameter("email");
		String id = request.getParameter("id");
		//System.out.println("입력"+email);
		String checkok = "notok";
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setEmail(email);
		 
		MemberVO mvo2 = null;
		if(email!=null) {
			MemberDAO dao = new MemberDAO();
			
			mvo2 = dao.find(mvo);

			if(mvo2!=null) {
				if(mvo2.getEmail().equals(email))
					checkok = "ok";
				
			}else {
				mvo2 = new MemberVO();
			}
		}
		
		
		String result = "{\"checkok\":\""+checkok+"\"}";
		//Gson gson = new Gson();
		//String result2 = gson.toJson(mvo2);
		//System.out.println(result);
		return "fetch:/"+result;
	}

}
