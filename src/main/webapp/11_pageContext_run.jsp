<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- pageContext : page(servlet을 의미)에서 내장객체를 사용할 때 호출 -->
<%
	String name=request.getParameter("uname");
	out.print("Welcome " + name);
	
	pageContext.setAttribute("user", name, PageContext.SESSION_SCOPE);
%>
</body>
</html>