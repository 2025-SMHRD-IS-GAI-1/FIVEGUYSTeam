package com.smhrd.model;

import java.lang.reflect.Member;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.MySqlSessionManager;

public class MemberDAO {

	// DB에 연결하기 위한 기본적인 작업(SqlSesstionFactory, sqlSession)을
	// 수행할 수 있는 클래스!
	// WEB_MEMBER 테이블을 사용하여 작업할 수 있는 모든 기능을
	// 하나의 클래스에서 관리하기 위해 생성!
	// → WEB_MEMBER 테이블의 작업!
	// : 회원 가입, 로그인, 회원정보수정, 회원 탈퇴, 회원의 목록 조회, ...
	
	// 필드영역
	// DBCP를 만드는 공장 꺼내오기
	private SqlSessionFactory factory = MySqlSessionManager.getFactory();
	
	// 회원 가입을 위한 메소드! → DB에 필요한 정보 전달!
	public int join(MemberVO mvo) {
		// DB에 대한 Mapper.xml 파일 연결!
		// → Mapper.xml → insert sql 구문 작업!
	
		// 1. Connection 객체(SqlSession)를 빌려오기
		// openSession(true) → insert, delete, update와 같은 구문을 실행후에 자동으로 commit 해주는 방법
			SqlSession sqlSession = factory.openSession(true);
		// 2. 사용하기
		// sqlSession.insert("sql구문의 id값", Mapper.xml 파일에 전달해야하는 데이터);
			int row = sqlSession.insert("join", mvo);
		// 3. 반납하기
			sqlSession.close();
		// 4. 결과값을 리턴하기
			return row;
		
	}
	
	public MemberVO login(MemberVO mvo) {
		// login에 대한 여부가 판단 된다면 해당 회원의 정보를 다시 받아 돌아오기~!
		SqlSession sqlSession = factory.openSession(true);
		MemberVO info = sqlSession.selectOne("login", mvo);
		sqlSession.close();
		return info;
	}
	
	public List<MemberVO> selectAll() {
		// 1. SqlSession 빌려오기
		SqlSession sqlSession = factory.openSession(true);
		// 2. 사용하기
		List<MemberVO> list = sqlSession.selectList("selectAll");
		// 3. 반납하기
		sqlSession.close();
		// 4. 결과값을 리턴하기
		return list;
	}
	
	
	
}
