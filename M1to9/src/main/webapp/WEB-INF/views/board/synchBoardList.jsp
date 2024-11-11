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
			
			//관리자용 글 랜덤생성기 
			randomRegister();
			  
		});
		
		function randomRegister(){
			// memID, title, content, writer,
			const member = [['winter', '윈터'], ['karina', '카리나'], ['ningning', '닝닝'], ['jijel', '지젤']];
			const title1 = ['즐거운 ','행복한 ','우울한 ','바쁜 ', '절망적인 '];
			const title2 = ['아침', '오후', '하루', '야식시간'];
			const content = ['월요일입니다.','화요일입니다.','수요일입니다.','목요일입니다.','금요일입니다.','토요일입니다.','일요일입니다.'];
			
			function register(){
				let selectedM = member[Math.floor(Math.random() * member.length)];
				let selectedT1 = title1[Math.floor(Math.random() * title1.length)]; 
				let selectedT2 = title2[Math.floor(Math.random() * title2.length)]; 
				let selectedC = content[Math.floor(Math.random() * content.length)];
				
				$.ajax({
					url: `${contextPath}/asynchBoard/board/new`,
					type: 'post',
					data: {
						'memID' : selectedM[0],
						'writer' : selectedM[1],
						'title' : selectedT1 + selectedT2,
						'content' : selectedC,
					},
					beforeSend: function(xhr){
		  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	  			},
					success : function(data){
						window.location.href='${contextPath}/synchBoard/list';
					},
					error: function(jqXHR) {
			    	let errorMessage = "알 수 없는 오류가 발생했습니다.";
				    if (jqXHR.status === 403) {
			        errorMessage = "권한이 없습니다. 접근할 수 없습니다.";
				    } else if (jqXHR.status === 500) {
			        errorMessage = jqXHR.responseText || "서버 오류가 발생했습니다.";
				    }
				    console.log(errorMessage);
				    alert("오류: " + errorMessage + "\n" + jqXHR.status + "입니다");
					}
					
				});
				
			}
			
		}

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
		<security:authorize access="hasRole('ADMIN')">
			<button id="randomRegisterBtn" onclick="randomRegister()">관리자 랜덤글</button>
		</security:authorize>
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
			            <a href="${contextPath}/synchBoard/get/${vo.boardIdx}"><c:out value="${vo.title}"/></a> <!-- xss방지  -->
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
	
	<!-- 페이징 처리 뷰: ${pageMaker } -->
	<div class="pull-right">  
		<ul class="pagination">
	<!-- 이전처리 -->
	
			
	<!-- 페이지 번호 처리 -->
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
			  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
			  <li class="page-item"><a class="page-link" href="#">1</a></li>
			  <li class="page-item active"><a class="page-link" href="#">2</a></li>
			  <li class="page-item"><a class="page-link" href="#">3</a></li>
			  <li class="page-item"><a class="page-link" href="#">Next</a></li>
			</c:forEach>
	<!-- 다음처리 -->
		</ul>		
	</div>
	<!-- END -->
	
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