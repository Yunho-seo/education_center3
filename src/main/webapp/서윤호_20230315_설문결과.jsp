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
	int jumsu = 0;
	int total = 0;
	String level = "";
%>
<%
	for(int i=1; i<6; i++){
		String mind = request.getParameter("mind"+i);
		if(mind.equals("sel1")) {
			jumsu = 4;
		}
		else if(mind.equals("sel2")) {
			jumsu = 3;
		}
		else if(mind.equals("sel3")) {
			jumsu = 2;
		}
		else {
			jumsu = 1;
		}
		
		total += jumsu;
	}
	if(total > 15 ) {
		level = "프로젝트를 실행 하기에 완벽합니다.";
	}
	else if(total > 10) {
		level = "프로젝트를 실행 하기에 평범합니다.";
	}
	else {
		level = "프로젝트를 실행 하기에 부족합니다.";
	}
%>
<script>
	alert(<%=total%>)
</script>
<h1> 당신이 프로젝트에 돌입하기 좋은 상태인가? </h1>
<img src = "images/project.jpg" width="400" height="300" /> <br>
	당신의 현재상태는 다음과 같습니다. <br>
	<%=level %>
</body>
</html>