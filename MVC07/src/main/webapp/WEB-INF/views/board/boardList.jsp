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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
			$("#regBtn").click(function(){
				location.href="${contextPath}/board/register";
			})
		});		
		
		
	
	</script>
</head>
<body>
<div class="card">
	<h2>Spring MVC_3Tier</h2>
  <div class="card-header">Board</div>
  <div class="card-body">
  	<table class="table table-bordered table-hover">
  		<tr>
  			<th>번호</th>
  			<th>제목</th>
  			<th>작성자</th>
  			<th>작성일</th>
  			<th>조회수</th>
  		</tr>
  		<c:forEach var="vo" items="${boardList}">
  			<tr>
  				<td>${vo.boardIdx }</td>
  				<td>${vo.title }</td>
  				<td>${vo.writer }</td>
  				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate }" /></td>
  				<td>${vo.count }</td>
  			</tr>
  		</c:forEach>
  		<tr>
  			<td colspan="5">
  				<button id="regBtn" class="btn btn-sm float-end">글쓰기</button>
  			</td>
  		</tr>
  	</table>
  </div>
  <div class="card-footer">스프2_(답변게시판)</div>
</div>
</body>
</html>