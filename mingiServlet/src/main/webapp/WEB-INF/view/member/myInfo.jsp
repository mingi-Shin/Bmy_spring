<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<!-- 내 정보 조회 및 수정 페이지 -->
<table style="width: 100%; margin-top: 30px;">
    <tr>
        <td style="text-align: center;">
            <h2>내 정보 관리</h2>
            <p>회원 정보를 확인하고 수정할 수 있습니다.</p>
        </td>
    </tr>
    <tr>
        <td style="text-align: center; padding: 20px;">
            <!-- 회원정보 수정 처리를 위한 서블릿 연결 -->
            <form action="updateMember.do" method="post">
                <table style="width: 600px; margin: 0 auto; border: 1px solid #ddd; padding: 20px;">
                    <!-- 아이디 표시 (수정 불가) -->
                    <tr>
                        <td width="30%" style="padding: 10px;">아이디</td>
                        <td width="70%" style="padding: 10px;">
                            <input type="text" name="userId" value="user001" style="width: 100%; padding: 8px;" readonly>
                        </td>
                    </tr>
                    <!-- 이름 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">이름</td>
                        <td style="padding: 10px;">
                            <input type="text" name="userName" value="홍길동" style="width: 100%; padding: 8px;" required>
                        </td>
                    </tr>
                    <!-- 현재 비밀번호 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">현재 비밀번호 *</td>
                        <td style="padding: 10px;">
                            <input type="password" name="currentPassword" style="width: 100%; padding: 8px;" required>
                            <div style="font-size: 12px; margin-top: 5px; color: #666;">비밀번호 확인을 위해 입력해주세요.</div>
                        </td>
                    </tr>
                    <!-- 새 비밀번호 입력 필드 -->
                    <tr>
                        <td style="padding: 10px;">새 비