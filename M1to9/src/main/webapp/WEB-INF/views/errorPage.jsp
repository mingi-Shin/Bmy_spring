<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Access denied</title>
</head>
<body>
	<h2>error 발생</h2>
	<c:if test="${not empty msgBody}">
    <div class="alert alert-danger">
        ${msgBody}
    </div>
	</c:if>
	<hr>
	<a href="${pageContext.request.contextPath }/">Back to Home Page</a>
</body>
</html>