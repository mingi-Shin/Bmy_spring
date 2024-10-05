<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
	<title>admin page: show members</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
  <script>
  	function changeRole(){
  		
  		console.log("언제 만들까 ");
  		
  		
  	}
  </script>
</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp"></jsp:include>

  <h2>show members</h2>
  <div class="card card-default">

    <div class="card-header" >회원 목록</div>
    <div class="card-body" >
   		<table class="table table-bordered" style="width:100%; text-align: center; border: 1px solid #dddddd; ">
   			<tr>
   				<th>아이디 </th>
   				<th>이름 </th>
   				<th>성별 </th>
   				<th>E-Mail</th>
   				<th>회원등급</th>
   				<th>활성화여부</th>
   			</tr>
	   			<c:if test="${empty memberList }">
	   				<td colspan="6">조회가능한 회원이 존재하지 않습니다.</td>
	   			</c:if>
	   			<c:if test="${!empty memberList }">
						<c:forEach var="vo" items="${memberList }">
							<tr>
								<td>${vo.memIdx }, ${vo.memID }</td>
								<td>${vo.memName }</td>
								<td>${vo.memGender }</td>
								<td>${vo.memEmail }</td>
								<td>
									<input type="checkbox" id="'${vo.memIdx }'-roleReader" name="" 
										<c:forEach var="voAuth" items="${vo.authList }">
											<c:if test="${voAuth.auth eq 'ROLE_READER'}">checked</c:if>									
										</c:forEach>
									>[ROLE_READER]
									<input type="checkbox" id="'${vo.memIdx }'-roleWriter" name="" 
										<c:forEach var="voAuth" items="${vo.authList }">
											<c:if test="${voAuth.auth eq 'ROLE_WRITER'}">checked</c:if>									
										</c:forEach>
									>[ROLE_WRITER]
									<input type="checkbox" id="'${vo.memIdx }'-roleManager" name="" 
										<c:forEach var="voAuth" items="${vo.authList }">
											<c:if test="${voAuth.auth eq 'ROLE_MANAGER'}">checked</c:if>									
										</c:forEach>
									>[ROLE_MANAGER]
																			
								</td>
								<td>${vo.is_active }</td>
							<tr>
						</c:forEach>
	   			</c:if>
   		</table>
    </div>
    <div style="display: flex; justify-content: flex-end;">
    	<input type="button" onclick="changeRole()" id="changeRoleButton" value="권한수정">
    </div>
    <div class="card-footer">card foot
    	<p>수정 한번으로 추가, 업뎃, 삭제 모두 처리: Ajax</p>
    </div>
  </div>
</div>

</body>
</html>