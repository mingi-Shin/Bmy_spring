<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
대충 해
<form action="${ cpath}/member/register" method="post">
	<input type="text" name="username" placeholder="Email">
	<input type="password" name="password" placeholder="password">
	<input type="text" name="name" placeholder="이름">
	<!-- 라디오 버튼을 사용해 role을 선택 -->
	<label>
		<input type="radio" name="role" value="MANAGER"> MANAGER
	</label>
	<label>
		<input type="radio" name="role" value="MEMBER_READ_ONLY" checked> MEMBER_READ_ONLY
	</label>
	<label>
		<input type="radio" name="role" value="MEMBER_READ_WRITE"> MEMBER_READ_WRITE
	</label>
	<button type="submit">회원가입</button>
</form>

</body>
</html>