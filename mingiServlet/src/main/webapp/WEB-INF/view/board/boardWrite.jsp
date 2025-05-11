<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 게시글 작성 페이지 -->
<table style="width: 100%; margin-top: 20px;">
    <tr>
        <td style="text-align: center; padding: 20px; background-color: #f2f2f2;">
            <h2>게시글 작성</h2>
            <p>자유롭게 의견을 작성해주세요.</p>
        </td>
    </tr>
    
    <tr>
        <td style="padding: 20px;">
            <!-- 게시글 작성 폼 -->
            <form action="boardWriteProcess.do" method="post" enctype="multipart/form-data">
                <table style="width: 100%; border: 1px solid #ddd; padding: 20px;">
                    <!-- 제목 입력 필드 -->
                    <tr>
                        <td width="15%" style="padding: 10px;"><strong>제목</strong></td>
                        <td width="85%" style="padding: 10px;">
                            <input type="text" name="title" style="width: 100%; padding: 8px;" required>
                        </td>
                    </tr>
                    
                    <!-- 글 분류 선택 -->
                    <tr>
                        <td style="padding: 10px;"><strong>분류</strong></td>
                        <td style="padding: 10px;">
                            <select name="category" style="width: 200px; padding: 8px;">
                                <option value="normal">일반</option>
                                <option value="question">질문</option>
                                <option value="review">후기</option>
                                <option value="notice">공지사항</option> <!-- 관리자만 선택 가능하게 처리 -->
                            </select>
                        </td>
                    </tr>
                    
                    <!-- 내용 입력 영역 -->
                    <tr>
                        <td style="padding: 10px;"><strong>내용</strong></td>
                        <td style="padding: 10px;">
                            <textarea name="content" rows="15" style="width: 100%; padding: 8px;" required></textarea>
                        </td>
                    </tr>
                    
                    <!-- 파일 첨부 영역 -->
                    <tr>
                        <td style="padding: 10px;"><strong>파일 첨부</strong></td>
                        <td style="padding: 10px;">
                            <input type="file" name="attachment">
                            <div style="font-size: 12px; color: #666; margin-top: 5px;">최대 10MB까지 업로드 가능합니다.</div>
                        </td>
                    </tr>
                    
                    <!-- 공개 여부 선택 -->
                    <tr>
                        <td style="padding: 10px;"><strong>공개 여부</strong></td>
                        <td style="padding: 10px;">
                            <input type="radio" name="visibility" id="public" value="public" checked>
                            <label for="public">전체 공개</label>
                            <input type="radio" name="visibility" id="private" value="private" style="margin-left: 15px;">
                            <label for="private">비공개</label>
                        </td>
                    </tr>
                    
                    <!-- 버튼 영역 -->
                    <tr>
                        <td colspan="2" style="text-align: center; padding: 20px;">
                            <input type="submit" value="등록" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer; margin-right: 10px;">
                            <input type="button" value="취소" onclick="location.href='boardList.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer;">
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>

<%@ include file="../footer.jsp" %>