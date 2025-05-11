<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 게시글 상세 보기 페이지 -->
<table style="width: 100%; margin-top: 20px;">
    <!-- 게시글 제목 영역 -->
    <tr>
        <td colspan="4" style="padding: 15px; background-color: #f2f2f2; font-size: 20px; font-weight: bold;">
            안녕하세요, 새로 가입했습니다.
        </td>
    </tr>
    
    <!-- 게시글 정보 영역 -->
    <tr style="border-bottom: 1px solid #ddd;">
        <td width="20%" style="padding: 10px;">작성자: 홍길동</td>
        <td width="30%" style="padding: 10px;">작성일: 2025-05-10</td>
        <td width="20%" style="padding: 10px;">조회수: 42</td>
        <td width="30%" style="padding: 10px; text-align: right;">
            <!-- 작성자 본인이나 관리자만 보이는 버튼 -->
            <c:if test="${sessionScope.userId eq 'user001' || sessionScope.userRole eq 'ADMIN'}">
                <a href="boardEdit.jsp?boardId=10" style="padding: 5px 10px; background-color: #2196F3; color: white; text-decoration: none; margin-right: 5px;">수정</a>
                <a href="boardDelete.do?boardId=10" style="padding: 5px 10px; background-color: #f44336; color: white; text-decoration: none;" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </c:if>
        </td>
    </tr>
    
    <!-- 게시글 내용 영역 -->
    <tr>
        <td colspan="4" style="padding: 20px; min-height: 200px; vertical-align: top;">
            <p>안녕하세요, 이 커뮤니티에 새로 가입한 홍길동입니다.</p>
            <p>평소에 영화와 프로그래밍에 관심이 많습니다. 특히 서블릿과 JSP를 공부하고 있어요.</p>
            <p>이 사이트를 통해 많은 분들과 좋은 정보 나누고 싶습니다. 앞으로 잘 부탁드립니다!</p>
            <p>제가 요즘 관심 있는 분야는:</p>
            <ul>
                <li>웹 프로그래밍 (HTML, CSS, JavaScript, JSP)</li>
                <li>영화 감상 (주로 SF, 액션 장르)</li>
                <li>독서 (소설, IT 서적)</li>
            </ul>
            <p>이런 주제로 앞으로 여러 글을 작성할 예정입니다. 좋은 만남 되었으면 좋겠습니다!</p>
        </td>
    </tr>
    
    <!-- 첨부파일 영역 (첨부파일이 있는 경우에만 표시) -->
    <tr>
        <td colspan="4" style="padding: 10px; background-color: #f9f9f9;">
            <strong>첨부파일:</strong> 
            <a href="#" style="color: blue; text-decoration: none;">자기소개.pdf</a> (32KB)
        </td>
    </tr>
    
    <!-- 이전글/다음글 내비게이션 -->
    <tr>
        <td colspan="4" style="padding: 10px; border-top: 1px solid #ddd; border-bottom: 1px solid #ddd;">
            <div style="margin-bottom: 5px;">
                <strong>이전글:</strong> <a href="boardView.jsp?boardId=11" style="color: #000; text-decoration: none;">영화 추천 부탁드립니다!</a>
            </div>
            <div>
                <strong>다음글:</strong> <a href="boardView.jsp?boardId=9" style="color: #000; text-decoration: none;">사이트 이용 문의</a>
            </div>
        </td>
    </tr>
    
    <!-- 댓글 목록 영역 -->
    <tr>
        <td colspan="4" style="padding: 15px; background-color: #f2f2f2;">
            <h3>댓글 (3)</h3>
        </td>
    </tr>
    
    <!-- 댓글 1 -->
    <tr>
        <td colspan="4" style="padding: 15px; border-bottom: 1px solid #eee;">
            <table style="width: 100%;">
                <tr>
                    <td width="20%"><strong>김철수</strong></td>
                    <td width="60%" style="color: #666;">2025-05-10 10:30:15</td>
                    <td width="20%" style="text-align: right;">
                        <!-- 댓글 작성자나 관리자만 보이는 버튼 -->
                        <a href="#" style="color: #2196F3; text-decoration: none; margin-right: 5px;">수정</a>
                        <a href="#" style="color: #f44336; text-decoration: none;">삭제</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-top: 10px;">
                        환영합니다! 저도 영화를 좋아합니다. 특히 SF 장르를 좋아하시면 최근 개봉한 '스페이스 오디세이 2025'를 추천드려요.
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    
    <!-- 댓글 2 -->
    <tr>
        <td colspan="4" style="padding: 15px; border-bottom: 1px solid #eee;">
            <table style="width: 100%;">
                <tr>
                    <td width="20%"><strong>이영희</strong></td>
                    <td width="60%" style="color: #666;">2025-05-10 12:45:22</td>
                    <td width="20%" style="text-align: right;">
                        <a href="#" style="color: #2196F3; text-decoration: none; margin-right: 5px;">수정</a>
                        <a href="#" style="color: #f44336; text-decoration: none;">삭제</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-top: 10px;">
                        반갑습니다! JSP와 서블릿 관련해서 질문이 있으시면 언제든지 게시판에 올려주세요.
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    
    <!-- 댓글 3 -->
    <tr>
        <td colspan="4" style="padding: 15px; border-bottom: 1px solid #eee;">
            <table style="width: 100%;">
                <tr>
                    <td width="20%"><strong>박민수</strong></td>
                    <td width="60%" style="color: #666;">2025-05-10 15:20:08</td>
                    <td width="20%" style="text-align: right;">
                        <a href="#" style="color: #2196F3; text-decoration: none; margin-right: 5px;">수정</a>
                        <a href="#" style="color: #f44336; text-decoration: none;">삭제</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-top: 10px;">
                        환영합니다! 저도 프로그래밍을 공부하고 있어요. 함께 정보 공유해요!
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    
    <!-- 댓글 작성 폼 (로그인한 사용자만 보임) -->
    <tr>
        <td colspan="4" style="padding: 15px;">
            <c:choose>
                <c:when test="${not empty sessionScope.userId}">
                    <form action="commentWrite.do" method="post">
                        <input type="hidden" name="boardId" value="10">
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <textarea name="content" rows="3" style="width: 100%; padding: 10px;" placeholder="댓글을 입력하세요..."></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; padding-top: 10px;">
                                    <input type="submit" value="댓글 작성" style="padding: 8px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                                </td>
                            </tr>
                        </table>
                    </form>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 15px; background-color: #f9f9f9;">
                        댓글을 작성하려면 <a href="../member/login.jsp" style="color: blue;">로그인</a>해주세요.
                    </div>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
    
    <!-- 목록으로 돌아가기 버튼 -->
    <tr>
        <td colspan="4" style="text-align: right; padding: 15px;">
            <a href="boardList.jsp" style="padding: 8px 20px; background-color: #607d8b; color: white; text-decoration: none;">목록</a>
        </td>
    </tr>
</table>

<%@ include file="../footer.jsp" %>