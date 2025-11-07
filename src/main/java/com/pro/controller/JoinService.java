package com.pro.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pro.frontcontroller.Command;
import com.pro.model.MemberDAO;
import com.pro.model.MemberVO;
import com.pro.utils.PasswordUtils;

public class JoinService implements Command {

	@Override
	public String excute(HttpServletRequest request, HttpServletResponse response) {
		String moveurl = "redirect:/Gologin.do";
		MemberDAO dao = new MemberDAO(); 
//		프론트에서 입력한 id, pw값 받아오기 
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// SHA-512 변형코드 적용 : [원pw + 역순pw]를 id를 salt대신 키로 사용하여 암호화
		String reversePW = new StringBuilder(pw).reverse().toString();
		String hashedPW = PasswordUtils.hashPassword(reversePW + pw, id);
	
//		List<String> list = dao.checkid(); // DB에 ID가 있는지 체크용 아이디
//		System.out.println("dd");
//		for(String ck : list) {
//			if(id.equals(ck)) {
//				request.setAttribute("idErr", "1");
//				return "fetch:/"+"{\"result\" : \"false\"}";
//			}
//		}
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		mvo.setPw(hashedPW); // 20251103[cyonn] pw -> hashedPW로 변경
		mvo.setName(name);
		mvo.setEmail(email);

		

		int row = dao.join(mvo);

		if (row > 0) {
			request.setAttribute("id", id);
			request.setAttribute("pw", pw);
			moveurl = "redirect:/Gojoin_success.do";
		}
		return moveurl;
	}

}
