package com.pro.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;

public class ChangePw implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl =null;
//		현재 비번
		String pw = request.getParameter("curPw");
//		새로운 비번
		String changepw = request.getParameter("newPw");
//		새로운 비번 확인
		String changepw2 = request.getParameter("newPw2");
		HttpSession session = request.getSession();

		//		현재비번 , 새비번, 새비번확인 제대로 입력했는지 확인
		if(!pw.equals(changepw)) {
			return "fetch:/"+"{\"result\" : \"false\"}";
		}else if(!changepw.equals(changepw2)) {
			return "fetch:/"+"{\"result\" : \"false\"}";
		}
		
		MemberVO vo =(MemberVO) session.getAttribute("info");
		String id = vo.getId();
		System.out.println(vo.getPw());
		MemberVO mvo = new MemberVO();
		mvo.setPw(pw);
		mvo.setId(id);
		mvo.setChangepw(changepw);
		
		MemberDAO dao = new MemberDAO();
		
		int row = dao.changePw2(mvo);
		if(row>0) {
			moveurl="fetch:/"+"{\"result\" : \"true\"}";
		}
		return moveurl;
	}

}
