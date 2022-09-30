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
		
		<form action="/board/insert/process" enctype="multipart/form-data" method="post">
			 <input type="hidden" name="uIdx" value="${board.uIdx }">
			 <p>제목 : <textarea rows="1" cols="80" name="bTitle" placeholder="제목 입력"></textarea></p>
			 <p>내용 : <textarea rows="10" cols="80" name="bContent" placeholder="내용 입력"></textarea></p>
			 <p>파일 : <input type="file" name="uploadFile" multiple="multiple"></p>
			 <button type="submit">작성하기</button>
		</form>
</body>
</html>