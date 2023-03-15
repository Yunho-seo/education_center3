<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	// 웹서비스 구조상 자주 사용되는 request, response, page, pageContext, session, application
	// Cookie는 필요할 때 객체 인스턴스 해서 사용 (인스턴스 한다는 것은 메모리를 확보) (별도로 인스턴스 되지 않고 클래스 인스턴스해서 사용함)
	// 쿠키를 인스턴스 할 때에는 new Cookie("이름", 데이터);
	Cookie inname = new Cookie("inname", request.getParameter("inname"));
	Cookie inaddr = new Cookie("inaddr", request.getParameter("inaddr"));
	
	
	inname.setMaxAge(60*60*24);		// 쿠키의 기한 설정
	inaddr.setMaxAge(60*60*24);
	
	response.addCookie(inname);
	response.addCookie(inaddr);
%>
	<center>
		<h1>쿠키 세팅 완료</h1>
	</center>

</body>
</html>