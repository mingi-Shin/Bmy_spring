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

	<c:if test="${!empty loginM}">
		<c:if test="${loginM.memProfile eq ''}" >
			<img alt="기본이미지" src="${contextPath }/resources/images/defaultProfile.jpg" style="width: 50px; height: 50px;" > 
		</c:if>
		<c:if test="${loginM.memProfile ne ''}" >
			<img alt="회원 이미지" src="${contextPath }/resources/upload/${loginM.memProfile}" style="width: 50px; height: 50px;" > 
		</c:if>
		<label>${loginM.memName}님 방문을 환영합니다. </label>
	</c:if>
	
	<c:if test="${empty loginM}">
		<label>로그인을 진행해주세요. </label>
	</c:if>
  
  <div class="card card-default">
    <div class="image-container">
			<img alt="메인 페이지 이미지" src="${contextPath }/resources/images/mainImage02.png" class="img-fluid" style="max-height: 100%; width: 100%">
		</div>
    <div class="card-body" >
			<!-- Nav tabs -->
			<ul class="nav nav-tabs">
			  <li class="nav-item">
			    <a class="nav-link active" data-bs-toggle="tab" href="#home">Home</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" data-bs-toggle="tab" href="#menu1">게시판</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" data-bs-toggle="tab" href="#menu2">공지사항</a>
			  </li>
			</ul>
			
			<!-- Tab panes -->
			<div class="tab-content">
			  <div class="tab-pane container active" id="home">
			  	<h3>HOME</h3>
			  	
			  </div>
			  <div class="tab-pane container fade" id="menu1">
			  	<h3>게시판</h3>
			  	
			  </div>
			  <div class="tab-pane container fade" id="menu2">
			  	<h3>공지사항</h3>
			  	
			  </div>
			</div>
    </div>
    <div class="card-footer">
    
    </div>
  </div>
  
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