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
		
//		로그인할때 들어 set한 세션 값 불러오기
		HttpSession session = request.getSession();
		MemberVO vo =(MemberVO) session.getAttribute("info");
		String checkPw = vo.getPw();//db에서 가져온 암호화된 비번
		
		String cur_reverse = new StringBuilder(pw).reverse().toString();
		String hashedPW = PasswordUtils.hashPassword(cur_reverse+pw, vo.getId());   //
		
		//		현재비번 , 새비번, 새비번확인 제대로 입력했는지 확인
		if(!hashedPW.equals(checkPw)) {
			return "fetch:/"+"{\"result\" : \"false2\"}";
		} 
		if(!changepw.equals(changepw2)) {
			return "fetch:/"+"{\"result\" : \"false\"}";
		}
		String reversePW2 = new StringBuilder(changepw).reverse().toString();
		String hashedPW2 = PasswordUtils.hashPassword(reversePW2+changepw, vo.getId());
		
		String id = vo.getId();
		MemberVO mvo = new MemberVO();
		mvo.setPw(hashedPW2);
		mvo.setId(id);
		//mvo.setChangepw(changepw);
		
		MemberDAO dao = new MemberDAO();
		
		int row = dao.changePw2(mvo);
		if(row>0) {
			moveurl="fetch:/"+"{\"result\" : \"true\"}";
		}
		return moveurl;
	}

}
