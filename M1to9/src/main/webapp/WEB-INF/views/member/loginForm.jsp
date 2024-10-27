<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }" />
    
<!DOCTYPE html>
<html>
<head>
	<title>Login Form</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 	
 	
 	<script type="text/javascript">
		$(document).ready(function(){
			
			// URL에서 error 파라미터를 가져오기
      const urlParams = new URLSearchParams(window.location.search);
      const errorParam = urlParams.get('error'); // error 파라미터 값을 가져옴
 			
			//mvc06 추가코드:
			if(errorParam){
				console.log("아이디와 비밀번호 틀림");
				$("#messageType").attr("class", "modal-content panel-warning");
				$(".modal-title").text("로그인 실패");
				$(".modal-body").text("아이디와 비밀번호를 확인해주세요.");
				$("#myMessage").modal("show");
			}
			
			//회원가입완료 알람
			let msgBody = "${msgBody}";
			if(msgBody !== ""){
				alert(msgBody);
			}
		
			
			
		});
 	</script>
 	
</head>
<body>

<div class="container">
  <jsp:include page="../common/header.jsp"></jsp:include>

  <div class="card card-default">
    <div class="card-header"> 로그인 화면 </div>
    <div class="card-body" >
    
			<form action="${contextPath}/memLogin.do" method="post" class="was-validated">
		  	<div class="mb-3 mt-3">
		    	<label for="uname" class="form-label">ID:</label>
		    	<input type="text" class="form-control" id="uname" placeholder="Enter username" name="username" required>
		    	<div class="valid-feedback">Valid.</div>
		    	<div class="invalid-feedback">Please fill out this field.</div>
		  	</div>
		  	<div class="mb-3">
		    	<label for="pwd" class="form-label">Password:</label>
		    	<input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required>
		    	<div class="valid-feedback">Valid.</div>
		    	<div class="invalid-feedback">Please fill out this field.</div>
		  	</div>
<!-- 
		  	<div class="form-check mb-3">
		    	<input class="form-check-input" type="checkbox" id="myCheck" name="remember" required>
		    	<label class="form-check-label" for="myCheck">I agree on blabla.</label>
		    	<div class="valid-feedback">Valid.</div>
		    	<div class="invalid-feedback">Check this checkbox to continue.</div>
		  	</div>
-->
		  	<button type="submit" class="btn btn-primary">Submit</button>
		  	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			</form>
    </div>
    
 		<div>
    	<form id="admin" action="${contextPath }/memLogin.do" method="post">
    		<input type="hidden" name="username"" value="admin">
    		<input type="hidden" name="password" value="ssy917" >
    		<input type="submit" value="관리자 로그인">
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }" />
    	</form>
    </div>
    <div>
    	<form id="winter" action="${contextPath }/memLogin.do" method="post">
    		<input type="hidden" name="username"" value="winter">
    		<input type="hidden" name="password" value="ssy917" >
    		<input type="submit" value="윈터로그인">
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }" />
    	</form>
    </div>
    
		<div>
    	<form id="karina" action="${contextPath }/memLogin.do" method="post">
    		<input type="hidden" name="username"" value="karina">
    		<input type="hidden" name="password" value="ssy917" >
    		<input type="submit" value="카리나로그인">
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }" />
    	</form>
    </div>
		
		<div>
    	<form id="ningning" action="${contextPath }/memLogin.do" method="post">
    		<input type="hidden" name="username"" value="ningning">
    		<input type="hidden" name="password" value="ssy917" >
    		<input type="submit" value="닝닝로그인">
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }" />
    	</form>
    </div>
    
 		<div>
    	<form id="jijel" action="${contextPath }/memLogin.do" method="post">
    		<input type="hidden" name="username" value="jijel">
    		<input type="hidden" name="password" value="ssy917" >
    		<input type="submit" value="지젤로그인">
    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }" />
    	</form>
    </div>
    
    

    
    <!-- 모달창 -->
		<div class="modal fade" id="myMessage" role="dialog">
		  <div class="modal-dialog">
		    <div id="messageType" class="modal-content">
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title"></h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		       	<p></p>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
		
		    </div>
		  </div>
		</div>
    
    <div class="card-footer">card foot</div>
  </div>
</div>

</body>
</html>