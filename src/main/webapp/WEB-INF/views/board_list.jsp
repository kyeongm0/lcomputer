<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	li {
		list-style:none;
		width:50px;
		line-height:30px;
		border:1px solid #ededed;
		float:left;
		text-align:center;
		margin:0 5px;
		border-radius:5px;
	}
</style>
</head>
<body>
<h1>게시판</h1>
	<div>
		<sec:authorize access="isAuthenticated()">
	 		<table>
	 			<tr>
	 				<td>NO</td>
	 				<td>제목</td>
	 				<td>내용</td>
	 				<td>작성일자</td>
	 				<td>작성자</td>
	 				<td>조회수</td>
	 			</tr>
	 			<c:forEach var="board" items="${list }">
	 				<tr>
	 					<td>${board.rownum }</td>
	 					<td><a href="/board/detail/${board.bIdx}">${board.bTitle }</a></td>
	 					<td>${board.bContent }</td>
	 					<td>${board.bDate}</td>
	 					<td>${board.user.uName }</td>
	 					<td>${board.bHits }</td>
	 				</tr>
	 			</c:forEach>
	 		</table>
	 	</sec:authorize>
	</div>
	<div>
		<ul>
			<c:choose>			
				<c:when test="${pagination.prevPage lt 0 }">
					<li style="display:none;"><span>◀</span></li>
				</c:when>
				
				<c:when test="${pagination.prevPage lt pagination.startPage }">
					<li>
						<a href="/board/list/${pagination.prevPage }">◀</a>
					</li>
				</c:when>
			</c:choose>
			
			<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage }" step="1">
				<c:choose>
					<c:when test="${pagination.page eq i }">
						<li style="background-color:#ededed;">
							<span>${i }</span>
						</li>
					</c:when>
					<c:when test="${pagination.page ne i }">
						<li>
							<a href="/board/list/${i }">${i }</a>
						</li>
					</c:when>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${pagination.nextPage le pagination.lastPage }">
					<li style="">
						<a href="/board/list/${pagination.nextPage }">▶</a>
					</li>
				</c:when>
			</c:choose>
		
		</ul>
	</div>
	<br>
	<div>
	<br>
	<form action="/board/list" name="boardSearch" method="get"> 
		<select name="bSearch">
			<option value="1">제목</option>
			<option value="2">제목+내용</option>
			<option value="3">작성자</option>
		</select>	
		<input type="text" name="bKeyword" value="${pagination.search.bKeyword }">
		<input type="submit" value="검색">
		</form>
	</div>
	<div>
		<ul>
			<li>
				<a href="/board/insert">등록</a>
			</li>
			<li>
				<a href="/">뒤로</a>
			</li>
		</ul>
	</div>
</body>
</html>