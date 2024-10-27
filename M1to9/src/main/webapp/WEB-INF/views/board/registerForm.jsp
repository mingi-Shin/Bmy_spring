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
	<title>게시판 등록</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
  <script type="text/javascript">
  	$(document).ready(function(){
  		 if(${!empty msgBody}){
			  $("#myMessage").modal("show"); 
		  }
  		 
  	});
  
  </script>  
    
</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp" />

  <h1>Spring MVC01 to MVC09</h1>
  <div class="card">
    <div class="card-header" >글쓰기</div>
    <div class="card-body" >
    
    <form action="${contextPath }/synchBoard/register" method="post" class="was-validated">
  		<input type="hidden" name="memID" value="${mvo.member.memID }" >
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
  			<input class="form-control" id="wrtier" name="writer" type="text" value="${mvo.member.memName }" readonly>
  		</div>
  		<div class="float-end">
	  		<!--  <button type="submit" class="btn btn-primary" disabled>Submit</button> -->
	  		<button type="reset" class="btn btn-primary me-2">Cancel</button>
	  		<button type="submit" class="btn btn-primary">Submit</button>
  		</div>
  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
  	</form>
    
    </div>
    <div class="card-footer">card foot</div>
  </div>
  
	<div class="modal fade" id="myMessage" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">${msgTitle }</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	       	<p>${msgBody }</p>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
  
</div>


</body>
</html>