<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC01_Home</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Latest compiled and minified CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Latest compiled JavaScript -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
 
<div class="container mt-3">
  <h2>Well come to MVC01 page!</h2>
  <div class="card card-default">
    <div class="card-header">BOARD</div>
    <div class="card-body">
    <h3>홈페이지입니다.</h3>
    <a href="boardList.do" role="button">게시글 목록으로 바로가기</a>
    </div>
    <div class="card-footer">인프런_스프1탄_박매일</div>
  </div>
</div>

</body>
</html>