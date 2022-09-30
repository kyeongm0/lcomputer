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
</head>
<body>
	<fieldset>
		<div id="surveyTitle">
			<h1>${survey.mainTitle }</h1>
			<p>${survey.subTitle }</p>
		</div>
	</fieldset>
	
	<c:forEach var="question" items="${survey.questionList }">
		<c:choose>
			<c:when test="${question.surveyType == 1 }">
				<fieldset>
					<div class="multiOption">
						<input type="hidden" class="multiQuestion" value="${question.qIdx }">
						<div>
							<h3>${question.title }</h3>
						</div>
						<c:forEach var="answer" items="${question.answerList }">
							<div>
								<c:out value="${answer.value }"/>
							</div>
						</c:forEach>
					</div>
				</fieldset>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${question.surveyType == 2 }">
				<fieldset>
					<div class="short">
					<input type="hidden" class="shortQuestion" value="${question.qIdx }">
						<div>
							<h3>${question.title }</h3>
						</div>
						<c:forEach var="answer" items="${question.answerList }">
							<div>
								<c:out value="${answer.value }"/>
							</div>
						</c:forEach>			
					</div>
				</fieldset>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${question.surveyType == 3 }">
				<fieldset>
					<div class="long">
					<input type="hidden" class="longQuestion" value="${question.qIdx }">
						<div>
							<h3>${question.title }</h3>
						</div>
						<c:forEach var="answer" items="${question.answerList }">
							<div>
								<c:out value="${answer.value }"/>
							</div>
						</c:forEach>	
					</div>
				</fieldset>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${question.surveyType == 4 }">
				<fieldset>
					<div class="checkOption">
					<input type="hidden" class="checkQuestion" value="${question.qIdx }">
						<div>
							<h3>${question.title }</h3>
						</div>
						<c:forEach var="answer" items="${question.answerList }">
							<div>
								<c:out value="${answer.value }"/>
							</div>
						</c:forEach>
					</div>
				</fieldset>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${question.surveyType == 5 }">
				<fieldset>
					<div class="selectOption">
					<input type="hidden" class="selectQuestion" value="${question.qIdx }">
						<div>
							<h3>${question.title }</h3>
						</div>
						<div>
							<c:forEach var="answer" items="${question.answerList }">
								<c:out value="${answer.value }"/>
							</c:forEach>
						</div>
					</div>
				</fieldset>
			</c:when>
		</c:choose>
	</c:forEach>
	
	<div>
		<ul>
			<li>
				<a href="/survey/admin/${survey.sIdx }">뒤로</a>
			</li>
		</ul>
	</div>
</body>
</html>