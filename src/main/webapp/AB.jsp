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

기분과 환경 적응력이 불규칙하고 변화무쌍하나 문제해결력이 뛰어남
</body>
</html>