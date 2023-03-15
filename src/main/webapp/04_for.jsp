<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 2x3 행렬(2차원 배열)로 출력 --%>
<table border=1><tr>
<%
	String arr[][] = {{"대전시", "충주시", "서울시"}, {"주민1", "주민2", "주민3"}};
	for (String data[] : arr) {
		out.println(data.length + "<br>");
		for (String str : data) {
			%>
			<td><%=str %></td>
			<%
		}
		%>
		</tr><tr>
		<%
	}
%>
</tr></table>
<%
	float f = 2.5f;
	int i = Math.round(f);
	java.util.Date date = new java.util.Date();
%>
반올림: <%= i %> <br>
현재 날짜: <%= date.toString() %> <br>
시간: <%= date.getHours() %>

</body>
</html>