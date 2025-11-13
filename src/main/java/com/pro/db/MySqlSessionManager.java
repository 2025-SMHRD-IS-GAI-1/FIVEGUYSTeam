package com.pro.db;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MySqlSessionManager {

	static SqlSessionFactory sqlSessionFactory;

	static {
//		String resource = "com/pro/db/mybatis-config.xml";
		String resource = "mybatis-config.xml";
		InputStream inputStream;

		try {
			inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
			// SqlSession == Connection
//		   SqlSessionFactory == DBCP(Data Base Connection Pool)
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

//	DBCP를 리턴하는 메소드 생성
	public static SqlSessionFactory getFactory() {
		return sqlSessionFactory;
	}

}
