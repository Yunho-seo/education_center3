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

느긋하고, 창의적인 환경을 좋아하고, 그룹핑시 능력좋고, 은밀한 계획을 좋아하고, 즉각결정하는 특성이 있음
</body>
</html>