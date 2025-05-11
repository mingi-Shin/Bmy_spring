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
	<title>template</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
 	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  
  <script type="text/javascript">
		$(document).ready(function(){
			
			//로그인 오류시 실패 모달창show
		  if(${!empty msgBody}){
			  $("#myMessage").modal("show"); //"hide"
		  }
			  
		});
  </script>  
</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp" />

  <div class="card">
    <div class="card-header" >card title</div>
    
    <div class="card-body" >
	    <div class="row">
			  <div class="col-sm-2"> <!-- sm은 작은 디바스에서도 가능, lg는 큰 디바이스에서만 가능하게 비율이 설정됨.  -->
			  	<jsp:include page="left.jsp"></jsp:include>
			  	col-lg-2
			  </div>
			  <div class="col-sm-7">
			  	col-lg-7_콘텐츠 
			  </div>
			  <div class="col-sm-3">
			  	<jsp:include page="right.jsp"></jsp:include>
			  	col-lg-3
			  </div>
			</div>
    </div>
    
    <div class="card-footer">card-footer</div>
  </div>
  
  
  <!--  모달  -->
  <!--  모델은 사용자ui를 나타낼 때, 소셜로그인 같은 경우는 window.open() -->
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