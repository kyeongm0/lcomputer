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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<div>
		<sec:authorize access="isAuthenticated()">
	 		<table>
	 			<tr>
	 				<td>제목</td>
	 				<td>${board.bTitle }</td>	
	 			</tr>
	 			<tr>
	 				<td>내용</td>
	 				<td>${board.bContent }</td>
	 			</tr>
	 			<tr>
	 				<td>작성날짜</td>
	 				<td>${board.bDate }</td>
	 			</tr>
	 			<tr>
	 				<td>조회수</td>
	 				<td>${board.bHits }</td>
	 			</tr>
				<c:if test="${board.uploadList.isEmpty() != true }">
					<tr>
						<td>첨부파일</td>
						<td>				
							<img src="/${board.uploadList.get(0).tUpload }" alt="Image" />
							<img src="/${board.uploadList.get(1).tUpload }" alt="Image" />
							<br> ${board.uploadList.get(0).tFileName } , ${board.uploadList.get(1).tFileName }
						</td>		
					</tr>
				</c:if>
					
				
	 			
	 			
	 		</table>
	 		<c:if test="${board.uIdx eq principal.uIdx }">
	 			<a href="/board/edit/${board.bIdx }">수정</a>
	 		</c:if>
	 		<c:if test="${board.uIdx eq pricipal.uIdx || principal.uIdx eq 2}">
	 			<a href="/board/delete/${board.bIdx }">삭제</a>
	 		</c:if>
	 		<a href="/board/reply/${board.bIdx }">답글</a>
	 		<a href="/board/list">목록</a>
	 	</sec:authorize>
	</div>
	
	<form action="/under/insert" name="under" method="post">
	<p>내용 : <br><textarea rows="5" cols="100" name="dContent"></textarea></p>
	<input type="hidden" name="bIdx" value="${board.bIdx }">
	<p> <input type="submit" value="작성하기"></p>
	</form>
	
	<div id="commentList">
	<c:if test="${list.isEmpty() != true }">
		<table>
			<tr>
				<th>NO</th>
				<th>내용</th>
				<th>작성시간</th>
				<th>작성자</th>
			</tr>
			<c:forEach items="${list }" var="under" varStatus="status">
				<tr>
					<td>${under.rownum }</td>
					<td>${under.dContent }</td>
					<td>${under.dDate }</td>
					<td>${under.user.uName }</td>
					<td>
						<button class="commentForm">대댓글</button>
					</td>
					<td>
						<button class="edit">수정</button>
					</td>
					<td>
						<button class="delete" didx="${under.dIdx }" bidx="${board.bIdx }" page="${pagination.page }">삭제</button>
					</td>
				</tr>
				<tr style="display: none;">
					<td><textarea rows="1" cols="80"></textarea></td>
					<td>
						<button type="button" class="comment" uidx="${board.uIdx }" bidx="${board.bIdx }" group="${under.dGroup }" order="${under.dOrder }" depth="${under.dDepth }" origin="${under.dIdx }" page="${pagination.page }">등록</button>
						<button type="button" class="cancel">취소</button>
					</td>
				</tr>
				<tr style="display: none;">
					<td><textarea rows="1" cols="80">${under.dContent }</textarea></td>
					<td>
						<button type="button" class="editPerform" didx="${under.dIdx }" bidx="${board.bIdx }" page="${pagination.page }">확인</button>
						<button type="button" class="editCancel">취소</button>
					</td>
				</tr>
			</c:forEach>
		
		</table> 

		<div>
			<ul>
				<c:choose>			
					<c:when test="${pagination.prevPage lt 0 }">
						<li style="display:none;"><span>◀</span></li>
					</c:when>
					
					<c:when test="${pagination.prevPage lt pagination.startPage }">
						<li>
							<a href="/board/detail/${board.bIdx}/${pagination.prevPage }">◀</a>
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
								<a href="/board/detail/${board.bIdx}/${i }">${i }</a>
							</li>
						</c:when>
					</c:choose>
				</c:forEach>
			
				<c:choose>
					<c:when test="${pagination.nextPage le pagination.lastPage }">
						<li style="">
							<a href="/board/detail/${board.bIdx}/${pagination.nextPage }">▶</a>
						</li>
					</c:when>
				</c:choose>
			
			</ul>
		</div>
	</c:if>
	</div>
	
	<script>
	$(document).on('click', '.commentForm', function () {
		$(this).parent().parent().css('display', 'none');
		$(this).parent().parent().next().css('display', '');
	});
	
	$(document).on('click', '.cancel', function () {
		$(this).parent().parent().prev().css('display', '');
		$(this).parent().parent().css('display', 'none');
	});
	
	$(document).on('click', '.comment', function () {
		let content = $(this).parent().prev().find('textarea').val();
		let c_group = $(this).attr('group');
		let c_order = $(this).attr('order');
		let c_depth = $(this).attr('depth');
		let c_uidx = $(this).attr('uidx');
		let c_bidx = $(this).attr('bidx');
		let c_origin = $(this).attr('origin');
		let c_page= $(this).attr('page');
		$.ajax({
		  method: "POST",
		  url: "/under/comment",
		  data: { dContent: content, dGroup: c_group, dOrder: c_order, dDepth: c_depth, bIdx: c_bidx, uIdx: c_uidx, dOrigin: c_origin, page: c_page }
		})
		.done(function( msg ) {
		  $('#commentList').html(msg);  
		});
	});
	
	$(document).on('click', '.edit', function () {
		$(this).parent().parent().css('display', 'none');
		$(this).parent().parent().next().next().css('display', '');	
	});
	
	$(document).on('click', '.editCancel', function () {
		$(this).parent().parent().css('display', 'none');
		$(this).parent().parent().prev().prev().css('display', '');
	});
	
	$(document).on('click', '.editPerform', function () {
		let content = $(this).parent().prev().find('textarea').val();
		let didx = $(this).attr('didx');
		let page= $(this).attr('page');
		let bidx= $(this).attr('bidx');
		$.ajax({
			method: "POST",
			url: "/under/comment/edit",
			data: { dContent: content, dIdx: didx, bIdx: bidx, page: page}
		})
		.done(function( msg ) {
			$('#commentList').html(msg);
		})
	});
	
	$(document).on('click', '.delete', function () {
		let didx= $(this).attr('didx');
		let bidx= $(this).attr('bidx');
		let page= $(this).attr('page');
		$.ajax({
			method: "POST",
			url: "/under/comment/delete",
			data: { dIdx: didx, bIdx: bidx, page: page}
		})
		.done(function ( msg ) {
			$('#commentList').html(msg);
		})
	});
	</script>
	
	
</body>
</html>