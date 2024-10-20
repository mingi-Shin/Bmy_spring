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
			
			let result = '${result}';
			checkModal(result);
		
		});		
		
		function checkModal(result){
			if(result == ''){
				return;
			}
			if(parseInt(result) > 0){
				//새로운 다이얼로그 창 띄우기 
				$(".modal-body").html("게시글 "+ parseInt(result) + "번이 등록되었스브니다." );
				$("#myModal").modal("show");
			}
		}
		
	
	</script>
</head>
<body>
<div class="card">
	<h2>Spring MVC_3Tier</h2>
  <div class="card-header">
	<c:if test="${empty loginM}">
		<form action="${contextPath }/login/loginProcess" method="post">
			<div class="row float-end">
			  <div class="col-auto d-flex align-items-center">
			    <label for="memID" class="form-label mb-0 me-2">ID:</label>
			    <input type="text" class="form-control" id="memID" placeholder="Enter ID" name="memID">
			  </div>
			  <div class="col-auto d-flex align-items-center">
			    <label for="memPwd" class="form-label mb-0 me-2">Password:</label>
			    <input type="password" class="form-control" id="memPwd" placeholder="Enter password" name="memPwd">
			  </div>
				<div class="col-auto d-flex align-items-center">
				  <button type="submit" class="btn btn-sm btn-primary">로그인</button>
				</div>
			</div>
		</form>
  </c:if>
  <c:if test="${!empty loginM}">
		<form action="${contextPath }/login/logoutProcess" method="post">
			<div class="row float-end">
			  <div class="col-auto d-flex align-items-center">
			    <label>${loginM.memName }님 방문을 환영합니다.</label>
			  </div>
				<div class="col-auto d-flex align-items-center">
				  <button type="submit" class="btn btn-sm btn-primary">로그아웃</button>
				</div>
			</div>
		</form>
  </c:if>
  </div>
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
  				<td><a href="${contextPath}/board/get?boardIdx=${vo.vaordIdx}">${vo.title }</a></td>
  				<td>${vo.writer }</td>
  				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.indate }" /></td>
  				<td>${vo.count }</td>
  			</tr>
  		</c:forEach>
			<c:if test="${!empty loginM }">
	  		<tr>
	  			<td colspan="5">
	  				<button id="regBtn" class="btn btn-sm btn-primary float-end">글쓰기</button>
	  			</td>
	  		</tr>
			</c:if>
  	</table>
  	
  	<!-- The Modal -->
		<div class="modal" id="myModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">Modal Heading</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	<!-- 내용 넣으쇼 -->
		      	
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
		
		    </div>
		  </div>
		</div>
  	<!-- Modal 끝  -->
  	
  </div>
  <div class="card-footer">스프2_(답변게시판)</div>
</div>
</body>
</html>

<!--  
	"board/get?idx=${...}" 는 서비스로직에서 @RequestParm("idx") int idx, ... 형식의 매개변수로 받는다.
		=> URL쿼리 스트링으로 값을 전달할 때 주로 사용
		
	POST는 보통 HTTPS로 정보를 암호화하여 FORM 이나 JSON으로 데이터를 전달합니다 .
-->