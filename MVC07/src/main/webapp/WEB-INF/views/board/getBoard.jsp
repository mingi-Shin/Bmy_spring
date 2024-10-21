<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>template</title>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
<div class="card">
	<h2>Spring MVC_3Tier</h2>
  <div class="card-header">
  <c:if test="${empty loginM}">
		<form action="${contextPath }/login/loginProcess" method="post">
			<div class="row float-end">
			  <div class="col-auto d-flex align-items-center">
			    <label for="memID" class="form-label mb-0 me-2">ID:</label>
			    <input type="text" class="form-control" id="memID" placeholder="Enter ID" name="memID">
			  </div>
			  <div class="col-auto d-flex align-items-center">
			    <label for="memPwd" class="form-label mb-0 me-2">Password:</label>
			    <input type="password" class="form-control" id="memPwd" placeholder="Enter password" name="memPwd">
			  </div>
				<div class="col-auto d-flex align-items-center">
				  <button type="submit" class="btn btn-sm btn-primary">로그인</button>
				</div>
			</div>
		</form>
  </c:if>
  <c:if test="${!empty loginM}">
		<form action="${contextPath }/login/logoutProcess" method="post">
			<div class="row float-end">
			  <div class="col-auto d-flex align-items-center">
			    <label>${loginM.memName }님 방문을 환영합니다</label>
			  </div>
				<div class="col-auto d-flex align-items-center">
				  <button type="submit" class="btn btn-sm btn-primary">로그아웃</button>
				</div>
			</div>
		</form>
  </c:if>
  </div>
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
  				<c:if test="${!empty loginM && loginM.memID eq vo.memID }">
  					<button type="submit" class="btn btn-sm btn-primary">수 정</button> <!-- 이거 버튼 수정페이지나.. ajax로  -->
  					<button type="submit" class="btn btn-sm btn-primary">답 글</button> 
  					<button type="button" class="btn btn-sm btn-warning" onclick="location.href='${contextPath}/board/remove?boardIdx=${vo.boardIdx }'">삭 제</button>
  				</c:if>
  				<c:if test="${empty loginM || loginM.memID ne vo.memID }">
  					<button type="submit" class="btn btn-sm btn-primary" disabled>수 정</button>
  					<button type="submit" class="btn btn-sm btn-primary">답 글</button> 
  					<button type="button" class="btn btn-sm btn-warning" onclick="location.href='${contextPath}/board/remove?boardIdx=${vo.boardIdx }'" disabled>삭 제</button>
  				</c:if>
  				<button type="button" class="btn btn-sm btn-info" onclick="location.href='${contextPath}/board/list'">목록으로</button>
  			</td>
  		</tr>
  	</table>
  </div>
  <div class="card-footer">스프2_(답변게시판)</div>
</div>
</body>
</html>