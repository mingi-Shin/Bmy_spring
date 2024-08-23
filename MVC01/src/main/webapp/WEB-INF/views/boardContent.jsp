<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!--JSTL함수 라이브러리-->
<%-- <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> --%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Latest compiled and minified CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 
<div class="container mt-3">
  <h2>Spring MVC01</h2>
  <div class="card card-default">
    <div class="card-header">BOARD</div>
    <div class="card-body">
    	<table class="table">
    		<tr>
    			<th>제목</th>
    			<td>${vo.title }</td>
    		</tr>
    		<tr>
    			<th>내용</th>
    			<td style="white-space: pre;">${vo.content}</td> <!-- 공백과 줄바꿈을 유지하는 style -->
    		</tr>
    		<tr>
    			<th>작성자</th>
    			<td>${vo.writer }</td>
    		</tr>
    		<tr>
    			<th>작성일(fn:split)</th>
    			<td>${fn:split(vo.indate, " ")[0] }</td>
    		</tr>
    		<tr>
    			<th>작성일(c:set)</th>
    			<c:set var="formattedDate" value="${fn:substring(vo.indate, 0, 16) }"></c:set>
    			<td>${formattedDate }</td>
    		</tr>
    		<tr>
    			<td colspan="2" align="center">
    				<a href="boardUpdateForm.do/${vo.idx}"  class="btn btn-primary btn-sm">수정화면</a>
    				<a href="boardDelete.do/${vo.idx }" class="btn btn-warning btn-sm">삭제</a>
    				<a href="boardList.do" class="btn btn-info btn-sm">목록으로</a>
    			</td>
    		</tr>
    	</table>
    </div>
    <div class="card-footer">인프런_스프1탄_박매일</div>
  </div>
</div>

</body>
</html>