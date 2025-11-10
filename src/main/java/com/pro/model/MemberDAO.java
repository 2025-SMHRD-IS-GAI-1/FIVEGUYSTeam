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

	public MemberVO find(MemberVO mvo) { // 20251104 cyonn 추가

		SqlSession sqlSession = factory.openSession(true);

		MemberVO vo = sqlSession.selectOne("find", mvo);

		sqlSession.close();

		return vo;
	}

	public int changeemail(MemberVO mvo) {

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
	
public List<MemberVO> findAdmin2(String keyword) { 
		
		SqlSession sqlSession = factory.openSession(true);
		
		List<MemberVO> list = sqlSession.selectList("findAdmin2", keyword);
		
		sqlSession.close();
		
		return list;
	}

public int changePw2(MemberVO mvo) {
		
	SqlSession sqlSession = factory.openSession(true);
	
	int row = sqlSession.update("changePw",mvo);
	
	sqlSession.close();
	
	return row;
	
}

public int updateUser(MemberVO mvo) {
	SqlSession sqlSession = factory.openSession(true);
	
	int row = sqlSession.update("changeUserInfo",mvo);
	
	sqlSession.close();
	
	return row;
}
	
public List<MemberVO> search(String value) {
	
	SqlSession sqlSession = factory.openSession(true);
	
	List<MemberVO> list = sqlSession.selectList("search", value);
	
	sqlSession.close();
	return list;
}

public String Selectpw(String id) {

	SqlSession sqlSession = factory.openSession(true);
	
	String pw = sqlSession.selectOne("Selectpw", id);
	
	sqlSession.close();
	
	return pw;
}

public List<String> checkid() {
	
	SqlSession sqlSession = factory.openSession(true);
	
	List<String> list = sqlSession.selectList("checkid");
	
	sqlSession.close();
	
	return list;
}
public boolean existsId(String id) {
    SqlSession sqlSession = factory.openSession(true);
    
    int count = sqlSession.selectOne("existsId",id);
    sqlSession.close();
    return count > 0;
}
	

	
}