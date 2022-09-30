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

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
	<div id="answerChart">
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
				<c:if test="${survey.questionList.get(i).surveyType == 1 || survey.questionList.get(i).surveyType == 4 || survey.questionList.get(i).surveyType == 5 }">
					<tr>
						<td>${survey.questionList.get(i).surveyType}</td>
						<td>${survey.questionList.get(i).title }</td>
						<td><button class="chart" sIdx ="${survey.sIdx }" qIdx="${survey.questionList.get(i).qIdx }">통계</button></td>
						<td style="display:none;"><button class="close">닫기</button></td>
					</tr>
				</c:if>
			</c:forEach>
			
		</table>
		
		<div id="piechart" style="width: 900px; height: 500px; display:none;"></div>
		
		<div>
			<ul>
				<li><a href="/survey/list">뒤로</a></li>
			</ul>
		</div>
	</div>
	

	<script>
	let dataChartList;
	
		$(document).on('click', '.chart', function () {
			let sIdx = $(this).attr('sIdx');
			let qIdx = $(this).attr('qIdx');
			
			$(this).parent().css('display', 'none');
			$(this).parent().next().css('display', '');
			$(this).parent().next().next().css('display', '');
			$('#piechart').css('display', '');
			
			$.ajax({
				method: "POST",
				contentType : 'application/json',
			  	url: "/survey/chart",
			  	data: JSON.stringify ({ qIdx : qIdx }),
			})
			
			.done ( function (dataList) {
				dataChartList = dataList;
				test();
				
				console.log(dataList)
				console.log(dataList[0].item)
				console.log(dataList[0].itemCount)
				console.log(dataList[1].item)
				console.log(dataList[1].itemCount)
				
			})
		});
		
		$(document).on('click', '.close', function () {
			$(this).parent().css('display', 'none');
			$(this).parent().prev().css('display', '');
			$('#piechart').css('display', 'none');
		});
		
		function test() {
			google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(drawChart);
		
			
		}
		
		function drawChart() {
			
		  var data= new google.visualization.DataTable();
		  data.addColumn('string', 'Task');
		  data.addColumn('number', 'Choice');
		  
		  for(var i=0; i<dataChartList.length; i++) {
			  data.addRow([dataChartList[i].item, dataChartList[i].itemCount]);
		  }
		    
		  var options = {
		    title: 'My Survey',
		    sliceVisibilityThreshold : 0
		  };
		
		  var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		
		  chart.draw(data, options);
		}
		
	</script>

</body>
</html>