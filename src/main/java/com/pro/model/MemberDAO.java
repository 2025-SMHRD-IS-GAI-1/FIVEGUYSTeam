package com.pro.model;

import java.util.List;

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
<<<<<<< HEAD

	public int changeemail(MemberVO mvo) {
=======
	
	public MemberVO find(MemberVO mvo) { // 20251104 cyonn 추가
		
		SqlSession sqlSession = factory.openSession(true);
		
		MemberVO vo = sqlSession.selectOne("find", mvo);
		
		sqlSession.close();
		
		return vo;
	}

  public int changeemail(MemberVO mvo) {
>>>>>>> 65f809291debd4450b5eb026b39fde2007fc6fe5
	

	
		SqlSession sqlSession = factory.openSession(true);
		
		int row = sqlSession.update("update", mvo);
		
		sqlSession.close();
		
		return row;
	}
	
	public int changePw(MemberVO mvo) {
		
		SqlSession sqlSession = factory.openSession(true);
		
		int row = sqlSession.update("update2", mvo);
		
		sqlSession.close();
		
		return row;
	}
	
	public int DeleteAccount(MemberVO mvo) {
		
		SqlSession sqlSession = factory.openSession(true);
		
		int row = sqlSession.delete("delete", mvo);
		
		sqlSession.close();
		
		return row;

	}
	
	public List<MemberVO> findAdmin() { 
		
		SqlSession sqlSession = factory.openSession(true);
		
		List<MemberVO> list = sqlSession.selectList("findAdmin");
		
		sqlSession.close();
		
		return list;
	}
}
