<%@ page contentType = "text/html; charset=UTF-8" %>
<html>
<head><title>1-10까지의 합</title></head>
<body>
<%	//스크립트 코드 블록 시작
	int sum = 0;
	for (int i = 1 ; i <= 10 ; i++) {
		sum = sum + i;
	}
//스크립트 코드 블록 끝%>
<!-- 표현식을 통해 변수 sum의 값 출력 -->
1 부터 10까지의 합은 <%=sum%> 입니다.
</body>
</html>
