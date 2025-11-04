package com.pro.frontcontroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.controller.ChangeEmail;
import com.pro.controller.CheckEmail;
import com.pro.controller.DeleteAccount;
import com.pro.controller.FindPasswordService;
import com.pro.controller.JoinService;
import com.pro.controller.LoginService;
import com.pro.controller.LogoutService;
import com.pro.controller.SelectAllService;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Map<String, Command> map = new HashMap<String, Command>();

	@Override
	public void init(ServletConfig config) throws ServletException {
		map.put("join.do", new JoinService());
		map.put("login.do", new LoginService());
<<<<<<< HEAD
<<<<<<< HEAD

=======
		map.put("CheckEmail.do", new ChangeEmail());
>>>>>>> 65f809291debd4450b5eb026b39fde2007fc6fe5
=======
		map.put("CheckEmail.do", new CheckEmail());
>>>>>>> 6bf7c093462155d5bab3f9d8e9fb79567a7e9913
		map.put("ChangeEmail.do", new ChangeEmail());
		map.put("DeleteAccount.do", new DeleteAccount());
		map.put("logout.do", new LogoutService());
		map.put("FindPassword.do", new FindPasswordService());
		map.put("SelectAll.do", new SelectAllService());

	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Command com = null;
		String moveurl = "";
		String uri = request.getRequestURI();
		System.out.println(uri);

		String path = request.getContextPath();

		System.out.println(path);
		String finaluri = uri.substring(path.length() + 1);
		System.out.println(finaluri);
// 		1. 요청 객체에 대한 인코딩 작업!
//		중복되는 코드들을 한번에 처리
		request.setCharacterEncoding("UTF-8");

//		우리가 정한 패턴 -> Go 파일명 .do		
		if (finaluri.contains("Go")) {
//			ex) Gomain.do
//			main.jsp 파일로 forward 방식으로 이동 
//			최종적으로 이동해야하는 경로를 만들어주는 작업
			moveurl = finaluri.substring(2).replaceAll("do", "jsp");
		} else {
			com = map.get(finaluri);
			moveurl = com.excute(request, response);
//		new CheckEmailService().execute(request, response);
		}

		System.out.println(moveurl);

//			중복되는 코드 2번째
//			페이지 경로를 이동 
//			2. redirect:/main.jsp --> redirect방식 이동
		if (moveurl.contains("fetch:/")) {
//			비동기 통신으로 요청이 들어왔을 때, 페이지를 이동하지 않겠다.
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.print(moveurl.substring(7));
		} else if (moveurl.contains("redirect:/")) {
//			moveUrl --> redirect:/ 잘라줘야 이동할 경로가 제대로 나온다
			response.sendRedirect(moveurl.substring(10));
		} else {
//		1. join_success.jsp -->forward 방식 이동
			RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/" + moveurl);
			rd.forward(request, response);
		}

//		moveUrl -> "join_suceess.jsp"
//		moveUrl -> "redirect:/main.jsp"

	}

}
