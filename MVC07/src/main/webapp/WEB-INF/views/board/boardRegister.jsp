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
  <div class="card-header">Board</div>
  <div class="card-body">
  	<form action="${contextPath }/board/register" method="post" class="was-validated">
  		<input type="hidden" name="memID" value="${loginM.memID }" >
  		<div class="mb-3 mt-3" >
  			<label class="form-label" for="title">제목: </label>
  			<input class="form-control" id="title" name="title" placeholder="Title" type="text" required>
  			<div class="valid-feedback">Valid</div>
  			<div class="invalid-feedback">Please fill out this field.</div>
  		</div>
  		<div class="mb-3 mt-3">
  			<label class="form-label" for="content">내용: </label>
  			<textarea class="form-control" id="content" name="content" placeholder="Content" rows="10" required></textarea>
  			<div class="valid-feedback">Valid</div>
  			<div class="invalid-feedback">Please fill out this field.</div>
  		</div>
  		<div class="mb-3 mt-3">
  			<label class="form-label" for="writer">작성자: </label>
  			<input class="form-control" id="wrtier" name="writer" type="text" value="${loginM.memName }" readonly>
  		</div>
  		<div class="float-end">
	  		<!--  <button type="submit" class="btn btn-primary" disabled>Submit</button> -->
	  		<button type="reset" class="btn btn-primary me-2">Cancel</button>
	  		<button type="submit" class="btn btn-primary">Submit</button>
  		</div>
  		 
  	</form>
  </div>
  <div class="card-footer">스프2_(답변게시판)</div>
</div>
</body>
</html>