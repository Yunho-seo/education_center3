package com.daejeon.main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;

@WebServlet("/HelloForm")	// Get방식으로 요청하면 자동으로 실행(호출)하는 함수. Servlet implementation class HelloForm
public class HelloForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public HelloForm() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();		// response에서 출력객체인 PrintWriter 열기
		String title = "form 데이터를 get으로 받기 ";
		String docType = "<!docType html>\n";
		String first_name = (String)request.getParameter("first_name");
		String address = (String)request.getParameter("address");
		out.println(docType +
					"<html>\n" +
					"<head><title>" + title + "</title></head>\n" +
					"<body bgcolor=\"#f0f0f0\">\n" +
					"<h1 align=\"center\">" + title + "</h1>\n" +
					"<ul>\n" +
					"  <li><b>name</b>: "
					+ first_name + "\n" +
					"  <li><b>address</b>: "
					+ address + "\n" +
					"</ul>\n" +
					"</body></html>");		
	}

}
