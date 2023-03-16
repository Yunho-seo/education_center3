package com.mariadb.student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;

import com.sungjuk.dbcp.*;
// 접속 클래스 : 쿼리를 실행하고 클래스 배열을 만들어서 리턴하는 역할
public class StudentDAO { // 데이터베이스에 접속(Emp를 담고 있는)
   public static Connection getConnection() {
      Connection con = null;
      con = new sungjuk_DbcpBean().getConn();  // DBCP로 관리되는 연결객체 중에 한개를 리턴
      return con;
   }
   // table로 저장 -> 클래스 저장(변환)
   public static ArrayList<StudentDTO> getRecords(int start, int total){
      ArrayList<StudentDTO> list = new ArrayList<StudentDTO>();
      try {
         Connection con = getConnection();
         // 쿼리문을 직접 데이터베이스에 전달할 때 사용(prepareStatement)
         PreparedStatement ps = con.prepareStatement("select name, kor, mat, eng from student limit "+(start-1)+", "+total );
         ResultSet rs = ps.executeQuery();
         while(rs.next()) {
        	StudentDTO s = new StudentDTO();
        	s.setName(rs.getString(1));
            System.out.println(rs.getString(1));
            s.setKor(rs.getInt(2));
            s.setMat(rs.getInt(3));
            s.setEng(rs.getInt(4));
            list.add(s);  // 클래스 배열
         }
         rs.close();
         con.close();
      } catch(Exception s) {
    	  System.out.println(s);
      }
      return list;
   }
   public boolean registerStudent(StudentDTO dto) throws ServletException{
	   Connection conn = getConnection();
	   String query = "insert into student(name, kor, mat, eng) values (?,?,?,?)";
	   try {
		   PreparedStatement psmt = conn.prepareStatement(query);
		   psmt.setString(1, dto.getName());
		   psmt.setInt(2, dto.getKor());
		   psmt.setInt(3, dto.getMat());
		   psmt.setInt(4, dto.getEng());
		   psmt.executeUpdate();
		   psmt.close();
		   conn.close();
	   } catch (SQLException ex) {
		   throw new ServletException("등록 실패!");
	   }
	   return true;
   }
   
   public boolean updateStudent(StudentDTO dto) throws ServletException {
	   Connection conn = getConnection();
	   String query = "update student set kor=?, mat=?, eng=?, where name=?";
	   try {
		   PreparedStatement pstmt = conn.prepareStatement(query);
		   pstmt.setString(1, dto.getName());
		   pstmt.setInt(2, dto.getKor());
		   pstmt.setInt(3, dto.getMat());
		   pstmt.setInt(4, dto.getEng());
		   pstmt.executeUpdate();
		   pstmt.close();
		   conn.close();
	   } catch (SQLException ex) {
		   throw new ServletException("수정 실패!");
	   }
	   return true;
   }
   
   public boolean deleteStudent(StudentDTO dto) throws ServletException {
	   Connection conn = getConnection();
	   String query = "delete from student where name=?";
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