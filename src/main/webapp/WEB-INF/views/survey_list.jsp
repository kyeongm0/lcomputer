<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<div id="surveyList">
		<h1>설문조사 리스트</h1>
		<table>
			<tr>
				<td>제목</td>
				<td>설명</td>
			</tr>
			<c:forEach var="survey" items="${list }">
				<tr>
					<td><a href="/survey/tool/${survey.sIdx }">${survey.mainTitle }</a></td>
					<td>${survey.subTitle }</td>
					<td><a href="/survey/admin/${survey.sIdx }">관리</a></td>
				</tr>
			</c:forEach>
		</table>
		<div>
			<ul>
				<li>
					<a href="/survey">만들기</a>
				</li>
				<li>
					<a href="/">뒤로</a>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>