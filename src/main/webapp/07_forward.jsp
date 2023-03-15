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
	String name = "본인의 이름";		// 변수를 추가하는 경우
	String bloodType = request.getParameter("bloodType");	// Value가 전달
%>
<%-- 액션 태그를 이용해서 해당하는 혈액형을 jsp 페이지로 전달 --%>
<jsp:forward page ='<%=bloodType + ".jsp"%>'>
	<jsp:param name="name" value="<%=name%>"/>
</jsp:forward>
</body>
</html>