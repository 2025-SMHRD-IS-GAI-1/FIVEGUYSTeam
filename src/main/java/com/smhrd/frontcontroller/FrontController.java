package com.smhrd.frontcontroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.frontcontroller.Command; // ✅ 빠졌던 import 추가

import com.smhrd.controller.JoinService;
import com.smhrd.controller.LoginService;
import com.smhrd.controller.LogoutService;
import com.smhrd.controller.SelectAllService;

// ⬇️ 마이페이지 관련 추가
import com.smhrd.controller.MypageService;
import com.smhrd.controller.ChangePasswordService;
import com.smhrd.controller.ChangeEmailService;
import com.smhrd.controller.DeleteAccountService;
//import com.smhrd.controller.FavoriteToggleService; // 구현 안 했으면 주석 처리

@WebServlet("*.do")
public class FrontController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 공통 인코딩
        request.setCharacterEncoding("UTF-8");

        String uri = request.getRequestURI();
        String path = request.getContextPath();
        String finalUri = uri.substring(path.length() + 1); // e.g. ChangePassword.do
        System.out.println("[FC] uri=" + uri + " / ctx=" + path + " / finalUri=" + finalUri);

        String moveUrl;
        Command com = null;

        // 기존 라우팅
        if ("Join.do".equals(finalUri)) {
            com = new JoinService();
        } else if ("Login.do".equals(finalUri)) {
            com = new LoginService();
        } else if ("Logout.do".equals(finalUri)) {
            com = new LogoutService();
        } else if ("SelectAll.do".equals(finalUri)) {
            com = new SelectAllService();

        // ⬇️ 추가 라우팅 : 마이페이지 세트
        } else if ("Mypage.do".equals(finalUri)) {
            com = new MypageService();
        } else if ("ChangePassword.do".equals(finalUri)) {
            com = new ChangePasswordService();
        } else if ("ChangeEmail.do".equals(finalUri)) {
            com = new ChangeEmailService();
        } else if ("DeleteAccount.do".equals(finalUri)) {
            com = new DeleteAccountService();
      //  } else if ("FavoriteToggle.do".equals(finalUri)) { // 구현 안 했으면 주석
      //      com = new FavoriteToggleService();
        }

        // ⬇️ 방어: 분기 실패 시 404 처리 (main.jsp로 튀는 현상 방지)
        if (com == null) {
            System.out.println("[FC] NO ROUTE for " + finalUri);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        moveUrl = com.execute(request, response);
        System.out.println("[FC] moveUrl=" + moveUrl);

        if (moveUrl != null && moveUrl.contains("redirect:/")) {
            response.sendRedirect(moveUrl.substring(10));
        } else {
            RequestDispatcher rd = request.getRequestDispatcher(moveUrl);
            rd.forward(request, response);
        }
    }
}
