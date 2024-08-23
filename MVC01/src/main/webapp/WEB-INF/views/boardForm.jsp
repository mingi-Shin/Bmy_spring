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
  <div class="card">
    <div class="card-header">BOARD</div>
    <div class="card-body">
    
     <form action="boardInsert.do" method="post">
      <table class="table">
         <tr>
           <td>제목</td>
           <td><input type="text" name="title" class="form-control"/></td>
         </tr>
         <tr>
           <td>내용</td>
           <td><textarea rows="7" name="content" class="form-control"></textarea> </td>
         </tr>
         <tr>
           <td>작성자</td>
           <td><input type="text" name="writer" class="form-control"/></td>
         </tr>
         <tr>
         	<td colspan="2" align="center">
         		<button type="submit" class="btn btn-success btn-sm">등록</button>
         		<button type="reset" class="btn btn-warning btn-sm">취소</button>
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