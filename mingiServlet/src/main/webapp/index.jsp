<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/common/header.jsp" %>

<!-- 메인 페이지 내용 -->
<table>
    <!-- 메인 배너 영역 -->
    <tr>
        <td colspan="3" style="text-align: center; padding: 30px; background-color: #e9f7fe;">
            <h1>미니 웹프로젝트에 오신 것을 환영합니다</h1>
            <p>회원관리, 게시판, 영화예약, To-Do List 기능을 이용해보세요!</p>
        </td>
    </tr>
    
    <!-- 주요 기능 소개 영역 -->
    <tr>
        <!-- 회원관리 기능 소개 -->
        <td width="25%" style="padding: 15px; text-align: center;">
            <h3>회원관리</h3>
            <p>회원가입 및 로그인으로 다양한 서비스를 이용하세요.</p>
            <a href="member/memberMain.jsp" style="color: blue;">바로가기 &raquo;</a>
        </td>
        <!-- 자유게시판 기능 소개 -->
        <td width="25%" style="padding: 15px; text-align: center;">
            <h3>자유게시판</h3>
            <p>다양한 주제로 자유롭게 소통하는 공간입니다.</p>
            <a href="board/boardList.jsp" style="color: blue;">바로가기 &raquo;</a>
        </td>
        <!-- 영화예약 기능 소개 -->
        <td width="25%" style="padding: 15px; text-align: center;">
            <h3>영화예약</h3>
            <p>최신 영화를 간편하게 예약하세요.</p>
            <a href="movie/movieList.jsp" style="color: blue;">바로가기 &raquo;</a>
        </td>
        <!-- To-Do List 기능 소개 -->
        <td width="25%" style="padding: 15px; text-align: center;">
            <h3>To-Do List</h3>
            <p>달력 기반으로 할 일을 관리하세요.</p>
            <a href="todo/todoList.jsp" style="color: blue;">바로가기 &raquo;</a>
        </td>
    </tr>
    
    <!-- 최신 정보 영역 -->
    <tr>
        <!-- 최신 게시글 -->
        <td width="50%" colspan="2" style="padding: 15px; vertical-align: top;">
            <h3>최신 게시글</h3>
            <table style="width: 100%; border: 1px solid #ddd;">
                <tr style="background-color: #f2f2f2;">
                    <th width="70%">제목</th>
                    <th width="30%">작성일</th>
                </tr>
                <!-- 가상의 게시글 데이터 -->
                <tr>
                    <td>안녕하세요 반갑습니다.</td>
                    <td>2025-05-10</td>
                </tr>
                <tr>
                    <td>영화 추천 부탁드립니다!</td>
                    <td>2025-05-09</td>
                </tr>
                <tr>
                    <td>사이트 이용 문의</td>
                    <td>2025-05-08</td>
                </tr>
            </table>
        </td>
        
        <!-- 최신 영화 정보 -->
        <td width="50%" colspan="2" style="padding: 15px; vertical-align: top;">
            <h3>인기 영화</h3>
            <table style="width: 100%; border: 1px solid #ddd;">
                <tr style="background-color: #f2f2f2;">
                    <th width="60%">영화제목</th>
                    <th width="40%">개봉일</th>
                </tr>
                <!-- 가상의 영화 데이터 -->
                <tr>
                    <td>어벤져스: 뉴 비기닝</td>
                    <td>2025-04-25</td>
                </tr>
                <tr>
                    <td>미션 임파서블: 더 파이널</td>
                    <td>2025-05-01</td>
                </tr>
                <tr>
                    <td>스파이더맨: 뉴 유니버스</td>
                    <td>2025-05-15</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<%@ include file="/WEB-INF/view/common/footer.jsp" %>