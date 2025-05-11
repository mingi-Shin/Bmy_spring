<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>미니 웹프로젝트</title>
    <style>
        /* 기본 스타일 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        /* 테이블 공통 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        /* 헤더 네비게이션 스타일 */
        .header-nav {
            background-color: #333;
            color: white;
        }
        .header-nav td a {
            color: white;
            text-decoration: none;
            padding: 10px;
            display: inline-block;
        }
        .header-nav td a:hover {
            background-color: #555;
        }
        /* 로고 스타일 */
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- 헤더 테이블: 로고와 네비게이션 메뉴를 포함 -->
    <table class="header-nav">
        <tr>
            <!-- 로고 영역 -->
            <td width="20%" class="logo">미니웹프로젝트</td>
            <!-- 네비게이션 메뉴 영역 -->
            <td width="60%">
                <a href="index.jsp">홈</a>
                <a href="member/memberMain.jsp">회원관리</a>
                <a href="board/boardList.jsp">자유게시판</a>
                <a href="movie/movieList.jsp">영화예약</a>
                <a href="todo/todoList.jsp">To-Do List</a>
            </td>
            <!-- 로그인/로그아웃 영역 -->
            <td width="20%" style="text-align: right;">
                <c:choose>
                    <c:when test="${empty sessionScope.userId}">
                        <a href="member/login.jsp">로그인</a>
                    </c:when>
                    <c:otherwise>
                        ${sessionScope.userName}님 환영합니다
                        <a href="member/logout.do">로그아웃</a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </table>
    <!-- 헤더 아래에 구분선 추가 -->
    <table>
        <tr>
            <td style="border-bottom: 2px solid #333;"></td>
        </tr>
    </table>
    <!-- 본문 컨텐츠 시작 -->
    <div class="content">