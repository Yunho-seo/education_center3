<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	// request, response, out, session, application (내장객체, 자동으로 활성화)
	Integer hitsCount = (Integer)application.getAttribute("hitCounter");
	if (hitsCount == null || hitsCount == 0) {
		out.println("웹사이트 방문을 축하합니다.!");
		hitsCount = 1;
	} else {
		out.println("다시 방문을 한 것을 환영합니다.!");
		hitsCount += 1;
	}
	application.setAttribute("hitCounter", hitsCount);
%>
	<center>
		<p>총 방문횟수: <%=hitsCount %></p>
	</center>
</body>
</html>