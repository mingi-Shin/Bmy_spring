<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 목록</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .movie-poster {
            width: 100px;
            height: auto;
        }
        .reserve-btn {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .reserve-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <!-- Header 영역 -->
    <jsp:include page="header.jsp" />
    
    <!-- 영화 목록 메인 컨텐츠 -->
    <div class="content">
        <h1>현재 상영 영화</h1>
        
        <!-- 검색 기능 -->
        <form action="searchMovie.do" method="get">
            <table>
                <tr>
                    <td width="80%">
                        <input type="text" name="searchKeyword" placeholder="영화 제목 검색" style="width: 80%;">
                    </td>
                    <td width="20%">
                        <input type="submit" value="검색">
                    </td>
                </tr>
            </table>
        </form>
        
        <!-- 영화 목록 테이블 -->
        <table>
            <thead>
                <tr>
                    <th>포스터</th>
                    <th>영화 제목</th>
                    <th>감독</th>
                    <th>장르</th>
                    <th>상영 시간</th>
                    <th>개봉일</th>
                    <th>평점</th>
                    <th>예약</th>
                </tr>
            </thead>
            <tbody>
                <!-- JSTL을 사용하여 영화 목록을 반복해서 출력 -->
                <c:forEach var="movie" items="${movieList}">
                    <tr>
                        <td><img src="${movie.posterUrl}" alt="${movie.title} 포스터" class="movie-poster"></td>
                        <td><a href="movieDetail.do?movieId=${movie.id}">${movie.title}</a></td>
                        <td>${movie.director}</td>
                        <td>${movie.genre}</td>
                        <td>${movie.runtime}분</td>
                        <td>${movie.releaseDate}</td>
                        <td>${movie.rating} / 5.0</td>
                        <td><button class="reserve-btn" onclick="location.href='reserveMovie.do?movieId=${movie.id}'">예약하기</button></td>
                    </tr>
                </c:forEach>
                
                <!-- 샘플 데이터 (실제로는 데이터베이스에서 가져온 데이터가 위의 JSTL로 표시됨) -->
                <tr>
                    <td><img src="/api/placeholder/100/150" alt="영화1 포스터" class="movie-poster"></td>
                    <td><a href="movieDetail.do?movieId=1">인셉션</a></td>
                    <td>크리스토퍼 놀란</td>
                    <td>SF, 액션</td>
                    <td>148분</td>
                    <td>2010-07-21</td>
                    <td>4.5 / 5.0</td>
                    <td><button class="reserve-btn" onclick="location.href='reserveMovie.do?movieId=1'">예약하기</button></td>
                </tr>
                <tr>
                    <td><img src="/api/placeholder/100/150" alt="영화2 포스터" class="movie-poster"></td>
                    <td><a href="movieDetail.do?movieId=2">어벤져스: 엔드게임</a></td>
                    <td>앤서니 루소, 조 루소</td>
                    <td>액션, 모험</td>
                    <td>181분</td>
                    <td>2019-04-24</td>
                    <td>4.8 / 5.0</td>
                    <td><button class="reserve-btn" onclick="location.href='reserveMovie.do?movieId=2'">예약하기</button></td>
                </tr>
                <tr>
                    <td><img src="/api/placeholder/100/150" alt="영화3 포스터" class="movie-poster"></td>
                    <td><a href="movieDetail.do?movieId=3">기생충</a></td>
                    <td>봉준호</td>
                    <td>드라마, 스릴러</td>
                    <td>132분</td>
                    <td>2019-05-30</td>
                    <td>4.6 / 5.0</td>
                    <td><button class="reserve-btn" onclick="location.href='reserveMovie.do?movieId=3'">예약하기</button></td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <!-- Footer 영역 -->
    <jsp:include page="footer.jsp" />
    
    <!-- 
    영화 목록 페이지 주석:
    1. 이 페이지는 현재 상영 중인 영화 목록을 테이블 형태로 보여줍니다.
    2. 각 영화에 대한 기본 정보(포스터, 제목, 감독, 장르, 상영시간 등)를 표시합니다.
    3. 영화 제목을 클릭하면 해당 영화의 상세 정보 페이지로 이동합니다.
    4. '예약하기' 버튼을 클릭하면 해당 영화 예약 페이지로 이동합니다.
    5. 검색 기능을 통해 특정 영화를 검색할 수 있습니다.
    6. JSTL을 사용하여 서버에서 전달받은 영화 목록을 동적으로 표시합니다.
    7. 실제 구현 시에는 샘플 데이터 대신 서블릿에서 전달받은 영화 데이터를 사용합니다.
    -->
</body>
</html>