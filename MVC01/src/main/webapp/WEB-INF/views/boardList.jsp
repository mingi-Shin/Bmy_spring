<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <div class="card">
    <div class="card-header">BOARD</div>
    <div class="card-body">
       <table class="table table-dark table-hover">
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
          <c:forEach var="vo" items="${list}">
           <tr>
            <td>${vo.idx}</td>
            <td><a href="boardContent.do/?idx=${vo.idx}" >${vo.title}</a></td> <!-- GET:쿼리스트링 -->
            <td>${vo.writer}</td>
            <td>${fn:split(vo.indate, " ")[0] }</td>
            <td>${vo.count}</td>
           </tr>
          </c:forEach>
       </table>    
       <a href="boardForm.do" class="btn btn-primary btn-sm">글쓰기</a>
       <button onclick="location.href='template.do';" class="btn btn-success btn-lg">template이동</button>
    </div>
    <div class="card-footer">인프런_스프1탄_박매일</div>
  </div>
</div>

</body>
</html>