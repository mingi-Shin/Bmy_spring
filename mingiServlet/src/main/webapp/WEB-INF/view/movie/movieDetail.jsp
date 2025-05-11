<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 상세 정보</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            width: 20%;
            text-align: right;
        }
        td {
            width: 80%;
        }
        .movie-poster {
            width: 200px;
            height: auto;
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
</head>
<body>
    <!-- Header 영역 -->
    <jsp:include page="header.jsp" />
    
    <!-- 영화 상세 정보 메인 컨텐츠 -->
    <div class="content">
        <h1>${movie.title} 상세 정보</h1>
        
        <!-- 영화 상세 정보 테이블 -->
        <table>
            <tr>
                <th>포스터</th>
                <td>
                    <img src="${movie.posterUrl}" alt="${movie.title} 포스터" class="movie-poster">
                    <!-- 샘플 이미지 (실제로는 위의 EL 표현식이 사용됨) -->
                    <img src="/api/placeholder/200/300" alt="영화 포스터" class="movie-poster">
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td>인셉션 (실제로는 ${movie.title})</td>
            </tr>
            <tr>
                <th>원제</th>
                <td>Inception (실제로는 ${movie.originalTitle})</td>
            </tr>
            <tr>
                <th>감독</th>
                <td>크리스토퍼 놀란 (실제로는 ${movie.director})</td>
            </tr>
            <tr>
                <th>출연</th>
                <td>레오나르도 디카프리오, 조셉 고든 레빗, 엘렌 페이지 (실제로는 ${movie.actors})</td>
            </tr>
            <tr>
                <th>장르</th>
                <td>SF, 액션, 모험 (실제로는 ${movie.genre})</td>
            </tr>
            <tr>
                <th>상영 시간</th>
                <td>148분 (실제로는 ${movie.runtime}분)</td>
            </tr>
            <tr>
                <th>개봉일</th>
                <td>2010-07-21 (실제로는 ${movie.releaseDate})</td>
            </tr>
            <tr>
                <th>관람 등급</th>
                <td>12세 이상 관람가 (실제로는 ${movie.rating})</td>
            </tr>
            <tr>
                <th>평점</th>
                <td>4.5 / 5.0 (실제로는 ${movie.userRating} / 5.0)</td>
            </tr>
            <tr>
                <th>줄거리</th>
                <td>
                    타인의 꿈에 들어가 생각을 훔치는 특수 기술을 가진 도둑 코브. 이번에는 생각을 훔치는 것이 아니라 생각을 심는 '인셉션'이라는 작전을 실행해야 한다. 
                    그는 이 위험한 작전을 성공하면 모든 것을 되찾을 수 있다는 제안을 받고 꿈과 현실의 경계가 모호해지는 미션을 시작한다.
                    (실제로는 ${movie.synopsis})
                </td>
            </tr>
        </table>
        
        <!-- 상영 시간표 -->
        <h2>상영 시간표</h2>
        <table>
            <thead>
                <tr>
                    <th colspan="2">날짜</th>
                    <th colspan="6">상영 시간</th>
                </tr>
            </thead>
            <tbody>
                <!-- JSTL을 사용하여 상영 시간표를 반복해서 출력 -->
                <c:forEach var="schedule" items="${scheduleList}">
                    <tr>
                        <td colspan="2">${schedule.date}</td>
                        <td colspan="6">
                            <c:forEach var="time" items="${schedule.times}">
                                <button onclick="location.href='reserveSeat.do?scheduleId=${time.id}'">${time.time}</button>
                            </c:forEach>
                        </td>
                    </tr>
                </c:forEach>
                
                <!-- 샘플 데이터 (실제로는 데이터베이스에서 가져온 데이터가 위의 JSTL로 표시됨) -->
                <tr>
                    <td colspan="2">2025-05-10 (토)</td>
                    <td colspan="6">
                        <button onclick="location.href='reserveSeat.do?scheduleId=101'">10:00</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=102'">13:30</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=103'">16:20</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=104'">19:10</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=105'">22:00</button>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">2025-05-11 (일)</td>
                    <td colspan="6">
                        <button onclick="location.href='reserveSeat.do?scheduleId=106'">10:00</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=107'">13:30</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=108'">16:20</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=109'">19:10</button>
                        <button onclick="location.href='reserveSeat.do?scheduleId=110'">22:00</button>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div class="button-container">
            <button class="back-btn" onclick="location.href='movieList.do'">목록으로 돌아가기</button>
            <button class="reserve-btn" onclick="location.href='reserveMovie.do?movieId=${movie.id}'">예약하기</button>
        </div>
    </div>
    
    <!-- Footer 영역 -->
    <jsp:include page="footer.jsp" />
    
    <!-- 
    영화 상세 정보 페이지 주석:
    1. 이 페이지는 선택한 영화의 상세 정보를 테이블 형태로 보여줍니다.
    2. 영화의 포스터, 제목, 감독, 출연진, 장르, 상영 시간 등 더 자세한 정보를 표시합니다.
    3. 상영 시간표를 통해 사용자가 원하는 날짜와 시간을 선택할 수 있습니다.
    4. '예약하기' 버튼을 클릭하면 예약 페이지로 이동합니다.
    5. '목록으로 돌아가기' 버튼을 클릭하면 영화 목록 페이지로 돌아갑니다.
    6. EL(Expression Language)과 JSTL을 사용하여 서버에서 전달받은 영화 정보를 동적으로 표시합니다.
    7. 실제 구현 시에는 샘플 데이터 대신 서블릿에서 전달받은 영화 데이터를 사용합니다.
    -->
</body>
</html>