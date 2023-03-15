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
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String bloodType = request.getParameter("bloodType");
%>
당신의 이름은 <%=name %>이고요 <br>
<b><%=bloodType %></b>형이고 <br>

할때 하고, 놀때 놀자. 코로나에 강함.
</body>
</html>