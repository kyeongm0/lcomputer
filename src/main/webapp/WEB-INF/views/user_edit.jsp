<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 수정</h1>
		<hr>
		
		<form action="/user/edit/process" method="post">
			<input type="hidden" name="uIdx" value="${user.uIdx }">
			<input type="text" name="username" value="${user.username }">
			<input type="password" name="password" value="${user.password }">
			<input type="text" name="uName" value="${user.uName }">
			<input type="hidden" name="uDate" value="${user.uDate }">
			<button type="submit">수정하기</button>
		</form>
</body>
</html>