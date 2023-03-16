package com.mariadb.emp;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;

import com.daejeon.dbcp.*;
// 접속 클래스 : 쿼리를 실행하고 클래스 배열을 만들어서 리턴하는 역할
public class EmpDAO { // 데이터베이스에 접속(Emp를 담고 있는)
   public static Connection getConnection() {
      Connection con=null;
      con = new DbcpBean().getConn();  // DBCP로 관리되는 연결객체 중에 한개를 리턴
      return con;
   }
   // table로 저장 -> 클래스 저장(변환)
   public static ArrayList<EmpDTO> getRecords(int start, int total){
      ArrayList<EmpDTO> list = new ArrayList<EmpDTO>();
      try {
         Connection con = getConnection();
         // 쿼리문을 직접 데이터베이스에 전달할 때 사용(prepareStatement)
         PreparedStatement ps = con.prepareStatement("select ENPNO, ENAME, SAL from emp limit "+(start-1)+", "+total );
         ResultSet rs = ps.executeQuery();
         while(rs.next()) {
            EmpDTO e = new EmpDTO();
            e.setId(rs.getInt(1));  // 0부터 시작 안하고 1부터 시작함
            System.out.println(rs.getInt(1));
            e.setName(rs.getString(2));
            e.setSalary(rs.getFloat(3));
            list.add(e);  // 클래스 배열
         }
         rs.close();
         con.close();
      } catch(Exception e) {
    	  System.out.println(e);
      }
      return list;
   }
   public boolean registerEmp(EmpDTO dto) throws ServletException{
	   Connection conn = getConnection();
	   String query = "insert into emp(ENPNO, ENAME, SAL) values (?,?,?)";
	   try {
		   PreparedStatement psmt = conn.prepareStatement(query);
		   psmt.setInt(1, dto.getId());
		   psmt.setString(2, dto.getName());
		   psmt.setFloat(3,  dto.getSalary());
		   psmt.executeUpdate();
		   psmt.close();
		   conn.close();
	   } catch (SQLException ex) {
		   throw new ServletException("등록 실패!");
	   }
	   return true;
   }
   
   public boolean updateEmp(EmpDTO dto) throws ServletException {
	   Connection conn = getConnection();
	   String query = "update emp set ename=?, sal=? where enpno=?";
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(query);
		   pstmt.setString(1, dto.getName());
		   pstmt.setFloat(2, dto.getSalary());
		   pstmt.setInt(3,  dto.getId());
		   pstmt.executeUpdate();
		   pstmt.close();
		   conn.close();
	   } catch (SQLException ex) {
		   throw new ServletException("수정 실패!");
	   }
	   return true;
   }
   
   // 이름으로 삭제하도록 제한.
   // 입력, 수정, 삭제는 트랜잭션(Transaction)의 대상이고, 트리거(Trigger)의 대상이므로
   // executeUpdate() 으로 호출한다.
   public boolean deleteEmp(EmpDTO dto) throws ServletException {
	   Connection conn = getConnection();
	   String query = "delete from emp where ename=?";
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(query);
		   pstmt.setString(1, dto.getName());
		   pstmt.executeUpdate();
		   pstmt.close();
	   } catch (SQLException ex) {
		   throw new ServletException("삭제 실패!");
	   }
	   return true;
   }
}