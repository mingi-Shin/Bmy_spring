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
<meta charset="UTF-8">
<title>게시판 수정</title>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
		
	$(document).ready(function(){
		goDelete();
		
		//로그인 오류시 실패 모달창show
	  if(${!empty msgBody}){
		  $("#myMessage").modal("show"); 
	  };
		
		
	});
	
	function goDelete(){
		
		$("#deleteButton").on('click', deleteBoard);
		
		function deleteBoard(){
			if(confirm("게시물을 삭제하시겠습니까?")){
				let boardIdx = "${vo.boardIdx}";
				
				$.ajax({
					url: `${contextPath}/synchBoard/delete/${boardIdx}`,
					type: 'DELETE',
					beforeSend: function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success: function(){
						alert("게시물이 삭제되었습니다.");
						location.href=`${contextPath}/synchBoard/list`;
					},
					error: function(error){
						alert("삭제 중 오류가 발생했습니다.");
						console.error("삭제 중 오류 발생:", error);
					}
					
				});
				
				
			} else {
				return;
			}
		}
		
	}
	
	

		 

</script> 

</head>
<body>
  <div class="container">
  	<jsp:include page="../common/header.jsp" />
  
    <div class="card shadow-sm">
      <div class="card-header text-center bg-primary text-white">
        <h3 class="mb-0">게시판 수정</h3>
      </div>
      <div class="card-body">
    		<form action="${contextPath }/synchBoard/modify" method="post" class="was-validated">
       		<input type="hidden" name="boardIdx" value="${vo.boardIdx}" > <!-- 왜 boardIdx 넣는걸 까먹니.. -->
       		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
	        
	        <table class="table table-striped table-borderless">
	          <tbody>
	            <tr>
	              <th scope="row">
									<label class="form-label" for="title">제목: </label>
								</th>
	              <td>
	              	<input class="form-control" id="title" name="title" placeholder="Title" type="text" value="${vo.title }" required>
	              	<div class="valid-feedback">Valid</div>
  								<div class="invalid-feedback">Please fill out this field.</div>
								</td>
	            </tr>
	            <tr>
	              <th scope="row">
	              	<label class="form-label" for="content">내용: </label>
	              </th>
	              <td>
         	  			<textarea class="form-control" id="content" name="content" placeholder="Content" rows="10" required>${vo.content }</textarea>
         	  			<div class="valid-feedback">Valid</div>
  								<div class="invalid-feedback">Please fill out this field.</div>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row">
	              	<label class="form-label" for="writer">작성자: </label>
	              </th>
	              <td>
         	  			<input class="form-control" id="wrtier" name="writer" type="text" value="${vo.writer }" readonly>
	              </td>
	            </tr>
	          </tbody>
	        </table>
	        <div class="text-center mt-4">
	        	<security:authorize access="isAuthenticated()">
        			<!-- <button type="button" onclick="location.href='${contextPath}/synchBoard/delete/${vo.boardIdx}'">삭제</button> -->
	         		<!-- location.href= 는 GET방식으로만 작동된다. -->
	          	<button type="button" id="deleteButton" class="btn btn-outline-danger me-2">삭제</button>
	  					<button type="submit" class="btn btn-primary">Submit</button>
	        	</security:authorize>
	        </div>
        </form>
      </div>
      <div class="card-footer text-muted text-center">
        스프2_(답변게시판)
      </div>
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
s		    </div>
		  </div>
		</div>
    
  </div>
</body>
</html>