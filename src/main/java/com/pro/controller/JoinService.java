package com.pro.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;

public class JoinService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Gomain.do";
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		프론트에서 입력한 id, pw값 받아오기 
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// SHA-512 변형코드 적용 : [원pw + 역순pw]를 id를 salt대신 키로 사용하여 암호화
		String reversePW = new StringBuilder(pw).reverse().toString();
		String hashedPW = PasswordUtils.hashPassword(reversePW+pw, id);
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setPw(hashedPW); // 20251103[cyonn]     pw -> hashedPW로 변경
		mvo.setName(name);
		mvo.setEmail(email);
	
		MemberDAO dao = new MemberDAO();
		
		int row = dao.join(mvo);
	
		if(row>0) {
			request.setAttribute("id",id);
			request.setAttribute("pw", pw);
			moveurl= "join_success.jsp";
		}
		return moveurl;
	}

}
