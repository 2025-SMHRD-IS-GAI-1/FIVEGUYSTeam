package com.pro.menu.model;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.pro.db.MySqlSessionManager;


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
}