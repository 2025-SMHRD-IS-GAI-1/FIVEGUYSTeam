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
		
		
		String reversePW = new StringBuilder(pw).reverse().toString();
		String hashedPW = PasswordUtils.hashPassword(reversePW+pw, id);
		
		mvo.setId(id);
		mvo.setPw(hashedPW);
		
		MemberDAO dao = new MemberDAO();
		int row =dao.DeleteAccount(mvo);
//		String moveurl= "fetch:/"+"{\"result\" : \"false\"}";
		String moveurl= null;
		
		// 삭제에 성공했을 때 
		if(row>0) {
//			moveurl="fetch:/"+"{\"result\" : \"true\"}";
			session.invalidate();  // 세션 날리고
			moveurl="redirect:/Gologin.do"; // sendredirect 방식으로 보내줌 
		
		// 삭제에 실패했을 때 
		}else {
			// 리퀘스트 객체에 delErr : 1 키밸류 형태로 셋
			request.setAttribute("delErr", "1");
			// Fc에서 forward방식으로 보냄
			moveurl ="mypage.do";
		}
		return moveurl;
	}

}
