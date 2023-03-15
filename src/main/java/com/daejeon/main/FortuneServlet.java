package com.daejeon.main;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.Random;
// 서블릿(servlet) : 클라이언트에서 요청하는 request를 처리하는 객체
// HttpServlet을 상속받은 후, 정해진 함수를 오버라이딩하면 자동으로 호출
// 그 역할을 하는 것이 Tomcat
// fortuneServlet Fortune = new FortuneServlet();
// Fortune 이름이 곧 인스턴스 이름이 된다.

@WebServlet("/Fortune")		// 어노테이션(@WebServlet) -> Fortune 이라는 이름으로 FortuneServlet를 인스턴스
public class FortuneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public FortuneServlet() {
        super();
    }

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 출력을 하기 위해
		response.setCharacterEncoding("utf-8");
		// MIME type (아랫단부터는 텍스트로 넘어가지만 html로 해석)
		response.setContentType("text/html;charset=utf-8");
		String[] list = { "즐거운 일주일의 시작이니 맘잘먹으면 좋은일 있을거예요",
						  "행복하게 생각해서 행복한 날",
						  "행복은 습관이다. 습관처럼 행복해지기" };		// [0], [1], [2] 중 하나가 랜덤으로 호출
		int index = new Random().nextInt(3);
		String fortune = list[index];
		// response.getWriter()을 이용하여, out을 얻어와야 함
		PrintWriter out = response.getWriter();
		out.println("<!doctype html>"+"<html>"+"<head>");
		out.println("<meta charset='utf-8' />");
		out.println("<title>오늘의 선택 페이지</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<p>"+ fortune +"</p>");
		out.println("</body>");
		out.println("</html>");
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
