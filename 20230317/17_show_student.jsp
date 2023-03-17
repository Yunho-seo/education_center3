<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.lang.*, java.util.*, java.sql.*,
 	com.mariadb.sungjuk.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	ArrayList<SungjukDTO> list = new ArrayList<SungjukDTO>();

	list = (ArrayList<SungjukDTO>)request.getAttribute("Sungjuklist");
%>
<a href="http://localhost:8090/daejeon5/17_student_tabs.html"><h5>메뉴로</h5></a>
<h3> 학생 정보 </h3>
<table border=1>
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>국어</th>
		<th>수학</th>
		<th>영어</th>
		<th>총합</th>
		<th>평균</th>
		<th>학점</th>
		<th>학교코드</th>
	</tr>
	<%
		Iterator itr = list.iterator();
		while(itr.hasNext()) {							// 반복하여 출력하기 위해 while문 사용
			SungjukDTO dto = (SungjukDTO)itr.next();	// 타입을 모르기에 SungjukDTO로 캐스팅
	%>
	<tr>
		<td><%=dto.getBunho() %></td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getKor() %></td>
		<td><%=dto.getMat() %></td>
		<td><%=dto.getEng() %></td>
		<td><%=dto.getTotal() %></td>
		<td><%=dto.getAverage() %></td>
		<td><%=dto.getGrade() %></td>
		<td><%=dto.getSchoolcode() %></td>
	</tr>
	<%
		}
	%>
</table>
</body>
</html>