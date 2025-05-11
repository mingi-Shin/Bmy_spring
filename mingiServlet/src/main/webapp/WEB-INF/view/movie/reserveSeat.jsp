<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>좌석 예약</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .seat-map {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }
        .screen {
            background-color: #ddd;
            padding: 10px;
            margin-bottom: 30px;
            text-align: center;
            width: 80%;
            margin-left: auto;
            margin-right: auto;
        }
        .seat {
            width: 30px;
            height: 30px;
            margin: 3px;
            border: 1px solid #aaa;
            display: inline-block;
            cursor: pointer;
        }
        .seat.available {
            background-color: #fff;
        }
        .seat.selected {
            background-color: #4CAF50;
        }
        .seat.occupied {
            background-color: #f44336;
            cursor: not-allowed;
        }
        .legend {
            margin: 20px 0;
            text-align: center;
        }
        .legend-item {
            display: inline-block;
            margin: 0 10px;
        }
        .legend-box {
            width: 20px;
            height: 20px;
            display: inline-block;
            vertical-align: middle;
            margin-right: 5px;
        }
        .reserve-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .reserve-btn:hover {
            background-color: #45a049;
        }
        .back-btn {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .back-btn:hover {
            background-color: #d32f2f;
        }
        .button-container {
            margin-top: 20px;
            text-align: center;
        }
    </style>
    <script>
        // 좌석 선택 관련 자바스크립트
        function toggleSeat(seatId) {
            var seat = document.getElementById(seatId);
            if (seat.classList.contains('available')) {
                seat.classList.remove('available');
                seat.classList.add('selected');
                
                // 선택한 좌석 목록에 추가
                var selectedSeatsInput = document.getElementById('selectedSeats');
                var selectedSeats = selectedSeatsInput.value;
                if (selectedSeats !== '') {
                    selectedSeats += ',';
                }
                selectedSeats += seatId;
                selectedSeatsInput.value = selectedSeats;
                
                // 선택한 좌석 표시
                var selectedSeatsDisplay = document.getElementById('selectedSeatsDisplay');
                selectedSeatsDisplay.innerHTML += (selectedSeatsDisplay.innerHTML === '' ? '' : ', ') + seatId;
                
                // 가격 업데이트
                updatePrice();
            } else if (seat.classList.contains('selected')) {
                seat.classList.remove('selected');
                seat.classList.add('available');
                
                // 선택한 좌석 목록에서 제거
                var selectedSeatsInput = document.getElementById('selectedSeats');
                var selectedSeats = selectedSeatsInput.value.split(',');
                var index = selectedSeats.indexOf(seatId);
                if (index !== -1) {
                    selectedSeats.splice(index, 1);
                }
                selectedSeatsInput.value = selectedSeats.join(',');
                
                // 선택한 좌석 표시 업데이트
                var selectedSeatsDisplay = document.getElementById('selectedSeatsDisplay');
                selectedSeatsDisplay.innerHTML = selectedSeats.join(', ');
                
                // 가격 업데이트
                updatePrice();
            }
        }
        
        function updatePrice() {
            var selectedSeatsInput = document.getElementById('selectedSeats');
            var selectedSeats = selectedSeatsInput.value;
            var seatCount = selectedSeats === '' ? 0 : selectedSeats.split(',').length;
            var pricePerSeat = 12000; // 1인당 가격 (원)
            var totalPrice = seatCount * pricePerSeat;
            
            document.getElementById('seatCount').innerHTML = seatCount;
            document.getElementById('totalPrice').innerHTML = totalPrice.toLocaleString() + '원';
        }
    </script>
</head>
<body>
    <!-- Header 영역 -->
    <jsp:include page="header.jsp" />
    
    <!-- 좌석 예약 메인 컨텐츠 -->
    <div class="content">
        <h1>좌석 예약</h1>
        
        <!-- 영화 및 상영 정보 -->
        <table>
            <tr>
                <th>영화</th>
                <td>인셉션 (실제로는 ${schedule.movie.title})</td>
                <th>상영관</th>
                <td>1관 (실제로는 ${schedule.theater})</td>
            </tr>
            <tr>
                <th>일자</th>
                <td>2025-05-10 (실제로는 ${schedule.date})</td>
                <th>시간</th>
                <td>19:10 (실제로는 ${schedule.time})</td>
            </tr>
        </table>
        
        <!-- 좌석 선택 영역 -->
        <div class="seat-map">
            <div class="screen">스크린</div>
            
            <!-- A열 ~ H열 좌석 (8행 12열) -->
            <c:forEach var="row" items="A,B,C,D,E,F,G,H">
                <div class="seat-row">
                    <span style="display: inline-block; width: 30px;">${row}</span>
                    <c:forEach var="col" begin="1" end="12">
                        <c:set var="seatId" value="${row}${col}" />
                        <c:choose>
                            <c:when test="${occupiedSeats.contains(seatId)}">
                                <div id="${seatId}" class="seat occupied" title="이미 예약된 좌석">${col}</div>
                            </c:when>
                            <c:otherwise>
                                <div id="${seatId}" class="seat available" onclick="toggleSeat('${seatId}')">${col}</div>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:forEach>
            
            <!-- 샘플 좌석 (실제로는 위의 JSTL이 적용됨) -->
            <div class="seat-row">
                <span style="display: inline-block; width: 30px;">A</span>
                <div id="A1" class="seat available" onclick="toggleSeat('A1')">1</div>
                <div id="A2" class="seat available" onclick="toggleSeat('A2')">2</div>
                <div id="A3" class="seat occupied" title="이미 예약된 좌석">3</div>
                <div id="A4" class="seat available" onclick="toggleSeat('A4')">4</div>
                <div id="A5" class="seat available" onclick="toggleSeat('A5')">5</div>
                <div id="A6" class="seat available" onclick="toggleSeat('A6')">6</div>
                <div id="A7" class="seat available" onclick="toggleSeat('A7')">7</div>
                <div id="A8" class="seat available" onclick="toggleSeat('A8')">8</div>
                <div id="A9" class="seat occupied" title="이미 예약된 좌석">9</div>
                <div id="A10" class="seat occupied" title="이미 예약된 좌석">10</div>
                <div id="A11" class="seat available" onclick="toggleSeat('A11')">11</div>
                <div id="A12" class="seat available" onclick="toggleSeat('A12')">12</div>
            </div>
            <div class="seat-row">
                <span style="display: inline-block; width: 30px;">B</span>
                <div id="B1" class="seat available" onclick="toggleSeat('B1')">1</div>
                <div id="B2" class="seat available" onclick="toggleSeat('B2')">2</div>
                <div id="B3" class="seat available" onclick="toggleSeat('B3')">3</div>
                <div id="B4" class="seat available" onclick="toggleSeat('B4')">4</div>
                <div id="B5" class="seat occupied" title="이미 예약된 좌석">5</div>
                <div id="B6" class="seat occupied" title="이미 예약된 좌석">6</div>
                <div id="B7" class="seat available" onclick="toggleSeat('B7')">7</div>
                <div id="B8" class="seat available" onclick="toggleSeat('B8')">8</div>
                <div id="B9" class="seat available" onclick="toggleSeat('B9')">9</div>
                <div id="B10" class="seat available" onclick="toggleSeat('B10')">10</div>
                <div id="B11" class="seat available" onclick="toggleSeat('B11')">11</div>
                <div id="B12" class="seat available" onclick="toggleSeat('B12')">12</div>
            </div>
            
            <!-- 좌석 범례 -->
            <div class="legend">
                <div class="legend-item">
                    <div class="legend-box seat available"></div> 선택 가능
                </div>
                <div class="legend-item">
                    <div class="legend-box seat selected"></div> 선택한 좌석
                </div>
                <div class="legend-item">
                    <div class="legend-box seat occupied"></div> 이미 예약됨
                </div>
            </div>
        </div>
        
        <!-- 예약 정보 요약 -->
        <form action="completeReservation.do" method="post">
            <input type="hidden" name="scheduleId" value="${param.scheduleId}">
            <input type="hidden" name="selectedSeats" id="selectedSeats" value="">
            
            <table>
                <tr>
                    <th>선택한 좌석</th>
                    <td id="selectedSeatsDisplay"></td>
                </tr>
                <tr>
                    <th>인원</th>
                    <td><span id="seatCount">0</span>명</td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><span id="totalPrice">0원</span> (1인당 12,000원)</td>
                </tr>
            </table>
            
            <div class="button-container">
                <button type="button" class="back-btn" onclick="history.back()">이전으로</button>
                <button type="submit" class="reserve-btn">예약 완료</button>
            </div>
        </form>
    </div>
    
    <!-- Footer 영역 -->
    <jsp:include page="footer.jsp" />
    
    <!-- 
    좌석 예약 페이지 주석:
    1. 이 페이지는 영화 상영 일정에 맞는 좌석을 선택하는 페이지입니다.
    2. 상단에 선택한 영화, 상영관, 일자, 시간 정보를 표시합니다.
    3. 좌석 배치도를 시각적으로 표현하여 사용자가 원하는 좌석을 쉽게 선택할 수 있게 합니다.
    4. 자바스크립트를 사용하여 좌석 선택/취소 기능과 가격 자동 계산 기능을 구현합니다.
    5. 이미 예약된 좌석은 빨간색으로 표시되어 선택할 수 없게 합니다.
    6. 사용자가 선택한 좌석은 녹색으로 표시됩니다.
    7. 선택한 좌석, 인원 수, 총 가격 정보를 하단에 표시하여 사용자가 예약 내용을 확인할 수 있습니다.
    8. '예약 완료' 버튼을 누르면 예약 정보를 서버로 전송하여 저장합니다.
    9. JSTL을 사용하여 서버에서 전달받은 좌석 정보를 동적으로 표시합니다.
    10. 실제 구현 시에는 샘플 데이터 대신 서블릿에서 전달받은 데이터를 사용합니다.
    -->