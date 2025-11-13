package com.pro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class SearchSurvice implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String value = request.getParameter("value");
		
		MemberDAO dao = new MemberDAO();
		List<MemberVO> list = dao.search(value);
		
		
		
		 Gson gson = new Gson();
		 String json = gson.toJson(list); 
//	     request.setAttribute("list", list);
		return "fetch:/"+json;
	}

}
