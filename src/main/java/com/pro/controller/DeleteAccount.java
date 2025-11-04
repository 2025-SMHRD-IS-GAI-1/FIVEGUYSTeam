package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;

public class DeleteAccount implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String pw = request.getParameter("pw");
		HttpSession session = request.getSession(false);
		MemberVO vo =(MemberVO)session.getAttribute("info");
		String id =vo.getId();
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setPw(pw);
		
		
		String reversePW = new StringBuilder(pw).reverse().toString();
		String hashedPW = PasswordUtils.hashPassword(reversePW+pw, id);
		
		mvo.setId(id);
		mvo.setPw(hashedPW);
		
		MemberDAO dao = new MemberDAO();
		int row =dao.DeleteAccount(mvo);
//		String moveurl= "fetch:/"+"{\"result\" : \"false\"}";
		String moveurl= null;
		if(row>0) {
//			moveurl="fetch:/"+"{\"result\" : \"true\"}";
			moveurl="redirect:/Gologin.do";
		}
		return moveurl;
	}

}
