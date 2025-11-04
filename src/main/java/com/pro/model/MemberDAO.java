package com.pro.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.db.MySqlSessionManager;

public class MemberDAO {
	
	private SqlSessionFactory factory = MySqlSessionManager.getFactory();
	
	public int join(MemberVO mvo) {
			
		SqlSession sqlSession = factory.openSession(true);
		
		int row = sqlSession.insert("join", mvo);
		
		sqlSession.close();
		
		return row;
	}

	public MemberVO login(MemberVO mvo) {
		
		SqlSession sqlSession = factory.openSession(true);
		
		MemberVO vo = sqlSession.selectOne("login", mvo);
		
		sqlSession.close();
		
		return vo;
	}
	// 아이디+이메일로 1명 조회
	public MemberVO findByIdEmail(String id, String email) {
	    org.apache.ibatis.session.SqlSession s = factory.openSession(true);
	    java.util.Map<String, Object> p = new java.util.HashMap<>();
	    p.put("id", id);
	    p.put("email", email);
	    MemberVO vo = s.selectOne("findByIdEmail", p);
	    s.close();
	    return vo;
	}

	// 비밀번호 변경 (ID 기준, 이미 해시된 PW를 전달)
	public int updatePasswordById(String id, String hashedPw) {
	    org.apache.ibatis.session.SqlSession s = factory.openSession(true);
	    java.util.Map<String, Object> p = new java.util.HashMap<>();
	    p.put("id", id);
	    p.put("pw", hashedPw);
	    int row = s.update("updatePasswordById", p);
	    s.close();
	    return row;
	}

}
