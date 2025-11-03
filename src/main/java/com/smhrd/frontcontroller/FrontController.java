package com.smhrd.frontcontroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.controller.JoinService;
import com.smhrd.controller.LoginService;
import com.smhrd.controller.LogoutService;
import com.smhrd.controller.SelectAllService;

//모든 요청이 .do라고 하는 확장자를 가지고 있다면

//다 가져올 수 있는 URL Mapping 

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// FrontController : 단 한개의 Servlet을 사용하여,
		// 모든 요청과 응답을 처리하는 패턴!

		// 1. FrontController에 들어온 요청이 어떤 요청인지 파악!

		// 실행되는 uri 주소 가져오기
		String uri = request.getRequestURI(); // 주소값 뽑아오는거
		System.out.println("쏭쏭 체크>>" + uri);
		// /ExMessageSystem_FrontCon/Login.do

		// 프로젝트 경로 가져오기
		String path = request.getContextPath(); // 맵핑값 뽑아오는거
		System.out.println("패스 체크>>" + path);

		// uri 경로에서 path에 대한 경로 삭제!
		// /ExMessageSystem_FrontCon + /

		// → /Login.do
		// /ExMessageSystem_FrontCon
		String finalUri = uri.substring(path.length() + 1);
		System.out.println("최종" + finalUri);

		// 중복되는 코드들을 한번에 처리
		// 요청 객체에 대한 인코딩 작업!
		request.setCharacterEncoding("UTF-8");

		String moveUrl = "";
		Command com = null;
		if (finalUri.equals("Join.do")) {
			// 해당 기능을 수행하기 위한 클래스로 접근!
			com = new JoinService();
		} else if (finalUri.equals("Login.do")) {
			com = new LoginService();
		} else if (finalUri.equals("Logout.do")) {
			com = new LogoutService();
		} else if (finalUri.equals("SelectAll.do")) {
			com = new SelectAllService();
		}
		
		moveUrl = com.execute(request, response);
		
		
		// 중복되는 코드 2번째
		// 페이지 경로를 이동
		if (moveUrl.contains("redirect:/")) {
			// moveUrl → redirect:/ 잘라줘야 이동할 경로가 제대로 나온다!
			response.sendRedirect(moveUrl.substring(10));

		} else {

			// 1. join_success.jsp → forward 방식 이동
			RequestDispatcher rd = request.getRequestDispatcher(moveUrl);
			rd.forward(request, response);
			// 2. redirect:/main.jsp → redirect방식 이동
		}

	}
}
