package com.smhrd.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.smhrd.db.MySqlSessionManager;

public class MemberDAO {

    // DBCP 팩토리
    private SqlSessionFactory factory = MySqlSessionManager.getFactory();

    // 회원가입
    public int join(MemberVO mvo) {
        SqlSession sqlSession = factory.openSession(true);
        int row = sqlSession.insert("join", mvo);
        sqlSession.close();
        return row;
    }

    // 로그인
    public MemberVO login(MemberVO mvo) {
        SqlSession sqlSession = factory.openSession(true);
        MemberVO info = sqlSession.selectOne("login", mvo);
        sqlSession.close();
        return info;
    }

    // 전체 조회(관리용)
    public List<MemberVO> selectAll() {
        SqlSession sqlSession = factory.openSession(true);
        List<MemberVO> list = sqlSession.selectList("selectAll");
        sqlSession.close();
        return list;
    }

    // 1명 조회 (이메일)
    public MemberVO selectByEmail(String email) {
        SqlSession sqlSession = factory.openSession(true);
        MemberVO vo = sqlSession.selectOne("selectByEmail", email);
        sqlSession.close();
        return vo;
    }

    // 프로필(연락처/주소) 수정
    public int updateProfile(MemberVO vo) {
        SqlSession sqlSession = factory.openSession(true);
        int row = sqlSession.update("updateProfile", vo);
        sqlSession.close();
        return row;
    }

    // 비밀번호 변경
    public int updatePassword(String email, String newPw) {
        SqlSession sqlSession = factory.openSession(true);
        MemberVO vo = new MemberVO();
        vo.setEmail(email);
        vo.setPw(newPw);
        int row = sqlSession.update("updatePassword", vo);
        sqlSession.close();
        return row;
    }

    /* ====== 여기서부터 추가된 메소드들 (이메일 변경/탈퇴) ====== */

    // 신규 이메일 중복 개수
    public int countByEmail(String email) {
        SqlSession s = factory.openSession(true);
        int cnt = s.selectOne("countByEmail", email);
        s.close();
        return cnt;
    }

    // 현재 비밀번호 조회 (이메일로)
    public String selectPwByEmail(String email) {
        SqlSession s = factory.openSession(true);
        String pw = s.selectOne("selectPwByEmail", email);
        s.close();
        return pw;
    }

    // 이메일 변경 (부모 테이블만) — 자식 테이블 쓰면 별도 매퍼로 같이 업데이트 필요
    public int changeEmail(String oldEmail, String newEmail) {
        SqlSession s = factory.openSession(true); // 부모만 바꿀 거면 autocommit OK
        Map<String, String> p = new HashMap<>();
        p.put("oldEmail", oldEmail);
        p.put("newEmail", newEmail);
        int row = s.update("updateEmail", p);
        s.close();
        return row;
    }

    // 회원 탈퇴(소프트 삭제: DEL_YN='Y')
    public int softDelete(String email, String pw) {
        SqlSession s = factory.openSession(true);
        Map<String, String> p = new HashMap<>();
        p.put("email", email);
        p.put("pw", pw);
        int row = s.update("softDelete", p);
        s.close();
        return row;
    }
}
