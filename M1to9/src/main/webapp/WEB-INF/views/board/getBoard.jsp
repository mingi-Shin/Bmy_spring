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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
<div class="card">
	<h2>게시판 조회</h2>
  <div class="card-header"></div>
  <div class="card-body">
  	<table class="table table-bordered">
  		<tr>
	  		<th>번호</th>
	  		<td>${vo.boardIdx }</td>
  		</tr>
  		<tr>
	  		<th>제목</th>
	  		<td>${vo.title }</td>
  		</tr>
  		<tr>
	  		<th>내용</th>
	  		<td><textarea rows="10" class="form-control" readonly>${vo.content }</textarea></td>
  		</tr>
  		<tr>
	  		<th>작성자</th>
	  		<td>${vo.writer }</td>
  		</tr>
  		<tr>
  			<td>
  				<c:if test="${!empty mvo && mvo.member.memID eq vo.memID }">
  					<button type="submit" class="btn btn-sm btn-primary">수 정</button> <!-- 이거 버튼 수정페이지나.. ajax로  -->
  					<button type="submit" class="btn btn-sm btn-primary">답 글</button> 
  					<button type="button" class="btn btn-sm btn-warning" onclick="location.href='#'">삭 제</button>
  				</c:if>
  				<c:if test="${empty mvo || mvo.member.memID ne vo.memID }">
  					<button type="submit" class="btn btn-sm btn-primary" disabled>수 정</button>
  					<button type="submit" class="btn btn-sm btn-primary">답 글</button> 
  					<button type="button" class="btn btn-sm btn-warning" onclick="location.href='#'" disabled>삭 제</button>
  				</c:if>
  				<button type="button" class="btn btn-sm btn-info" onclick="location.href='${contextPath}/synchBoard/list'">목록으로</button>
  			</td>
  		</tr>
  	</table>
  </div>
  <div class="card-footer">스프2_(답변게시판)</div>
</div>
</body>
</html>