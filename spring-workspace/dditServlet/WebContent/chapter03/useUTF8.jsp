<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%
Date now = new Date();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재 시간</title>
</head>
<body>
	<!-- JSP페이지를 UTF-8로 만들고, 응답 결과도 UTF-8로 생성 -->
	현재 시각:
	<%=now%>
</body>
</html>