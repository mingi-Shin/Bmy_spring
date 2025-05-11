<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 회원가입 폼 -->
<table style="width: 100%; margin-top: 30px;">
    <tr>
        <td style="text-align: center;">
            <h2>회원가입</h2>
            <p>아래 정보를 입력하여 회원가입을 완료해주세요.</p>
        </td>
    </tr>
    <tr>
        <td style="text-align: center; padding: 20px;">
            <!-- 회원가입 처리를 위한 서블릿 연결 -->
            <form action="registerProcess.do" method="post" onsubmit="return validateForm()">
                <table style="width: 600px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;">
                    <!-- 아이디 입력 필드 -->
                    <tr>
                        <td width="30%" style="padding: 10px;">아이디 *</td>
                        <td width="70%" style="padding: 10px;">
                            <input type="text" name="userId" id="userId" style="width: 70%; padding: 8px;" required>
                            <button type="button" onclick="checkDuplicate()" style="padding: 8px; background-color: #2196F3; color: white; border: none; cursor: pointer;">중복확인</button>
                            <div id="idCheck" style="font-size: 12px; margin-top: 5px;"></div>
                        </td>
                    </tr>
                    <!-- 비밀번호 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">비밀번호 *</td>
                        <td style="padding: 10px;">
                            <input type="password" name="password" id="password" style="width: 100%; padding: 8px;" required>
                            <div style="font-size: 12px; margin-top: 5px; color: #666;">8자 이상, 영문, 숫자, 특수문자 포함</div>
                        </td>
                    </tr>
                    <!-- 비밀번호 확인 필드 -->
                    <tr>
                        <td style="padding: 10px;">비밀번호 확인 *</td>
                        <td style="padding: 10px;">
                            <input type="password" name="confirmPassword" id="confirmPassword" style="width: 100%; padding: 8px;" required>
                            <div id="pwMatch" style="font-size: 12px; margin-top: 5px;"></div>
                        </td>
                    </tr>
                    <!-- 이름 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">이름 *</td>
                        <td style="padding: 10px;">
                            <input type="text" name="userName" style="width: 100%; padding: 8px;" required>
                        </td>
                    </tr>
                    <!-- 이메일 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">이메일 *</td>
                        <td style="padding: 10px;">
                            <input type="email" name="email" style="width: 100%; padding: 8px;" required>
                        </td>
                    </tr>
                    <!-- 전화번호 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">전화번호</td>
                        <td style="padding: 10px;">
                            <input type="text" name="phone" style="width: 100%; padding: 8px;" placeholder="예: 010-1234-5678">
                        </td>
                    </tr>
                    <!-- 생년월일 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">생년월일</td>
                        <td style="padding: 10px;">
                            <input type="date" name="birthDate" style="width: 100%; padding: 8px;">
                        </td>
                    </tr>
                    <!-- 약관 동의 체크박스 -->
                    <tr>
                        <td colspan="2" style="padding: 10px;">
                            <input type="checkbox" name="agreement" id="agreement" required>
                            <label for="agreement">서비스 이용약관 및 개인정보 처리방침에 동의합니다. *</label>
                        </td>
                    </tr>
                    <!-- 가입 버튼 -->
                    <tr>
                        <td colspan="2" style="padding: 10px; text-align: center;">
                            <input type="submit" value="가입하기" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">
                            <input type="button" value="취소" onclick="location.href='memberMain.jsp'" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; cursor: pointer; margin-left: 10px;">
                        </td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>

<!-- 폼 검증을 위한 자바스크립트 -->
<script>
    // 아이디 중복 확인
    function checkDuplicate() {
        const userId = document.getElementById('userId').value;
        if (!userId) {
            document.getElementById('idCheck').innerHTML = '아이디를 입력해주세요.';
            document.getElementById('idCheck').style.color = 'red';
            return;
        }
        
        // 여기에 실제로는 AJAX를 통해 서버에 중복 확인 요청을 보냄
        // 가상의 응답 처리
        setTimeout(() => {
            document.getElementById('idCheck').innerHTML = '사용 가능한 아이디입니다.';
            document.getElementById('idCheck').style.color = 'green';
        }, 500);
    }
    
    // 비밀번호 일치 확인
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const pw = document.getElementById('password').value;
        const confirmPw = this.value;
        
        if (pw === confirmPw) {
            document.getElementById('pwMatch').innerHTML = '비밀번호가 일치합니다.';
            document.getElementById('pwMatch').style.color = 'green';
        } else {
            document.getElementById('pwMatch').innerHTML = '비밀번호가 일치하지 않습니다.';
            document.getElementById('pwMatch').style.color = 'red';
        }
    });
    
    // 폼 전체 검증
    function validateForm() {
        const pw = document.getElementById('password').value;
        const confirmPw = document.getElementById('confirmPassword').value;
        const agreement = document.getElementById('agreement').checked;
        
        if (pw !== confirmPw) {
            alert('비밀번호가 일치하지 않습니다.');
            return false;
        }
        
        if (!agreement) {
            alert('이용약관에 동의해주세요.');
            return false;
        }
        
        return true;
    }
</script>

<%@ include file="../footer.jsp" %>