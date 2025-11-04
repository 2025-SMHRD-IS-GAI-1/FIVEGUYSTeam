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
	
	public MemberVO find(String email) { // 20251104 cyonn 추가
		
		SqlSession sqlSession = factory.openSession(true);
		
		MemberVO vo = sqlSession.selectOne("find", email);
		
		sqlSession.close();
		
		return vo;
	}
}
