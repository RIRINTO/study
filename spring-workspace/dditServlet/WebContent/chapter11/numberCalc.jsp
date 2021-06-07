<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL의 수치 연산자</title>
</head>
<body>
	1. 수치 연산자는 정수 타입과 실수 타입에 대해서만 동작함.
	<br />숫자 타입과 객체를 수치 연산자와 함게 사용하는 경우 해당 객체를 숫자로 변환한 후 연산을 수행
	<br />
	<br />"10" + 1의 결과는? ${"10" + 1}
	<br />"10" + "1"의 결과는? ${"10" + "1"}

	<!-- error												-->
	<%-- <br />"10" + "1" + "개"의 결과는? ${"10" + "1" + "개"}	--%>
	<br />
	<br />
	<font color="red">EL에서 + 연산자는 수치 연산자</font>이므로 "10"을 숫자로 먼저 변환하고 그 다음에 연산을 수행.
	<br />따라서 결과는 문자열 "101"이 아니라 숫자 11이 됨
	<br />
	<br />숫자로 변환할 수 없는 객체와 수치 연산자를 함께 사용하면 오류가 발생함
	<br />
	<!-- "일"+10 -->
	<br />
	<font color="red">수치 연산자에서 사용되는 피연산자가 null이면 0으로 처리됨</font>
	<%-- <br />null + 1의 결과는? ${null + 1}					--%>
	<br />
	<br />자바에서 3 / 2는 정수 타입 간의 나누기 연산이므로 결과가 1이 되지만,
	<br />
	<font color="red">EL에서의 3 / 2는 3과 2를 Double로 변환한 뒤</font> 연산을 수행하므로 연산 결과는 1.5가 됨
	<br />3 / 2의 결과는? ${3 / 2}
</body>
</html>