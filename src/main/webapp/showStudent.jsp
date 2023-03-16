<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.*, java.util.*, java.sql.*,
 com.mariadb.student.*, javax.sql.*, javax.naming.*, 
 java.io.UnsupportedEncodingException, java.text.SimpleDateFormat" %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   // 데이터를 넘겨받아 table로 변형해주면 됨
   ArrayList<StudentDTO> vec = new ArrayList<StudentDTO>();
   // 클래스는 heap에 저장(주소만 전달)
   vec = (ArrayList<StudentDTO>)request.getAttribute("data1");
%>
<center>
<br><br>
<h1>Student 회원데이터 출력</h1>
<br>
<table border=2>
   <tr>
      <th>이름</th>
      <th>국어</th>
      <th>수학</th>
      <th>영어</th>
   </tr>
   <% 
      Iterator iterator = vec.iterator();
      while(iterator.hasNext()){
    	  StudentDTO dto = (StudentDTO)iterator.next();
   %>
   <tr>
      <td><%=dto.getName() %></td>
      <td><%=dto.getKor() %></td>
      <td><%=dto.getMat() %></td>
      <td><%=dto.getEng() %></td>
   </tr>
   <%
   }
   %>
</table>
</body>
</html>