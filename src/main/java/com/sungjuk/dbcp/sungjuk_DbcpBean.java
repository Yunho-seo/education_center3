// Emp 뿐만 아니라 다른 테이블에도 접근해야 하는데, 접근하는 방법은 똑같으므로
// 별도의 클래스를 만들어 놓음

package com.sungjuk.dbcp;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class sungjuk_DbcpBean {
	   private Connection conn; // 연결객체
	   public sungjuk_DbcpBean() {
	      try {
	         Context initContext = new InitialContext(); // 자원관리 객체
	         // 자원을 만들면 이 디렉토리에 생성해놓음
	         Context envContext = (Context)initContext.lookup("java:/comp/env");
	         DataSource ds = (DataSource)envContext.lookup("jdbc/mariasungjuk");  // Context.
	         conn = ds.getConnection();  // DBCP(database connection pool)
	         System.out.println("DbcpBean 작업성공!");
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	   }
	   public Connection getConn() {
		   return conn;
	}
}