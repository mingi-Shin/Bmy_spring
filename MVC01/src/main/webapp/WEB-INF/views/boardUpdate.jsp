<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
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
    
    	<form action="${pageContext.request.contextPath}/boardUpdate.do" method="post">
    	<input type="hidden" name="idx" value="${vo.idx }">
    		<table class="table">
    			<tr>
    				<th>제목</th>
    				<td><input type="text" name="title" class="form-control" value="${vo.title }" /></td>
    			</tr>
    			<tr>
    				<th>내용</th>
    				<td><textarea rows="7" name="content" class="form-control" >${vo.content }</textarea></td>
    			</tr>
    			<tr>
    				<th>작성자</th>
    				<td><input type="text" class="form-control" value="${vo.writer }" readonly/></td>
    			</tr>
    			<tr>
    				<td colspan="2" align="center">
    					<button type="submit" class="btn btn-primary btn-sm">수정</button>
    					<button type="reset" class="btn btn-warning btn-sm">취소</button>
    					<button type="button" class="btn btn-warning btn-sm" onclick="location.href='${pageContext.request.contextPath}/boardList.do'">목록</button>
    				</td>
    			</tr>
    		</table>
    	</form>
    	
    </div>
    <div class="card-footer">인프런_스프1탄_박매일</div>
  </div>
</div>

</body>
</html>