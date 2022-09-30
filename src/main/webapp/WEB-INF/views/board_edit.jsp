<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 수정</h1>
		<hr>
		
		<form action="/board/edit/process" method="post">
			<input type="hidden" name="bIdx" value="${board.bIdx }">
			<p>제목 : <textarea rows="1" cols="80" name="bTitle">${board.bTitle }</textarea></p>
			<p>내용 : <textarea rows="10" cols="80" name="bContent">${board.bContent }</textarea></p>
			<input type="hidden" name="bDate" value="${board.bDate }">
			<input type="hidden" name="bHits" value="${board.bHits }">
			<button type="submit">수정하기</button>
		</form>
</body>
</html>