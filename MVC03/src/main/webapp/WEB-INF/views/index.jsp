<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<head>
  <title>Spring MVC03</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
  
  <script type="text/javascript">
  	$(document).ready(function(){
  	  if(${!empty welcome}){
		$("#myMessage").modal("show"); //회원가입 축하 모달
	  }
  		
  	});
  </script>
</head>
<body>

<div class="container">
<jsp:include page="common/header.jsp" />
	<h1>Main page</h1>
	<c:if test="${!empty loginM}">
		<label>[사진]${loginM.memName}님 방문을 환영합니다. </laber>
	</c:if>
	<c:if test="${empty loginM}">
		<label>현재 비회원으로 로그인 중입니다. </label>
	</c:if>
	
	<h2></h2>
</div>

<!-- 회원 관련 모달창 -->
<div class="modal fade" id="myMessage" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">${msgType }</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       	<p>${welcome }</p>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>


</body>
</html>