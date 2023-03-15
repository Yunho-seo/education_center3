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
		int survey1 = Integer.parseInt(request.getParameter("survey1"));
		int survey2 = Integer.parseInt(request.getParameter("survey2"));
		int survey3 = Integer.parseInt(request.getParameter("survey3"));
		int survey4 = Integer.parseInt(request.getParameter("survey4"));
		int survey5 = Integer.parseInt(request.getParameter("survey5"));
		int survey6 = Integer.parseInt(request.getParameter("survey6"));
	
		int result = survey1 + survey2 + survey3 + survey4 + survey5 + survey6;
		out.println("전체 점수는 " + result + "점 입니다.");
		if(result >= 13) {
			if(result > 18) {
				out.println("생활에 어려움이 있습니다.");
			} else {
				out.println("생활 상태 보통");
			}
		} else {
			out.println("생활 상태 양호");
		}
		
	%>
</body>
</html>