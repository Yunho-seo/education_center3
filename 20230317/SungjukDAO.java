package com.mariadb.sungjuk;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import com.daejeon.dbcp.DbcpSungjuk;	// 연결을 위해

// 접속 클래스
public class SungjukDAO {
	public static Connection getConnection() {
		Connection con = null;
		con = new DbcpSungjuk().getConn();
		return con;
	}
	public ArrayList<SungjukDTO> selectStudent() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<SungjukDTO> list = new ArrayList<SungjukDTO>();
		try {
			con = getConnection();
			ps = con.prepareStatement("select * from student");
			rs = ps.executeQuery();
			while(rs.next()) {
				SungjukDTO e = new SungjukDTO();		// 인스턴스 해주어야 데이터를 넣을 수 있음
				e.setBunho(rs.getInt(1));
				e.setName(rs.getString(2));
				e.setKor(rs.getInt(3));
				e.setMat(rs.getInt(4));
				e.setEng(rs.getInt(5));
				e.setTotal(rs.getInt(6));
				e.setAverage(rs.getFloat(7));
				e.setGrade(rs.getString(8));
				e.setSchoolcode(rs.getString(9));
				list.add(e);
			}
			rs.close();
			con.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return list;
	}
	
	public int insertStudent(SungjukDTO dto) throws ServletException {
		// 함수 내에서 선언되는 변수는 지역변수
		// 클래스 내에서 선언되는 변수는 멤버변수.
		Connection conn = null;
		PreparedStatement psmt = null;
		String query = "insert into student(name, kor, mat, eng, schoolcode)" + "values (?,?,?,?,?)";
		int result = 0;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(query);
			psmt.setString(1, dto.getName()); 	// 1번부터 시작 (getName이 1번부터)
			psmt.setInt(2, dto.getKor());
			psmt.setInt(3, dto.getMat());
			psmt.setInt(4, dto.getEng());
			psmt.setString(5, dto.getSchoolcode());
			result = psmt.executeUpdate();		// 변화된 개수만큼 숫자로 들어옴
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			try {
				psmt.close();
				conn.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	
	public boolean updateStudent(SungjukDTO dto) throws ServletException {
		Connection conn = getConnection();
		String query = "update student set name=? where name=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getChname());
			pstmt.setString(2, dto.getName());
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return true;
	}
	
	
	public boolean deleteStudent(SungjukDTO dto) throws ServletException {
		Connection conn = getConnection();
		String query = "delete from student where name=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getName());
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return true;
	}
}
