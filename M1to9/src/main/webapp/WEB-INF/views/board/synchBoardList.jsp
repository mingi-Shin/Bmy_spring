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
	<title>동기적 게시판 리스트</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
 	<script type="text/javascript">
		$(document).ready(function(){
			
			//로그인 오류시 실패 모달창show
		  if(${!empty msgBody}){
			  $("#myMessage").modal("show"); 
		  }
			
			$("#registerButton").click(function(){
				location.href="${contextPath}/synchBoard/register"; //GET
			});
			  
		});

 	</script>  
 	
	<style>
	  table {
	    border-collapse: collapse;
	    width: 100%;
	    margin: 20px 0;
	  }
	
	  th, td {
	    border: solid 1px #ddd;
	    padding: 10px;
	    text-align: left;
	  }
	
	  th {
	    background-color: #f2f2f2;
	  }
	
	  a {
	    color: #007BFF;
	    text-decoration: none;
	  }
	
	  a:hover {
	    text-decoration: underline;
	  }
	
	  .no-data {
	    text-align: center;
	    color: #888;
	    padding: 10px;
	  }
	</style>
</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp" />

  <h1>Spring MVC01 to MVC09</h1>
  <div class="card">
    <div class="card-header" >게시판 목록</div>
    <div class="card-body" >
    
    
			<table>
			  <thead>
			    <tr>
			      <th>인덱스</th>
			      <th>제목</th>
			      <th>글쓴이</th>
			      <th>작성일</th>
			      <th>조회수</th>
			    </tr>
			  </thead>
			  <tbody>
			    <c:if test="${!empty vo}">
			      <c:forEach var="vo" items="${vo}">
			        <tr>
			          <td>${vo.boardIdx}</td>
			          <td>
			            <a href="${contextPath}/synchBoard/get/${vo.boardIdx}">${vo.title}</a>
			          </td>
			          <td>${vo.writer}</td>
			          <td>
			            <fmt:formatDate value="${vo.indate}" pattern="yyyy-MM-dd"/>
			          </td>
			          <td>${vo.count}</td>
			        </tr>
			      </c:forEach>
			    </c:if>
			
			    <c:if test="${empty vo}">
			      <tr>
			        <td colspan="5" class="no-data">
			          현재 조회가능한 게시물이 없습니다.
			        </td>
			      </tr>
			    </c:if>
			  </tbody>
			</table>
	    <button id="registerButton" class="btn btn-primary float-end">글쓰기 </button>
    </div>
    <div class="card-footer">card foot</div>
    ${mvo }
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