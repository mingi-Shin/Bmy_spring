<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 로그인 폼 -->
<table style="width: 100%; margin-top: 50px;">
    <tr>
        <td style="text-align: center;">
            <h2>로그인</h2>
            <p>회원 서비스 이용을 위해 로그인해주세요.</p>
        </td>
    </tr>
    <tr>
        <td style="text-align: center; padding: 20px;">
            <!-- 로그인 처리를 위한 서블릿 연결 -->
            <form action="loginProcess.do" method="post">
                <table style="width: 400px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;">
                    <!-- 에러 메시지가 있는 경우 표시 -->
                    <c:if test="${not empty param.error}">
                        <tr>
                            <td colspan="2" style="color: red; text-align: center;">
                                아이디 또는 비밀번호가 일치하지 않습니다.
                            </td>
                        </tr>
                    </c:if>
                    <!-- 아이디 입력 필드 -->
                    <tr>
                        <td width="30%" style="padding: 10px;">아이디</td>
                        <td width="70%" style="padding: 10px;">
                            <input type="text" name="userId" style="width: 100%; padding: 8px;" required>
                        </td>
                    </tr>
                    <!-- 비밀번호 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">비밀번호</td>
                        <td style="padding: 10px;">
                            <input type="password" name="password" style="width: 100%; padding: 8px;" required>
                        </td>
                    </tr>
                    <!-- 자동 로그인 체크박스 -->
                    <tr>
                        <td colspan="2" style="padding: 10px;">
                            <input type="checkbox" name="remember" id="remember">
                            <label for="remember">아이디 저장</label>
                        </td>
                    </tr>
                    <!-- 로그인 버튼 -->
                    <tr>
                        <td colspan="2" style="padding: 10px; text-align: center;">
                            <input type="submit" value="로그인" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                        </td>
                    </tr>
                    <!-- 링크 영역 -->
                    <tr>
                        <td colspan="2" style="padding: 10px; text-align: center;">
                            <a href="findId.jsp" style="color: blue; text-decoration: none; margin-right: 10px;">아이디 찾기</a> |
                            <a href="findPassword.jsp" style="color: blue; text-decoration: none; margin-left: 10px; margin-right: 10px;">비밀번호 찾기</a> |
                            <a href="register.jsp" style="color: blue; text-decoration: none; margin-left: 10px;">회원가입</a>
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>

<%@ include file="../footer.jsp" %>