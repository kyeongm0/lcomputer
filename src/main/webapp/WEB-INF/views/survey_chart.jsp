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
	<div id = "answerChart">
		<h1>${survey.mainTitle }</h1>
		<h3>설문조사 참여 인원 수 : ${survey.count }</h3>
		
		<table>
			<tr>
				<td>작성자</td>
			</tr>
			<c:forEach var="user" items="${list }">
				<tr>
					<td><a href="/survey/detail/${survey.sIdx }/${user.uidx }">${user.name}</a><br></td>
				</tr>
			</c:forEach>
		</table>
		
		<table>
			<h3>통계</h3>
			<c:forEach var="i" begin="0" end="${survey.questionList.size() -1}" step="1">
				<tr>
					<td>${survey.questionList.get(i).title }</td>
					<td><button class="chart" qIdx=${survey.questionList.get(i).qIdx }>통계</button></td>
				</tr>
			</c:forEach>
		</table>
		
		<div>
			<ul>
				<li><a href="/survey/list">뒤로</a></li>
			</ul>
		</div>
	
		<script>
			$(document).on('click', '.chart', function () {
				let qIdx = $(this).attr('qIdx');
				console.log(qIdx);
				$.ajax({
					method: "POST",
				  	url: "/survey/chart",
				  	data: { qIdx: qIdx }
				});
				.done( function (page) {
					('#answerChart').html(page);
				});
			});
		</script>
	</div>
</body>
</html>