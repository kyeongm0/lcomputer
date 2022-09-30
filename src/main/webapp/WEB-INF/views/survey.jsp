<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<title>Insert title here</title>
<style>
	.deleteButton {
		position: relative;
		left: 1850px;
	}
	.admitButton {
		position: relative;
		left: 900px;
	}
	.optionDelete {
		position: relative;
		left: 1250px;
	}
</style>
</head>
<body>
	<fieldset>
		<div id="surveyTitle">
			<p><textarea rows="1" cols="80" class="surveyMain" placeholder="제목없는 설문지"></textarea></p>
			<p><textarea rows="1" cols="80" class="surveySub" placeholder="설문지 설명"></textarea></p>
		</div>
	</fieldset>
	<br>
	<div>
		<button id="addButton" class="add">추가</button>
	</div>
	
	<div id="surveyTool" style="display:none;">
		<button class="multipleTool">객관식</button>
		<button class="shortTool">단답형</button>
		<button class="longTool">장문형</button>
		<button class="checkboxTool">체크박스</button>
		<button class="selectboxTool">셀렉트박스</button>
		<button class="toolCancel">취소</button>
	</div>
	<div id="field"></div>
	
	<div>
		<button type="button" class="admitButton">만들기</button>
	</div>
	
	
	
	<script>
	
		let mul = `
			<fieldset>
				<div class="multiOption">
					<button type="button" class="deleteButton">X</button>
					<div>
						<textarea class="multiTitle" rows="1" cols="50" placeholder="질문"></textarea>
					</div>
					<div class="multi" name="multiOp">
						<input type="radio" name="choice">
						<textarea class="multiItem" rows="1" cols="20"></textarea>
					</div>
				</div>
				<div>
					<button class="addOption">옵션 추가</button>
				</div>	
			</fieldset>
		`;
		
		let op = `
			<div class="multi" name="multiOp">
				<input type="radio" name="choice">
				<textarea class="multiItem" rows="1" cols="20"></textarea>
				<button type="button" class="optionDelete">X</button>
			</div>
		`;
		
		let sh = `
			<fieldset>
				<div class="short">
					<button type="button" class="deleteButton">X</button>
					<div><textarea rows="1" cols="50" class="shortTitle" placeholder="질문"></textarea></div>
					<div><textarea rows="1" cols="50" placeholder="단답형 텍스트"></textarea></div>
				</div>
			</fieldset>
		`;
		
		let lo = `
			<fieldset>
				<div class="long">
					<button type="button" class="deleteButton">X</button>
					<div><textarea rows="1" cols="50" class="longTitle" placeholder="질문"></textarea></div>
					<div><textarea style="width:1000px; height:200px;" placeholder="장문형 텍스트"></textarea></div>
				</div>
			</fieldset>
		`;
		
		let ch = `
			<fieldset>
				<div class="checkOption">
					<button type="button" class="deleteButton">X</button>
					<div>
						<textarea rows="1" cols="50" placeholder="제목없는 질문" class="checkTitle"></textarea>
					</div>
					<div class="check">
						<input type="checkbox">
						<textarea rows="1" cols="20" class="checkItem"></textarea>
					</div>
				</div>	
				<div>
					<button class="addCheckOption">옵션 추가</button>
				</div>
			</fieldset>
		`;
	
		let chop = `
			<div class="check">
				<input type="checkbox">
				<textarea rows="1" cols="20" class="checkItem"></textarea>
				<button type="button" class="optionDelete">X</button>
			</div>
		`;
		
		let	sel = `
			<fieldset>
				<div class="selectOption">		
					<button type="button" class="deleteButton">X</button>
					<div>	
						<textarea rows="1" cols="50" placeholder="제목없는 질문" class="selectTitle"></textarea>	
					</div>
					<div class="select">
						<textarea rows="1" cols="20" class="selectItem"></textarea>
					</div>
				</div>
				<div>
					<button class="addSelectOption">옵션 추가</button>
				</div>
			</fieldset>
		`; 
		
		let selop = `
			<div class="select">
				<textarea rows="1" cols="20" class="selectItem"></textarea>
				<button type="button" class="optionDelete">X</button>
			</div>
		`;
		
		
		$(document).on('click', '.add', function () {
			$('#addButton').css('display', 'none');
			$('#surveyTool').css('display', '');
			
		});
		
		$(document).on('click', '.toolCancel', function () {
			$('#addButton').css('display', '');
			$('#surveyTool').css('display', 'none');
		});
		
		$(document).on('click', '.multipleTool', function () {
			$(mul).appendTo('#field');
			$('#addButton').css('display', '');
			$('#surveyTool').css('display', 'none');
		});
		
		$(document).on('click', '.addOption', function () {
			$(op).appendTo($(this).parent().prev());
		});
		
		$(document).on('click', '.shortTool', function () {
			$(sh).appendTo('#field');
			$('#addButton').css('display', '');
			$('#surveyTool').css('display', 'none');
		});
		
		$(document).on('click', '.longTool', function () {
			$(lo).appendTo('#field');
			$('#addButton').css('display', '');
			$('#surveyTool').css('display', 'none');
		});
		
		$(document).on('click', '.checkboxTool', function () {
			$(ch).appendTo('#field');
			$('#addButton').css('display', '');
			$('#surveyTool').css('display', 'none');
		});
		
		$(document).on('click', '.addCheckOption', function () {
			$(chop).appendTo($(this).parent().prev());
		});
		
		$(document).on('click', '.selectboxTool', function () {
			$(sel).appendTo('#field');
			$('#addButton').css('display', '');
			$('#surveyTool').css('display', 'none');
		});
		
		$(document).on('click', '.addSelectOption', function () {
			$(selop).appendTo($(this).parent().prev());
		});
		
		$(document).on('click', '.deleteButton', function () {
			$(this).parent().parent().remove();
		});
		
		$(document).on('click', '.optionDelete', function () {
			$(this).parent().remove();
		});
		
		$(document).on('click', '.admitButton', function() {
			let questionList = [];
			$('.multiOption').each ( function () {
				let itemList = [];
				let surveyType = 1;
				$(this).find('.multi').each ( function () {
					let item = {
						value : $(this).find('.multiItem').val()	
					};
					itemList.push(item);
				});
				
				let question = {
					title : $(this).find('.multiTitle').val(),
					itemList : itemList,
					surveyType : surveyType
				};
				questionList.push(question);
			});
			
			$('.short').each (function () {
				let surveyType = 2;
				let question = {
						title : $(this).find('.shortTitle').val(),
						surveyType : surveyType
				};
				questionList.push(question);
			});
			
			$('.long').each (function () {
				let surveyType = 3;
				let question = {
						title : $(this).find('.longTitle').val(),
						surveyType : surveyType
				};
				questionList.push(question);
			});
			
			$('.checkOption').each ( function () {
				let itemList = [];
				let surveyType = 4;
				$(this).find('.check').each ( function () {
					let item = {
						value : $(this).find('.checkItem').val()	
					};
					itemList.push(item);
				});
				
				let question = {
					title : $(this).find('.checkTitle').val(),
					itemList : itemList,
					surveyType : surveyType
				};
				questionList.push(question);
			});
			
			$('.selectOption').each ( function () {
				let itemList = [];
				let surveyType = 5;
				$(this).find('.select').each ( function () {
					let item = {
						value : $(this).find('.selectItem').val()	
					};
					itemList.push(item);
				});
				
				let question = {
					title : $(this).find('.selectTitle').val(),
					itemList : itemList,
					surveyType : surveyType
				};
				questionList.push(question);
			});
			
			let survey = {
					mainTitle : $('#surveyTitle').find('.surveyMain').val(),
					subTitle : $('#surveyTitle').find('.surveySub').val(),
					questionList : questionList,
					uIdx : ${user.uIdx}
			};
			
			console.log(questionList);
			console.log(survey);
			
			$.ajax ({
				method : "POST",
				url : "/survey/insert",
				contentType : "application/json",
				data : JSON.stringify (survey)
			})
			
			.done ( function (page) {
				$('#surveyList').html(page);
			});
		});
	</script>
</body>
</html>