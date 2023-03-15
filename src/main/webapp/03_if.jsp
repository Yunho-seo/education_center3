<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 블록문 안에 태그(tag)를 이용하여 출력이 가능 --%>
<%! int day = 3; %>
<% if (day == 1 | day == 7) { %>
	<p> 오늘은 주말 입니다. </p>
	<p> 조건이 맞아 출력되는 것
<% } else  { %>
	<p> 오늘은 주말이 아닙니다. </p>
<% } %>

<%
	switch(day) {
	case 0: out.println("오늘은 Sunday."); break;
	case 1: out.println("오늘은 Monday."); break;
	case 2: out.println("오늘은 Tuesday."); break;
	case 3: out.println("오늘은 Wednesday."); break;
	case 4: out.println("오늘은 Thursday."); break;
	case 5: out.println("오늘은 Friday."); break;
	case 6: out.println("오늘은 Saturday."); break;
	}
%>
</body>
</html>