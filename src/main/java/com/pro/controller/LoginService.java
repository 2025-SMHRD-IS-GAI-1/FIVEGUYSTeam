package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;

public class LoginService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "fetch:/"+"{\"result\" : \"false\"}";
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
	
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		
		
		// SHA-512 변형코드 적용 : [원pw + 역순pw]를 id를 salt대신 키로 사용하여 암호화
		String reversePW = new StringBuilder(pw).reverse().toString();
		String hashedPW = PasswordUtils.hashPassword(reversePW+pw, id);
		mvo.setPw(hashedPW); // 20251103[cyonn]     pw -> hashedPW로 변경
		
		MemberDAO dao = new MemberDAO();
		MemberVO info = dao.login(mvo);
		
		if(info != null) {
			HttpSession session = request.getSession();
			session.setAttribute("info", info);
			moveurl = "fetch:/"+"{\"result\" : \"true\"}";
		}
		
		System.out.println("url은:"+moveurl);
		return moveurl;
	}

}
