package com.pro.menu.model;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.db.MySqlSessionManager;
import com.pro.model.MemberVO;


public class MenuDataDAO {
	
	private SqlSessionFactory factory = MySqlSessionManager.getFactory();
	
	public int insertImage(ImageVO image) throws SQLException {
    	SqlSession sqlSession = factory.openSession(true);
		int row = sqlSession.insert("insertImage", image);
		sqlSession.close();
		return row;
    }	
	public int insertTranslations(List<TranslationVO> translations) {
		SqlSession sqlSession = factory.openSession(true);
		int row = sqlSession.insert("insertTranslations", translations);
		sqlSession.close();
		return row;
	}
	public int insertTranslation(TranslationVO translation) {
		SqlSession sqlSession = factory.openSession(true);
		int row = sqlSession.insert("insertTranslation", translation);
		sqlSession.close();
		return row;
	}
	
	public List<ImageVO> getImages(String id){
		// 20251107 cyonn 생성
		SqlSession sqlSession = factory.openSession(true);
		
		List<ImageVO> list = sqlSession.selectList("getImages", id);
		
		sqlSession.close();
		
		return list;
	}
	public byte[] getImageFile(String imgId) {
		// 20251111 cyonn 생성
        SqlSession session = factory.openSession(true);
        
        byte[] imageData = null;
        try {
            // 위에서 만든 "getImageBytes" 쿼리 실행
        	imageData = session.selectOne("getImageFile", imgId);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return imageData;
    }
	
	public List<TranslationVO> getTranslations(String imgId){
		// 20251110 cyonn 생성
		SqlSession sqlSession = factory.openSession(true);
		
		List<TranslationVO> list = sqlSession.selectList("getTranslations", imgId);
		
		sqlSession.close();
		
		return list;
	}
	public int updateImage(ImageVO image) {
		// 20251111 cyonn 생성
		SqlSession sqlSession = factory.openSession(true);
		int row = sqlSession.update("updateImage", image);
		sqlSession.close();
		return row;
	}
}