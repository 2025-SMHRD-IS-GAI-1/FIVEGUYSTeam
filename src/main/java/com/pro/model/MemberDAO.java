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
	public int changeemail(MemberVO mvo) {
	
	SqlSession sqlSession = factory.openSession(true);
	
	int row = sqlSession.update("update", mvo);
	
	sqlSession.close();
	
	return row;
	}
	
	public int DeleteAccount(MemberVO mvo) {
		
		SqlSession sqlSession = factory.openSession(true);
		
		int row = sqlSession.delete("delete", mvo);
		
		sqlSession.close();
		
		return row;
	}
}
