<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약 완료</title>
    <style>
        table {
            width: 70%;
            margin: 0 auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
        }
        th {
            background-color: #f2f2f2;
            width: 30%;
            text-align: right;
        }
        td {
            width: 70%;
        }
        .center {
            text-align: center;
        }
        .button-container {
            margin-top: 30px;
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin: 0 10px;
        }
        .home-btn {
            background-color: #2196F3;
            color: white;
        }
        .mypage-btn {
            background-color: #4CAF50;
            color: white;
        }
        .home-btn:hover {
            background-color: #0b7dda;
        }
        .mypage-btn:hover {
            background-color: #45a049;
        }
        .success-message {
            background-color: #dff0d8;
            color: #3c763d;
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid #d6e9c6;
            border-radius: 4px;
            text-align: center;
            font-size: 18px;
        }
        .qr-code {
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <!-- Header 영역 -->
    <jsp:include page="header.jsp" />
    
    <!-- 예약 완료 메인 컨텐츠 -->
    <div class="content">
        <h1 class="center">예약이 완료되었습니다</h1>
        
        <div class="success-message">
            예약이 성공적으로 완료되었습니다. 아래 예약 정보를 확인해주세요.
        </div>
        
        <!-- 예약 번호 및 QR 코드 -->
        <div class="qr-code">
            <p>예약 번호: <strong>${reservation.reservationId}</strong> (실제로는 ${reservation.reservationId})</p>
            <img src="/api/placeholder/150/150" alt="예약 QR 코드">
            <p>입장 시 위 QR 코드를 제시해 주세요.</p>
        </div>
        
        <!-- 예약 정보 테이블 -->
        <table>
            <tr>
                <th>영화</th>
                <td>인셉션 (실제로는 ${reservation.movie.title})</td>
            </tr>
            <tr>
                <th>상영관</th>
                <td>1관 (실제로는 ${reservation.theater})</td>
            </tr>
            <tr>
                <th>상영 일자</th>
                <td>2025-05-10 (실제로는 ${reservation.date})</td>
            </tr>
            <tr>
                <th>상영 시간</th>
                <td>19:10 (실제로는 ${reservation.time})</td>
            </tr>
            <tr>
                <th>좌석</th>
                <td>A4, A5, B7 (실제로는 ${reservation.seats})</td>
            </tr>
            <tr>
                <th>인원</th>
                <td>3명 (실제로는 ${reservation.numberOfPeople}명)</td>
            </tr>
            <tr>
                <th>결제 금액</th>
                <td>36,000원 (실제로는 ${reservation.totalPrice}원)</td>
            </tr>
            <tr>
                <th>예약자</th>
                <td>홍길동 (실제로는 ${reservation.customerName})</td>
            </tr>
            <tr>
                <th>예약 일시</th>
                <td>2025-05-10 15:30:45 (실제로는 ${reservation.reservationTime})</td>
            </tr>
        </table>
        
        <!-- 안내 메시지 -->
        <div class="center" style="margin-top: 20px;">
            <p>* 상영 시작 10분 전까지 입장해 주세요.</p>
            <p>* 예약 취소는 상영 시작 1시간 전까지 가능합니다.</p>
            <p>* 예약 내역은 마이페이지에서 확인하실 수 있습니다.</p>
        </div>
        
        <!-- 버튼 영역 -->
        <div class="button-container">
            <button class="btn home-btn" onclick="location.href='index.jsp'">홈으로</button>
            <button class="btn mypage-btn" onclick="location.href='myReservations.do'">예약 내역 보기</button>
        </div>
    </div>
    
    <!-- Footer 영역 -->
    <jsp:include page="footer.jsp" />
    
    <!-- 
    예약 완료 페이지 주석:
    1. 이 페이지는 영화 예약이 성공적으로 완료된 후 표시되는 페이지입니다.
    2. 예약 번호와 QR 코드를 제공하여 사용자가 영화관 입장 시 사용할 수 있도록 합니다.
    3. 예약된 영화, 상영관, 일자, 시간, 좌석, 인원, 결제 금액 등 예약 정보를 테이블 형태로 표시합니다.
    4. 상영 관련 안내사항을 표시하여 사용자에게 필요한 정보를 제공합니다.
    5. '홈으로' 버튼과 '예약 내역 보기' 버튼을 제공하여 사용자가 다음 행동을 선택할 수 있게 합니다.
    6. EL(Expression Language)을 사용하여 서버에서 전달받은 예약 정보를 동적으로 표시합니다.
    7. 실제 구현 시에는 샘플 데이터 대신 서블릿에서 전달받은 예약 데이터를 사용합니다.
    -->
</body>
</html>