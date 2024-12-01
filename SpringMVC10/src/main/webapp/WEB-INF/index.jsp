<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  
  
</head>
<body>

<div class="container mt-3 >
  <div class="card" style="width: 600px; text-align: center;">
  	
  	<div class="mt-4 p-5 bg-primary text-white rounded">
		  <h1>Spring boot </h1>
		  <p>Main Page</p>
		</div>
  	
    <div class="card-body">
      <p class="card-text" style="text-align: left">메뉴 선택하시오</p>
      <div class="card-group"></div>
      	<div class="card bg-warning">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${cpath}/board/list">글목록 보기<a></p>
      		</div>
      	</div>
      	<div class="card bg-danger">
      		<div class="card-body text-center">
      			<p class="card-text"><a href="${cpath}/member/login">로그인</a></p>
      		</div>
      	</div>
    </div>
  </div>
</div>

</body>
</html>
    