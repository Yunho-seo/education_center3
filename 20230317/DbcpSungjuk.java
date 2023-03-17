package com.daejeon.dbcp;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// 접속
public class DbcpSungjuk {
	   private Connection conn; // 연결객체
	   public DbcpSungjuk() {	// 생성자에서 초기화
	      try {
	    	 // Context : Tomcat 차원에서 관리되는 자원
	         Context initContext = new InitialContext(); // 자원관리 객체
	         Context envContext = (Context)initContext.lookup("java:/comp/env");
	         DataSource ds = (DataSource)envContext.lookup("jdbc/sungjuk");  // Context
	         conn = ds.getConnection();  // DBCP(database connection pool)
	         System.out.println("DbcpBean 작업성공!");
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	   }
	   public Connection getConn() {		// 얻은 것을 리턴
		   return conn;
	}
}