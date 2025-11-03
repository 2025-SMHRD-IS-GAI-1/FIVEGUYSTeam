package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;

public class LogoutService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// 1. session 꺼내오기
		HttpSession session = request.getSession();
		// 2. session 데이터 전부 삭제하기
		session.invalidate();
		// 3. main.jsp redirect방식 이동하기

		// request.getSession().invalidate();
		// 개발자들용 코드 !!

		return "redirect:/main.jsp";

	}

}
