<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<script type="text/javascript">
	$(document).ready(function(){
		
		console.log('${user}');

		
	});
	
	
	</script>
</head>
<body>
<h4>유미의 Security</h4>

<table border="1">
	<thead>
		<tr>
			<th>userInfo</th>		
			<td>${userInfo }</td>
		</tr>
		<tr>
			<th>role</th>		
			<td>${role }</td>
		</tr>
		<tr>
			<th>Credentials</th>		
			<td>${Credentials }</td>
		</tr>
		<tr>
			<th>details</th>		
			<td>${details }</td>
		</tr>
		<tr>
			<th>name</th>		
			<td>${name }</td>
		</tr>
		<tr>
			<th>principal</th>		
			<td>${principal }</td>
		</tr>
	</thead>
</table>
</body>
</html>