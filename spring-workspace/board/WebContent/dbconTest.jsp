<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="jdbc.connection.ConnectionProvider"%>
<%@ page import="java.sql.SQLException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연결 테스트</title>
</head>
<body>
	<%
	try {
		Connection conn = ConnectionProvider.getConnection();
		out.println("커넥션 연결 성공!");
	} catch (SQLException e) {
		out.println("커넥션 연결 실패: " + e.getMessage());
		application.log("커넥션 연결 실패", e);
	}
	%>
</body>
</html>