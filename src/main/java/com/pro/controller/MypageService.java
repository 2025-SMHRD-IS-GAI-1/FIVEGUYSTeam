package com.pro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.menu.model.ImageVO;
import com.pro.menu.model.MenuDataDAO;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;

public class MypageService implements Command {
    // 세션에서 로그인 이메일 얻기 (네 로그인서비스에서 setAttribute 해두세요: "LOGIN_EMAIL")
    private String getLoginEmail(HttpServletRequest request) {
        HttpSession session = request.getSession(); //cyonn false -> true로 수정
        if (session != null) {
            Object e1 = session.getAttribute("LOGIN_EMAIL");
            if (e1 instanceof String) return (String)e1;
            // 혹시 기존에 MemberVO를 저장했다면 이름이 info라고 가정
            Object info = session.getAttribute("info");
            System.out.println(info==null);
            if (info instanceof MemberVO) {
            	// 20251107 cyonn 추가
            	//유저 정보가 있을 경우에만 유저id 소유의 image 가져옴 -> session
            	// t_image 내 이미지정보 가져와서 myImages 세션에 저장하는 로직
            	MenuDataDAO dao = new MenuDataDAO();
            	List<ImageVO> list = dao.getImages(((MemberVO)info).getId());
            	System.out.println(list.size());
            	session.setAttribute("myImages", list);
            	
            	
            	return ((MemberVO)info).getEmail();
            }
        }
        // 임시 우회(디버그용): ?email= 로 접근하면 보여주기
        String q = request.getParameter("email");
        return (q!=null && !q.isBlank()) ? q : null;
    }
    
    @Override
    public String excute(HttpServletRequest request, HttpServletResponse response) {
        String email = getLoginEmail(request);
        if (email == null) return "redirect:/login.jsp";

        MemberDAO dao = new MemberDAO();
        // POST → 프로필 수정
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String tel = request.getParameter("tel");
            String address = request.getParameter("address");
//            MemberVO vo = new MemberVO(email, null, tel, address);
//            int row = dao.updateProfile(vo);
        	int row = 0;
        	
            return "redirect:/Mypage.do?ok=" + (row>0?1:0);
        }

        
        
        
        
        
        // GET → 화면 데이터 세팅
//        MemberVO me = dao.selectByEmail(email);
//        request.setAttribute("me", me);
        return "/WEB-INF/views/mypage.jsp";
    }
}