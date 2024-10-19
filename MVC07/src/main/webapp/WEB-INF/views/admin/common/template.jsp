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
		<form action="${contextPath }/login/loginProcess" method="post">
		  <div class="mb-3 mt-3">
		    <label for="memID" class="form-label">ID:</label>
		    <input type="text" class="form-control" id="memID" placeholder="Enter ID" name="memID">
		  </div>
		  <div class="mb-3">
		    <label for="memPwd" class="form-label">Password:</label>
		    <input type="password" class="form-control" id="memPwd" placeholder="Enter password" name="memPwd">
		  </div>
		  <button type="submit" class="btn btn-sm btn-primary">로그인</button>
		</form>
  </div>
  <div class="card-body">
  	
  </div>
  <div class="card-footer">스프2_(답변게시판)</div>
</div>
</body>
</html>