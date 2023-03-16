package com.mariadb.emp;

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

@WebServlet("/EmpProcess")
public class EmpProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EmpProcess() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		// 데이터를 select하고 화면설계가 가능하도록 jsp로 데이터를 전달
		String str = request.getParameter("action");
		if (str.equals("select")) {
			EmpDAO dao = new EmpDAO();
			ArrayList<EmpDTO> vec = new ArrayList<EmpDTO>();
			vec = dao.getRecords(1, 5);
			// System.out.println(vec);
			// 포워딩을 통해서 데이터를 넘기기 위해서 setAttribute 사용
			request.setAttribute("data1", vec);
			
			ServletContext context = this.getServletContext();
			// 디스패처를 얻을 때, 넘어갈 주소를 지정
			RequestDispatcher dispatcher = context.getRequestDispatcher("/15_showemp.jsp");
			// 포워딩할 때 데이터도 같이 전달
			dispatcher.forward(request, response);
		}
		else if (str.equals("insert")) {
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			float salary = Float.parseFloat(request.getParameter("salary"));
			
			// 데이터를 DTO에 담고
			EmpDTO dto = new EmpDTO();
			dto.setId(id);
			dto.setName(name);
			dto.setSalary(salary);
			
			EmpDAO dao = new EmpDAO();
			Boolean bool = dao.registerEmp(dto);
			PrintWriter out = response.getWriter();
			if (bool) {		// bool = true
				response.sendRedirect("./Success.html");
			}
			else {			// bool = false
				out.println("입력에 실패하였습니다.");
			}
		}
		
		else if (str.equals("update")) {
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			float salary = Float.parseFloat(request.getParameter("salary"));
			
			EmpDTO dto = new EmpDTO();
			dto.setId(id);
			dto.setName(name);
			dto.setSalary(salary);
			
			EmpDAO dao = new EmpDAO();
			Boolean bool = dao.updateEmp(dto);
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
			
			EmpDTO dto = new EmpDTO();
			dto.setName(name);
			
			EmpDAO dao = new EmpDAO();
			Boolean bool = dao.deleteEmp(dto);
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
