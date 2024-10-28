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
            	<td><fmt:formatDate pattern="yyyy-MM-dd" value= "${vo.indate }" /></td>
            </tr>
            
          </tbody>
        </table>
        <div class="text-center mt-4">
          <c:if test="${!empty mvo && mvo.member.memID eq vo.memID}">
            <button type="button" class="btn btn-outline-primary me-2" onclick="location.href='${contextPath}/synchBoard/modify/${vo.boardIdx }'">수정</button>
            <button type="button" class="btn btn-outline-secondary me-2">답글</button>
            <!-- <button type="button" onclick="location.href='${contextPath}/synchBoard/delete/${vo.boardIdx}'">삭제</button> -->
	          <!-- location.href 는 GET방식으로만 작동된다. -->
	          <button type="button" class="btn btn-outline-danger me-2" onclick="deleteBoard(${vo.boardIdx})">삭제</button>
          </c:if>
          <c:if test="${empty mvo || mvo.member.memID ne vo.memID}">
            <button type="button" class="btn btn-outline-primary me-2" disabled>수정</button>
            <button type="button" class="btn btn-outline-secondary me-2">답글</button>
            <button type="button" class="btn btn-outline-danger me-2" disabled>삭제</button>
          </c:if>
          <button type="button" class="btn btn-outline-info" onclick="location.href='${contextPath}/synchBoard/list'">목록으로</button>
          
        </div>
      </div>
      <div class="card-footer text-muted text-center">
        스프2_(답변게시판)
      </div>
    </div>
  </div>
</body>
</html>