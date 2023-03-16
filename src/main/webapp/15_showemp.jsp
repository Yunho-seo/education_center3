<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.*, java.util.*, java.sql.*,
 com.mariadb.emp.*, javax.sql.*, javax.naming.*, 
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
   ArrayList<EmpDTO> vec = new ArrayList<EmpDTO>();
   // 클래스는 heap에 저장(주소만 전달)
   vec = (ArrayList<EmpDTO>)request.getAttribute("data1");
%>
<center>
<br><br>
<h1>EMP 회원데이터 출력</h1>
<br>
<table border=1>
   <tr>
      <th>번호</th>
      <th>이름</th>
      <th>급여</th>
   </tr>
   <% 
      Iterator iterator = vec.iterator();
      while(iterator.hasNext()){
      EmpDTO dto = (EmpDTO)iterator.next();
   %>
   <tr>
      <td><%=dto.getId() %></td>
      <td><%=dto.getName() %></td>
      <td><%=dto.getSalary() %></td>
   </tr>
   <%
   }
   %>
</table>
</body>
</html>