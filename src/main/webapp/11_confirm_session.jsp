<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 일반화된 프로그램. 즉 session, application, request나 동일하게 접근해서 작업하고 싶은 경우
	String name = (String)pageContext.getAttribute("user", PageContext.SESSION_SCOPE);
	out.print("Hello " + name); 
	
	// session
	String name2 = (String)session.getAttribute("user");
	out.print("Hello " + name2);
%>
</body>
</html>