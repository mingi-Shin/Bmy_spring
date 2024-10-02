<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
	<title>admin page: show members</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp"></jsp:include>

  <h2>show members</h2>
  <div class="card card-default">

    <div class="card-header" >회원 목록</div>
    <div class="card-body" >
   		<table class="table table-bordered" style="width:100%; text-align: center; border: 1px solid #dddddd; ">
   			<tr>
   				<th>아이디 </th>
   				<th>이름 </th>
   				<th>성별 </th>
   				<th>E-Mail</th>
   			</tr>
   			<c:if test="${empty memberList }">
   				<td colspan="4">조회가능한 회원이 존재하지 않습니다.</td>
   			</c:if>
   			<c:if test="${!empty memberList }">
   				<c:forEach var="vo" items="${memberList }">
   					<tr>
		   				<td>${vo.memID }</td>
		   				<td>${vo.memName }</td>
		   				<td>${vo.memGender }</td>
		   				<td>${vo.memEmail }</td>
	   				</tr>
   				</c:forEach>
   			</c:if>
   		</table>
    </div>
    <div class="card-footer">card foot</div>
  </div>
</div>

</body>
</html>