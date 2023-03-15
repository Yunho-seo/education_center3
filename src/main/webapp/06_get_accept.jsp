<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><p><b>이름:</b>
		<%= request.getParameter("name") %>
		</p></li>
	</ul>
	<!-- 문제 : 두 수를 입력받아서 합한 다음 출력 -->
	<%
		int num1 = Integer.parseInt(request.getParameter("num1"));
		int num2 = Integer.parseInt(request.getParameter("num2"));
		int num3 = num1+num2;
		
		out.println("두 수의 합은 " + num3);
	%>
</body>
</html>