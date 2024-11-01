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
		
		let msgBody = "${msgBody}";
		if(msgBody !== ""){
			alert(msgBody);
		}
		
		getCommentList();
		
		openReComment(this);
		
		$("#registerComment").on('click',function(){ //부모댓글form
			registerComment(this);
		});
		$("#registerReComment").on('click',function(){ //자식댓글form 
			registerComment(this); // this는 클릭된 #registerReComment 버튼을 참조.. 뭔말이지
		});
		
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
		let boardIdx = '${vo.boardIdx}';
		
		$.ajax({
			url: '${contextPath}/comment/list', //contextPath 생략하면 못찾아 
			type: 'GET',
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
 			},
			data: {
				'boardIdx' : boardIdx,
				'sortOrder' : 'DESC'
			},
			success: function(data){
				makeCommentList(data);
				console.log(data);
			},
			error: function(jqXHR) {
	    	let errorMessage = "알 수 없는 오류가 발생했습니다.";
		    if (jqXHR.status === 403) {
	        errorMessage = "권한이 없습니다. 접근할 수 없습니다.";
		    } else if (jqXHR.status === 500) {
	        errorMessage = jqXHR.responseText || "서버 오류가 발생했습니다.";
		    }
		    console.log(errorMessage);
		    alert("오류: " + errorMessage + "\n" + jqXHR.status + "입니다");
			}
		});
	}
	
	//댓글리스트 동적 생성 
	function makeCommentList(data) {
  	let htmlList = "";
    if (data !== null) {
    	$.each(data, function (index, cvo) { //JQuery문: data가 배열이든 객체든 반복 
	      htmlList += "<tr>";
	      htmlList += "<td>" + cvo.memName + "</td>";
	      htmlList += "<td>" + cvo.indate + "</td>";
	      htmlList += "</tr>";
	      htmlList += "<tr>";
	      htmlList += "<td>" + cvo.comment + "</td>";
	      htmlList += "<td>";
	      htmlList += "<button onclick='openReComment(" + cvo.commentIdx + ")' class='btn btn-secondary btn-sm'>";
	      htmlList += "답글";
	      htmlList += "</button>";
	      htmlList += "</td>";
	      htmlList += "</tr>";
	
	      // 해당 댓글의 답글버튼 누르면 나옴
	      htmlList += "<tr id='reCommDiv" + cvo.commentIdx + "' style='display: none;'>"; // 트의 구조로 수정
	      htmlList += "<td colspan='2'>"; // 두 개의 열을 차지하도록 설정
	      htmlList += "<form id='reCommForm" + cvo.commentIdx + "'>";
	      htmlList += "<div>"; // 태그 추가: div로 그룹화
	      htmlList += "<textarea type='text' class='form-control' name='comment' rows='2'>";
	      htmlList += "@" + cvo.memName + "  "; //누구한테 답장한 건지 기본출력 
	      htmlList += "</textarea>";
	      htmlList += "<input type='hidden' name='boardIdx' value='" + cvo.boardIdx + "'>";
	      htmlList += "<input type='hidden' name='memID' value='" + '${mvo.member.memID}' + "'>";
	      htmlList += "<input type='hidden' name='memName' value='" + '${mvo.member.memName}' + "'>";
	      htmlList += "<input type='hidden' name='parentIdx' value='" + cvo.commentIdx + "'>";
	      htmlList += "<input type='hidden' name='commentGroup' value='" + cvo.commentGroup + "'>";
	      htmlList += "</div>";
	      htmlList += "<button type='button' id='registerReComment_" + cvo.commentIdx + "' class='btn btn-sm' onclick='registerComment(this)'>"; // 버튼 ID 고유화
	      htmlList += "등록</button>";
	      htmlList += "</form>";
	      htmlList += "</td>"; // 테이블 데이터 종료
	      htmlList += "</tr>"; // 답글 입력 필드를 위한 tr 종료
	  	});
    } else {
	    htmlList += "<tr>";
	    htmlList += "<td colspan='2'>"; // 열 병합
	    htmlList += "첫 댓글을 작성해보세요!";
	    htmlList += "</td>";
	    htmlList += "</tr>";
    }

    $("#commentTableBody").html(htmlList);
}
	
	//댓글작성
	function registerComment(event){
		console.log("registerComment() 실행 ");
		
		const clickedButtonId = $(event).attr("id"); //버튼id 확인 
		console.log(clickedButtonId);
		const commentIdx = clickedButtonId.split("_")[1]; // commentIdx 추출
		console.log(commentIdx);
		
		let fData;
		if(clickedButtonId.includes("registerComment")){
				fData = $("#commForm").serialize(); // 폼의 데이터를 URL-encoded 형식으로 직렬화
		} else if (clickedButtonId.includes("registerReComment")){
				fData = $("#reCommForm" + commentIdx).serialize(); // 폼의 데이터를 URL-encoded 형식으로 직렬화
		} else {
				alert("오류: 잘못된 form 제출시도");
				reutrn;
		}
		console.log(fData);

		$.ajax({
			url: '${contextPath}/comment/register',
			method: 'POST',
			data: fData,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(){
				getCommentList(); //댓글리스트 초기화 
				$("#commForm")[0].reset(); 
				$("#reCommForm" + commentIdx)[0].reset(); 
				console.log("댓글등록 성공");
			},
			error: function(jqXHR) {
	    	let errorMessage = "알 수 없는 오류가 발생했습니다.";
		    if (jqXHR.status === 403) {
	        errorMessage = "권한이 없습니다. 접근할 수 없습니다.";
		    } else if (jqXHR.status === 500) {
	        errorMessage = jqXHR.responseText || "서버 오류가 발생했습니다.";
		    }
		    console.log(errorMessage);
		    alert("오류: " + errorMessage + "\n 상태코드: " + jqXHR.status + "입니다");
			}
		});
	}

	function openReComment(commentIdx){
		console.log("commentIdx: ", commentIdx);
		$("#reCommDiv"+commentIdx).css("display", "block");
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
            <tr style="display: none;">
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
      	<table class="table table-hover" >
      		<tbody id="commentTableBody">
      		
      		</tbody>
      	</table>
      </div>
      
      <!-- 1차 부모댓글: parentIdx = null -->
      <security:authorize access="hasRole('ROLE_WRITE')"> 
	      <div>
	      	<form id="commForm"> 
	      		<table class="table table-borderless">
	      			<tr>
	      				<td>
	      					<textarea type="text" id="comment" class="form-control" name="comment" rows="2" ></textarea>
	      					<input type="hidden" id="boardIdx" name="boardIdx" value="${vo.boardIdx }">
	      					<input type="hidden" id="memID"  name="memID" value="${mvo.member.memID}">
	      					<input type="hidden" id="memName" name="memName"  value="${mvo.member.memName }">
	      					<input type="hidden" id="parentIdx"  name="parentIdx" value="">
	      					<input type="hidden" id="commentGroup"  name="commentGroup" value="">
	      				</td>
	      				<td>
				      		<button type="button" id="registerComment_${vo.boardIdx }" class="btn btn-outline-secondary btn-sm" onclick="registerComment(this)" >등록</button>
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