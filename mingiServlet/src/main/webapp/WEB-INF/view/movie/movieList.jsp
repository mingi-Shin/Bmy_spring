<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 영화 목록 페이지 -->
<table style="width: 100%; margin-top: 20px;">
    <tr>
        <td colspan="4" style="text-align: center; padding: 20px; background-color: #f2f2f2;">
            <h2>영화 예약 시스템</h2>
            <p>현재 상영 중인 영화를 확인하고 예약하세요.</p>
        </td>
    </tr>
    
    <!-- 검색 및 필터링 영역 -->
    <tr>
        <td colspan="4" style="padding: 15px; background-color: #f9f9f9;">
            <table style="width: 100%;">
                <tr>
                    <td width="50%">
                        <!-- 장르별 필터링 -->
                        <form action="movieList.jsp" method="get" style="display: inline-block;">
                            <select name="genre" style="padding: 8px; margin-right: 10px;">
                                <option value="">모든 장르</option>
                                <option value="action">액션</option>
                                <option value="comedy">코미디</option>
                                <option value="drama">드라마</option>
                                <option value="sf">SF</option>
                                <option value="horror">공포</option>
                                <option value="romance">로맨스</option>
                            </select>
                            <input type="submit" value="필터" style="padding: 8px 15px; background-color: #2196F3; color: white; border: none; cursor: pointer;">
                        </form>
                    </td>
                    <td width="50%" style="text-align: right;">
                        <!-- 영화 검색 -->
                        <form action="movieList.jsp" method="get">
                            <input type="text" name="searchKeyword" placeholder="영화 제목 검색" style="padding: 8px; width: 200px;">
                            <input type="submit" value="검색" style="padding: 8px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                        </form>
                    </td>
                </tr>
            </table>
        </td>