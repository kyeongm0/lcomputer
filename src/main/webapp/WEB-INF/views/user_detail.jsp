<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<sec:authorize access="isAuthenticated()">
	 		<table>
	 			<tr>
	 				<td>ID</td>
	 				<td>${user.username }</td>	
	 			</tr>
	 			<tr>
	 				<td>이름</td>
	 				<td>${user.uName }</td>
	 			</tr>
	 			<tr>
	 				<td>가입날짜</td>
	 				<td>${user.uDate }</td>
	 			</tr>
	 			<tr>
	 				<td>등급</td>
	 				<c:choose>
	 					<c:when test="${user.uLevel eq 1 }">
	 						<td>회원</td>
	 					</c:when>
	 					<c:when test="${user.uLevel eq 2 }">
	 						<td>관리자</td>
	 					</c:when>
	 				</c:choose>
	 			</tr>
	 		</table>
	 		
	 		<c:if test="${principal.uIdx eq user.uIdx }">
	 			<a href="/user/edit/${user.uIdx }">수정</a>
	 		</c:if>
	 		<c:if test="${principal.uIdx eq user.uIdx || principal.uIdx eq 2}">
	 			<a href="/user/delete/${user.uIdx }">삭제</a>
	 		</c:if>
	 		<c:if test="${principal.uLevel eq 2 }">
	 			<a href="/admin/level/${user.uIdx } ">등급</a>
	 		</c:if>
	 		<br><a href="/user/list">돌아가기</a>
	 	</sec:authorize>
	</div>
</body>
</html>