<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 보기</title>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		getCommentList();
		
		let msgBody = "${msgBody}";
		if(msgBody !== ""){
			alert(msgBody);
		}
	
	});

	//게시물 삭제
	function deleteBoard(boardIdx){
		$.ajax({
			url: '/synchBoard/delete/' + boardIdx,
			type: 'POST',
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			success: function(){
				location.href="${contextPath}/synchBoard/list";
				alert("게시물이 성공적으로 삭제되었습니다.");
			},
			error: function(){alert("error발생")}
		});
	}
	
	//댓글 불러오기
	function getCommentList(){
		console.log('댓글불렁모');
		let boardIdx = '${vo.boardIdx}';
		
		$.ajax({
			url: '${contextPath}/comment/list', //contextPath 생략하면 못찾아 
			type: 'GET',
			data: {
				'boardIdx' : boardIdx,
				'sortOrder' : 'DESC'
			},
			success: function(data){
				makeCommentList(data);
				console.log(data);
				
			},
			error: function(xhr, status, error) {
			    console.error("댓글 리스트 불러오기 실패:");
			    console.error("상태 코드:", xhr.status);         // HTTP 상태 코드 (예: 404, 500 등)
			    console.error("상태 텍스트:", xhr.statusText);    // 상태 텍스트 (예: "Not Found" 등)
			    console.error("응답 본문:", xhr.responseText);   // 서버가 반환한 오류 메시지 본문
			    console.error("에러 메시지:", error);            // JavaScript 오류 메시지
			}
		});
	}
	
	function makeCommentList(data){
		let htmlList = "";
		if(data !== null){
			$.each(data, function(index, vo){ //JQuery문: data가 배열이든 객체든 반복 
				htmlList += "<tr>";
				htmlList += "<td>" + vo.memName + "</td>";
				htmlList += "<td>" + vo.indate + "</td>";
				htmlList += "</tr>";
				htmlList += "<tr>";
				htmlList += "<td>" + vo.comment  + "</td>";
				htmlList += "</tr>";
			});
		} else {
			htmlList += "<tr>";
			htmlList += "<td>";
			htmlList += "첫 댓글을 작성해보세요!";
			htmlList += "</td>";
			htmlList += "</tr>";
		}
		
		$("#commentTableBody").html(htmlList);
	}
	
</script>

</head>
<body>
  <div class="container">
  	<jsp:include page="../common/header.jsp" />
  
    <div class="card shadow-sm">
      <div class="card-header text-center bg-primary text-white">
        <h3 class="mb-0">게시판 조회</h3>
      </div>
      <div class="card-body">
        <table class="table table-striped table-borderless">
          <tbody>
            <tr>
              <th scope="row" style="width: 20%;">번호</th>
              <td>${vo.boardIdx}</td>
            </tr>
            <tr>
              <th scope="row">제목</th>
              <td>${vo.title}</td>
            </tr>
            <tr>
              <th scope="row">내용</th>
              <td><textarea rows="6" class="form-control" readonly>${vo.content}</textarea></td>
            </tr>
            <tr>
              <th scope="row">작성자</th>
              <td>${vo.writer}</td>
            </tr>
            <tr>
            	<th>작성일</th>
            	<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value= "${vo.indate }" /></td>
            </tr>
            
          </tbody>
        </table>
        <div class="text-center mt-4">
          <c:if test="${!empty mvo && mvo.member.memID eq vo.memID}">
            <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='${contextPath}/synchBoard/modify/${vo.boardIdx }'">수정</button>
            <button type="button" class="btn btn-outline-secondary me-2">답글</button>
            
          </c:if>
          <c:if test="${empty mvo || mvo.member.memID ne vo.memID}">
            <button type="button" class="btn btn-outline-primary me-2" disabled>수정</button>
            <button type="button" class="btn btn-outline-secondary me-2">답글</button>
          </c:if>
          <button type="button" class="btn btn-outline-info" onclick="location.href='${contextPath}/synchBoard/list'">목록으로</button>
          
        </div>
      </div>
      
      <!-- 댓글 공간: 새로고침 버튼ajax구현도 가능 -->
      <div>
      	<table class="table table-striped table-borderless" >
      		<tbody id="commentTableBody">
      		
      		</tbody>
      	</table>
      </div>
      
      <!-- 1차 부모댓글: parentIdx = null -->
      <security:authorize access="hasRole('ROLE_WRITE')"> 
	      <div>
	      	<form action="" method="post"> 
	      		<table class="table table-striped table-borderless">
	      			<tr>
	      				<th>
	      					<input type="text" id="memName" class="form-control" value="${mvo.member.memName }" readOnly>
	      				</th>
	      				<td>
	      					<input type="text" id="comment" class="form-control" name="comment" >
	      					<input type="hidden" id="memID" class="form-control" name="memID" value="${mvo.member.memID}">
	      					<input type="hidden" id="boardIdx" class="form-control" name="boardIdx" value="${vo.boardIdx }">
	      					<input type="hidden" id="parentIdx" class="form-control" name="parentIdx" value="NULL">
	      				</td>
	      			</tr>
	      		</table>
	      	</form>
	      </div>
      </security:authorize>
      
      <div class="card-footer text-muted text-center">
        스프2_(답변게시판)<hr>
      </div>
    </div>
  </div>
  
  <!-- 모달창 -->
	<div class="modal fade" id="myMessage" role="dialog">
	  <div class="modal-dialog">
	    <div id="messageType" class="modal-content">
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title"></h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	       	<p></p>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
</body>
</html>