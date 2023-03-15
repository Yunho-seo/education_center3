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
String arr[] = { "1. 다른 사람들에게 자신을 소개하는 것을 어려워합니다. ", "2. 종종 주변을 무시하거나 잊어 버리는 생각에 빠지곤 합니다. ",
		"3. 이메일에 가능한 빨리 회신하려고 하고 지저분한 편지함을 참을 수 없습니다 ", "4. 중압감을 받을 때에도 쉽게 침착하게 집중력을 유지할 수 있습니다.  ",
		"5. 보통 대화를 먼저 시작하지 않습니다. ", "6. 순전히 호기심 때문에 행동을 하는 경우는 거의 없습니다." };

String ans[] = {"매우 그렇다", "그렇다", "보통이다", "아니다", "매우 아니다"};
// 채점을 위해서 점수를 정순서인지 역순서인지 결정하기 위함
int solve[] = { 1, 1, 1, 2, 1, 2};

int i = 1;
int j = 1;
int order = 0;
String groupname = "";		// 내부적인 문제 번호
String selname = "";		// 선택 번호
%>

<form method=post action="09_설문응답.jsp">
	<table border=1>
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
			for (String str : ans) {
				if(solve[i-1] == 1)	// 1, 2, 3, 4, 5
					selname = "sel" + j;		// 응답 구분 (ex. sel1, sel2 ..)
				else {
					order = 6-j;	// 5, 4, 3, 2, 1
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