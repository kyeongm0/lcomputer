<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

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
					<td><textarea rows="1" cols="80" name="dContent"></textarea></td>
					<td>
						<button type="button" class="comment" uidx="${board.uIdx }" bidx="${board.bIdx }" group="${under.dGroup }" order="${under.dOrder }" depth="${under.dDepth }" origin="${under.dIdx }">등록</button>
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