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
	<h1>회원 목록</h1>
	<div>
		<sec:authorize access="isAuthenticated()">
	 		<table>
	 			<tr>
	 				<td>NO</td>
	 				<td>ID</td>
	 				<td>이름</td>
	 				<td>가입날짜</td>
	 			</tr>
	 			<c:forEach var="list" items="${list }">
	 				<tr>
	 					<td>${list.rownum }</td>
	 					<td><a href="/user/detail/${list.uIdx }">${list.username }</a></td>
	 					<td>${list.uName }</td>
	 					<td>${list.uDate }</td>
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
						<a href="/user/list/${pagination.prevPage }">◀</a>
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
							<a href="/user/list/${i }">${i }</a>
						</li>
					</c:when>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${pagination.nextPage le pagination.lastPage }">
					<li style="">
						<a href="/user/list/${pagination.nextPage }">▶</a>
					</li>
				</c:when>
			</c:choose>
		
		</ul>
	</div>
	<br>
	<div>
		<ul>
			<li>
				<a href="/">뒤로</a>
			</li>
		</ul>
	</div>
</body>
</html>