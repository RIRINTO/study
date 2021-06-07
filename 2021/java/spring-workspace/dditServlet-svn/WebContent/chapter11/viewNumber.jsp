<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="elfunc" uri="/WEB-INF/tlds/el-functions.tld" %>
<%
	request.setAttribute("price", 12345);
%>
<!DOCTYPE html>
<html>
<head>
<title>EL 함수 호출</title>
</head>
<body>
가격은 <b>${elfunc:formatNumber(price,'#,##0')}</b>
</body>
</html>