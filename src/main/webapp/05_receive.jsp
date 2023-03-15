<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	out.println("환영: " + request.getParameter("uname"));
out.println("환영: " + request.getParameter("uname1"));
out.println("환영: " + request.getParameter("uname2"));
%>

<table width = "100%" border = "1" align = "center">
	<tr bgcolor = "#949494">
		<th>헤더 이름</th>
		<th> 헤더값 </th>
	</tr>
	<%-- 쿠키 정보, ip 정보, 포트(port) 정보 => Header에 포함 --%>
	<%
		Enumeration headerNames = request.getHeaderNames();
		while(headerNames.hasMoreElements()) {
			String paramName = (String)headerNames.nextElement();
			out.print("<tr><td>" + paramName + "</td>\n");
			String paramValue = request.getHeader(paramName);
			out.println("<td> " + paramValue + "</td></tr>\n");
	}
	%>


</table>
</body>
</html>