package com.smhrd.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.frontcontroller.Command;
import com.smhrd.model.MemberDAO;
import com.smhrd.model.MemberVO;

public class JoinService implements Command {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// 판단에 따라 마지막에 이동할 페이지 이름을 담는 변수 선언!
		String moveUrl = "";

		// 2. 요청 객체로 부터 데이터 꺼내오기!
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String tel = request.getParameter("tel");
		String address = request.getParameter("address");

		// 데이터 확인용 → 출력문!
		// System.out.println(email +"/"+pw+"/"+tel+"/"+address);

		// DB에 전달해야하는 데이터를 하나의 자료형으로 묶어주기
		// → Data binding (데이터 바인딩)
		MemberVO mvo = new MemberVO();
		mvo.setEmail(email);
		mvo.setPw(pw);
		mvo.setAddress(address);
		mvo.setTel(tel);

		// 3. 실제 DB에 해당하는 내용이 전달되도록 작업! → DAO 클래스 (예전 자바에서)
		MemberDAO dao = new MemberDAO();
		int row = dao.join(mvo);

		// 4. 회원가입 성공 했다면,
		if (row > 0) {
			// 4-1) request영역에 email 정보를 저장해서
			request.setAttribute("email", email);
			// 4-2) forward방식으로 join_success.jsp로 이동
			// RequestDispatcher rd = request.getRequestDispatcher("join_success.jsp"); //
			// 이동경로를 넘겨준다
			// rd.forward(request, response); // 경로로 이동한다!! 암기하기

			moveUrl = "join_success.jsp";
		} else {
			// 5. 회원가입 실패했다면
			// 5-1) main.jsp redirect방식으로 이동
			// response.sendRedirect("main.jsp");

			moveUrl = "redirect:/main.jsp";
		}

		return moveUrl;

	}
}
