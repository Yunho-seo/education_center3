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
String arr[] = { "1. 과제를 할때 느끼는 난이도는 많이 높은가? ", "2. 당일 교육을 마치고 수업에 대한 이해는 충분한가? ",
				 "3. 당일 수강을 마치고 충분한 복습시간을 가지는가? ", "4. 소속된 조원과는 친밀한가? ",
				 "5. 프로젝트를 수행하기에 교육원의 기자재는 충분한가? " };

String answer[] = {"매우 그렇다", "그렇다", "아니다", "매우 아니다"};
// 채점을 위해서 점수를 정순서인지 역순서인지 결정하기 위함
int solve[] = { 2, 1, 1, 1, 1 };

int i = 1;
int j = 1;
int order = 0;
String groupname = "";		// 내부적인 문제 번호
String selname = "";		// 선택 번호
%>

<form method=post action="teamwork_back.jsp">
	<table border=1, bordercolor=yellow>
		<%
			for (String data:arr) {
				groupname = "mind" + i;		// 그룹번호 : 첫 설문의 이름은 mind1, mind2 ... mind6
		%>
		<tr>
			<td colspan=5>설문: "<%=data %>"	
			</td>
		</tr>
		<tr>
			<%
			for (String str : answer) {
				if(solve[i-1] == 1)	// 1, 2, 3, 4
					selname = "sel" + j;		// 응답 구분 (ex. sel1, sel2 ..)
				else {
					order = 5-j;	// 4, 3, 2, 1
					selname = "sel" + order;	
				}
			%>
			<td><input type="radio" name=<%=groupname %> value=<%=selname %>>
			<label><%=str %></label></td>
			<%
				j += 1;
			}
			%>
		</tr>
		<%
			j = 1;		// 다음 문제를 출력하기 위해서 초기화 (내부 번호)
			i += 1;		// 다음 문제번호로 넘기기
		}
		%>
	</table>
	<input type="submit" value="submit" />
</form>
</body>
</html>