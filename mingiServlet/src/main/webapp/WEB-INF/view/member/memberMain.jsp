<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 회원관리 메인 페이지 내용 -->
<table style="width: 100%; margin-top: 20px;">
    <tr>
        <td colspan="2" style="text-align: center; padding: 20px; background-color: #f2f2f2;">
            <h2>회원관리 시스템</h2>
            <p>회원 정보 관리 및 조회를 할 수 있습니다.</p>
        </td>
    </tr>
    
    <!-- 회원 관련 메뉴 표시 -->
    <tr>
        <!-- 로그인하지 않은 경우 -->
        <c:if test="${empty sessionScope.userId}">
            <td width="50%" style="padding: 30px; text-align: center;">
                <h3>로그인</h3>
                <p>서비스 이용을 위해 로그인해주세요.</p>
                <a href="login.jsp" style="display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none;">로그인하기</a>
            </td>
            <td width="50%" style="padding: 30px; text-align: center;">
                <h3>회원가입</h3>
                <p>아직 회원이 아니신가요? 지금 바로 가입하세요.</p>
                <a href="register.jsp" style="display: inline-block; padding: 10px 20px; background-color: #2196F3; color: white; text-decoration: none;">회원가입</a>
            </td>
        </c:if>
        
        <!-- 로그인한 경우 -->
        <c:if test="${not empty sessionScope.userId}">
            <td width="50%" style="padding: 30px; text-align: center;">
                <h3>내 정보 관리</h3>
                <p>회원 정보를 확인하고 수정할 수 있습니다.</p>
                <a href="myInfo.jsp" style="display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none;">내 정보 확인/수정</a>
            </td>
            <td width="50%" style="padding: 30px; text-align: center;">
                <h3>회원 탈퇴</h3>
                <p>더 이상 서비스를 이용하지 않으시겠어요?</p>
                <a href="withdraw.jsp" style="display: inline-block; padding: 10px 20px; background-color: #f44336; color: white; text-decoration: none;">회원 탈퇴</a>
            </td>
        </c:if>
    </tr>
    
    <!-- 관리자인 경우 회원 목록 표시 -->
    <c:if test="${sessionScope.userRole eq 'ADMIN'}">
        <tr>
            <td colspan="2" style="padding: 20px;">
                <h3>회원 목록</h3>
                <table style="width: 100%; border: 1px solid #ddd;">
                    <tr style="background-color: #f2f2f2;">
                        <th>아이디</th>
                        <th>이름</th>
                        <th>이메일</th>
                        <th>가입일</th>
                        <th>관리</th>
                    </tr>
                    <!-- 가상의 회원 데이터 -->
                    <tr>
                        <td>user001</td>
                        <td>홍길동</td>
                        <td>hong@example.com</td>
                        <td>2025-01-15</td>
                        <td>
                            <a href="editMember.jsp?id=user001" style="color: blue;">수정</a> |
                            <a href="deleteMember.do?id=user001" style="color: red;">삭제</a>
                        </td>
                    </tr>
                    <tr>
                        <td>user002</td>
                        <td>김철수</td>
                        <td>kim@example.com</td>
                        <td>2025-02-20</td>
                        <td>
                            <a href="editMember.jsp?id=user002" style="color: blue;">수정</a> |
                            <a href="deleteMember.do?id=user002" style="color: red;">삭제</a>
                        </td>
                    </tr>
                    <tr>
                        <td>user003</td>
                        <td>이영희</td>
                        <td>lee@example.com</td>
                        <td>2025-03-10</td>
                        <td>
                            <a href="editMember.jsp?id=user003" style="color: blue;">수정</a> |
                            <a href="deleteMember.do?id=user003" style="color: red;">삭제</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </c:if>
</table>

<%@ include file="../footer.jsp" %>