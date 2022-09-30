<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시물 등록</h1>
		<hr>
		
		<form action="/board/reply/process" method="post">
			 <input type="hidden" name="bGroup" value="${board.bGroup }">
			 <input type="hidden" name="bOrder" value="${board.bOrder }">
			 <input type="hidden" name="bDepth" value="${board.bDepth }">
			 <input type="hidden" name="bOrigin" value="${board.bOrigin }">
			 <p>제목 : <textarea rows="1" cols="80" name="bTitle" placeholder="제목 입력"></textarea></p>
			 <p>내용 : <textarea rows="10" cols="80" name="bContent" placeholder="내용 입력"></textarea></p>
			 <button type="submit">작성하기</button>
		</form>
</body>
</html>