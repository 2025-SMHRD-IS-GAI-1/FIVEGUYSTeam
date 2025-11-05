package com.pro.controller;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class SelectAllService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {

		// 1. DAO 생성하기 
		
		
		
		MemberDAO dao = new MemberDAO();
		
		
		
		// 2. dao.selectAll 메소드 실행
		// SQL문) SELECT EMAIL, TEL , ADDRESS FROM WEB_MEMBER
		// 		WHERE EMAIL != 'admin'
		List<MemberVO> list = dao.findAdmin();
		System.out.println("송송체크 >>" + list.size());
		// 3. 받아온 결과값을 request 영역에 저장
		request.setAttribute("list", list);
		
		
		
		return "admin.jsp";
	}

}
