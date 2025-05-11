<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 게시판 목록 페이지 -->
<table style="width: 100%; margin-top: 20px;">
    <tr>
        <td colspan="5" style="text-align: center; padding: 20px; background-color: #f2f2f2;">
            <h2>자유게시판</h2>
            <p>자유롭게 의견을 나누는 공간입니다.</p>
        </td>
    </tr>
    
    <!-- 검색 영역 -->
    <tr>
        <td colspan="5" style="padding: 15px; text-align: right;">
            <form action="boardList.jsp" method="get">
                <select name="searchType" style="padding: 8px;">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input type="text" name="searchKeyword" style="padding: 8px; width: 200px;">
                <input type="submit" value="검색" style="padding: 8px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
            </form>
        </td>
    </tr>
    
    <!-- 게시글 목록 테이블 -->
    <tr style="background-color: #f2f2f2; border-bottom: 1px solid #ddd;">
        <th width="10%" style="padding: 10px;">번호</th>
        <th width="50%" style="padding: 10px;">제목</th>
        <th width="15%" style="padding: 10px;">작성자</th>
        <th width="15%" style="padding: 10px;">작성일</th>
        <th width="10%" style="padding: 10px;">조회수</th>
    </tr>
    
    <!-- 공지사항 (관리자가 작성한 글은 상단에 고정) -->
    <tr style="background-color: #f9f9f9;">
        <td style="padding: 10px; text-align: center;"><span style="color: red;">[공지]</span></td>
        <td style="padding: 10px;">
            <a href="boardView.jsp?boardId=100" style="color: #000; text-decoration: none; font-weight: bold;">공지사항: 게시판 이용 규칙 안내</a>
        </td>
        <td style="padding: 10px; text-align: center;">관리자</td>
        <td style="padding: 10px; text-align: center;">2025-05-01</td>
        <td style="padding: 10px; text-align: center;">352</td>
    </tr>
    
    <!-- 일반 게시글 목록 (예시 데이터) -->
    <tr>
        <td style="padding: 10px; text-align: center;">10</td>
        <td style="padding: 10px;">
            <a href="boardView.jsp?boardId=10" style="color: #000; text-decoration: none;">안녕하세요, 새로 가입했습니다.</a>
            <span style="color: red; font-size: 12px;">[3]</span> <!-- 댓글 수 -->
        </td>
        <td style="padding: 10px; text-align: center;">홍길동</td>
        <td style="padding: 10px; text-align: center;">2025-05-10</td>
        <td style="padding: 10px; text-align: center;">42</td>
    </tr>
    <tr>
        <td style="padding: 10px; text-align: center;">9</td>
        <td style="padding: 10px;">
            <a href="boardView.jsp?boardId=9" style="color: #000; text-decoration: none;">영화 추천 부탁드립니다!</a>
            <span style="color: red; font-size: 12px;">[5]</span>
        </td>
        <td style="padding: 10px; text-align: center;">김철수</td>
        <td style="padding: 10px; text-align: center;">2025-05-09</td>
        <td style="padding: 10px; text-align: center;">78</td>
    </tr>
    <tr>
        <td style="padding: 10px; text-align: center;">8</td>
        <td style="padding: 10px;">
            <a href="boardView.jsp?boardId=8" style="color: #000; text-decoration: none;">사이트 이용 문의</a>
            <span style="color: red; font-size: 12px;">[2]</span>
        </td>
        <td style="padding: 10px; text-align: center;">이영희</td>
        <td style="padding: 10px; text-align: center;">2025-05-08</td>
        <td style="padding: 10px; text-align: center;">26</td>
    </tr>
    <tr>
        <td style="padding: 10px; text-align: center;">7</td>
        <td style="padding: 10px;">
            <a href="boardView.jsp?boardId=7" style="color: #000; text-decoration: none;">자바 프로그래밍 질문이 있습니다.</a>
            <span style="color: red; font-size: 12px;">[8]</span>
        </td>
        <td style="padding: 10px; text-align: center;">박민수</td>
        <td style="padding: 10px; text-align: center;">2025-05-07</td>
        <td style="padding: 10px; text-align: center;">95</td>
    </tr>
    <tr>
        <td style="padding: 10px; text-align: center;">6</td>
        <td style="padding: 10px;">
            <a href="boardView.jsp?boardId=6" style="color: #000; text-decoration: none;">주말에 볼만한 영화 추천해주세요</a>
            <span style="color: red; font-size: 12px;">[12]</span>
        </td>
        <td style="padding: 10px; text-align: center;">최지우</td>
        <td style="padding: 10px; text-align: center;">2025-05-06</td>
        <td style="padding: 10px; text-align: center;">124</td>
    </tr>
    
    <!-- 페이지 네비게이션 -->
    <tr>
        <td colspan="5" style="text-align: center; padding: 15px;">
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none;">이전</a>
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none; background-color: #4CAF50; color: white;">1</a>
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none;">2</a>
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none;">3</a>
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none;">4</a>
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none;">5</a>
            <a href="#" style="padding: 5px 10px; margin: 0 2px; border: 1px solid #ddd; text-decoration: none;">다음</a>
        </td>
    </tr>
    
    <!-- 글쓰기 버튼 (로그인한 사용자만 보임) -->
    <tr>
        <td colspan="5" style="text-align: right; padding: 15px;">
            <c:if test="${not empty sessionScope.userId}">
                <a href="boardWrite.jsp" style="padding: 8px 20px; background-color: #2196F3; color: white; text-decoration: none;">글쓰기</a>
            </c:if>
        </td>
    </tr>
</table>

<%@ include file="../footer.jsp" %>