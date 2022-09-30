<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<title>Insert title here</title>
<style>
	.admitButton {
		position: relative;
		left: 900px;
	}
	.cancelButton {
		position: relative;
		left: 950px;
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
						<c:forEach var="item" items="${question.itemList }">
							<div>
								<input type="radio" name="choice" value="${item.value }">
								<label>
									<c:out value="${item.value }"/>
								</label>
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
						<div><textarea rows="1" cols="50" placeholder="단답형 텍스트" class="shortAnswer"></textarea></div>
						
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
						<div><textarea style="width:1000px; height:200px;" placeholder="장문형 텍스트" class="longAnswer"></textarea></div>
						
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
						<c:forEach var="item" items="${question.itemList }">
							<div>
								<input type="checkbox" name="choice" value="${item.value }">
								<label>
									<c:out value="${item.value }"/>
								</label>
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
							<select name="choice">
								<option value="">선택하세요</option>
								<c:forEach var="item" items="${question.itemList }">
									<option value="${item.value }" value="${item.value }">${item.value }</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</fieldset>
			</c:when>
		</c:choose>
	</c:forEach>
	
	<div>
		<button type="button" class="admitButton">제출</button>
	</div>
	
	<script>
		$(document).on('click', '.admitButton', function () {
			let answerList = [];
			
			$('.multiOption').each( function () {
				let answer = {
						value : $("input[type=radio][name=choice]:checked").val(),
						qIdx : $('.multiQuestion').val(),
						uIdx : ${user.uIdx}
				};
				answerList.push(answer);
			});
			
			$('.short').each( function () {
				let answer = {
						value : $(this).find('.shortAnswer').val(),
						qIdx : $('.shortQuestion').val(),
						uIdx : ${user.uIdx}
				};
				answerList.push(answer);
			});
			
			$('.long').each( function () {
				let answer = {
						value : $(this).find('.longAnswer').val(),
						qIdx : $('.longQuestion').val(),
						uIdx : ${user.uIdx}
				};
				answerList.push(answer);
			});
			
			$('.checkOption').each( function () {
				$('input[type=checkbox][name=choice]:checked').each( function () {
					let answer = {
						value : $(this).val(),
						qIdx : $('.checkQuestion').val(),
						uIdx : ${user.uIdx}
					};
					answerList.push(answer);
				});
			});
			
			$('.selectOption').each ( function () {
				let answer = {
						value : $(this).find('select[name=choice]').val(),
						qIdx : $('.selectQuestion').val(),
						uIdx : ${user.uIdx}
				};
				answerList.push(answer);
			});
			
			console.log(answerList);
			
			let question = {
					answerList : answerList
			};
			
			$.ajax ({
				method : "POST",
				url : "/survey/answer",
				contentType : "application/json",
				data : JSON.stringify (question),
			});

		});
	</script>
</body>
</html>