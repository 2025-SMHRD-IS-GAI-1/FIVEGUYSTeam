package com.pro.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;


@WebServlet("/CheckEmailService")
public class CheckEmailService implements Command{

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		
		String email = request.getParameter("email");
		String checkok = "notok";
		MemberVO mvo2 = null;
		if(email!=null) {
			MemberDAO dao = new MemberDAO();
			
			mvo2 = dao.find(email);

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