package com.mariadb.sungjuk;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;

@WebServlet("/SungjukServlet")
public class SungjukServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
           
    public SungjukServlet() {
        super();
    }
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String str = request.getParameter("action");
		
		if (str.equals("select")) {
			SungjukDAO dao = new SungjukDAO();
			ArrayList<SungjukDTO> list = new ArrayList<SungjukDTO>();
			list = dao.selectStudent();		// 화면 설계하는 JSP 페이지로 전달
			request.setAttribute("Sungjuklist", list);
			
			ServletContext context = this.getServletContext();
			RequestDispatcher dispatcher = context.getRequestDispatcher("/17_show_student.jsp");
			dispatcher.forward(request, response);
		}
		
		else if (str.equals("insert")) {
			String name = request.getParameter("name");
			int kor = Integer.parseInt(request.getParameter("kor"));
			int mat = Integer.parseInt(request.getParameter("mat"));
			int eng = Integer.parseInt(request.getParameter("eng"));
			String schoolcode = request.getParameter("schoolcode");	// "name", "kor" 등 이름은 form에서 받아옴
			
			// 데이터를 DTO에 담고 insertStudent()에 넣어야 한다 -> 인스턴스 (dao)
			SungjukDTO dto = new SungjukDTO();
			dto.setName(name);
			dto.setKor(kor);
			dto.setMat(mat);
			dto.setEng(eng);
			dto.setSchoolcode(schoolcode);
			
			SungjukDAO dao = new SungjukDAO();
			int result = dao.insertStudent(dto);
			if (result > 0) {
				response.sendRedirect("./Success.html");	// 성공
			}
			else {
				response.sendRedirect("./Fail.html");
			}
		}
		
		else if (str.equals("update")) {
			String name = request.getParameter("name");
			String chname = request.getParameter("chname");
			
			SungjukDTO dto = new SungjukDTO();
			dto.setChname(chname);
			dto.setName(name);
			
			SungjukDAO dao = new SungjukDAO();
			boolean bool = dao.updateStudent(dto);
			if (bool) {
				response.sendRedirect("./Success.html");	// 성공
			}
			else {
				response.sendRedirect("./Fail.html");
			}
		}
		
		else if (str.equals("delete")) {
			String name = request.getParameter("name");
			SungjukDTO dto = new SungjukDTO();
			dto.setName(name);
			SungjukDAO dao = new SungjukDAO();
			boolean bool = dao.deleteStudent(dto);
			if (bool) {
				response.sendRedirect("./Success.html");	// 성공
			}
			else {
				response.sendRedirect("./Fail.html");
			}
		}
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
