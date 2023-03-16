package com.mariadb.student;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/StudentProcess")
public class StudentProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public StudentProcess() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		// 데이터를 select하고 화면설계가 가능하도록 jsp로 데이터를 전달
		String str = request.getParameter("action");
		
		if (str.equals("select")) {
			StudentDAO dao = new StudentDAO();
			ArrayList<StudentDTO> vec = new ArrayList<StudentDTO>();
			vec = dao.getRecords(1, 6);
			// System.out.println(vec);
			// 포워딩을 통해서 데이터를 넘기기 위해서 setAttribute 사용
			request.setAttribute("data1", vec);
			
			ServletContext context = this.getServletContext();
			// 디스패처를 얻을 때, 넘어갈 주소를 지정
			RequestDispatcher dispatcher = context.getRequestDispatcher("/showStudent.jsp");
			// 포워딩할 때 데이터도 같이 전달
			dispatcher.forward(request, response);
		}
		
		else if (str.equals("insert")) {
			String name = request.getParameter("name");
			int kor = Integer.parseInt(request.getParameter("kor"));
			int mat = Integer.parseInt(request.getParameter("mat"));
			int eng = Integer.parseInt(request.getParameter("eng"));
			
			// 데이터를 DTO에 담고
			StudentDTO dto = new StudentDTO();
			dto.setName(name);
			dto.setKor(kor);
			dto.setMat(mat);
			dto.setEng(eng);
			
			StudentDAO dao = new StudentDAO();
			Boolean bool = dao.registerStudent(dto);
			PrintWriter out = response.getWriter();
			if (bool) {		// bool = true
				response.sendRedirect("./Success.html");
			}
			else {			// bool = false
				out.println("입력에 실패하였습니다.");
			}
		}
		
		else if (str.equals("update")) {
			String name = request.getParameter("name");
			int kor = Integer.parseInt(request.getParameter("kor"));
			int mat = Integer.parseInt(request.getParameter("mat"));
			int eng = Integer.parseInt(request.getParameter("eng"));
			
			StudentDTO dto = new StudentDTO();
			dto.setName(name);
			dto.setKor(kor);
			dto.setMat(mat);
			dto.setEng(eng);
			
			StudentDAO dao = new StudentDAO();
			Boolean bool = dao.updateStudent(dto);
			PrintWriter out = response.getWriter();
			if (bool) {		// bool = true
				response.sendRedirect("./Success.html");
			}
			else {			// bool = false
				out.println("수정에 실패하였습니다.");
			}
		}
		
		else if (str.equals("delete")) {
			String name = request.getParameter("name");
			
			StudentDTO dto = new StudentDTO();
			dto.setName(name);
			
			StudentDAO dao = new StudentDAO();
			Boolean bool = dao.deleteStudent(dto);
			PrintWriter out = response.getWriter();
			if (bool) {		// bool = true
				response.sendRedirect("./Success.html");
			}
			else {			// bool = false
				out.println("삭제에 실패하였습니다.");
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}