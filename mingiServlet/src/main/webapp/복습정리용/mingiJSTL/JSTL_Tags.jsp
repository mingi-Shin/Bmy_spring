<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    
<c:out value="${user.name}" />
	•	설명: EL 표현식을 안전하게 출력 (XSS 방지용).
	•	사용처: 사용자 입력, DB 값 등 HTML에 출력 시.
	
<c:if test="${user.loggedIn}">
  <p>로그인된 사용자입니다</p>
</c:if>
	•	설명: 조건이 true일 때만 내용 출력.
	•	사용처: 로그인 상태에 따른 메뉴 분기 등
	
<c:choose>
  <c:when test="${user.grade eq 'admin'}">네
    관리자입니다.
  </c:when>
  <c:otherwise>
    일반 사용자입니다.
  </c:otherwise>
</c:choose>
	•	설명: 다중 조건 분기 (if-else if-else).
	•	사용처: 사용자 역할/등급에 따라 화면 출력 변경.

<c:forEach var="item" items="${itemList}">
  <li>${item.name}</li>
</c:forEach>
	•	설명: 컬렉션/배열 반복 처리.
	•	사용처: 목록 출력, 테이블 행 생성 등.
	
<c:forTokens var="color" items="red,blue,green" delims=",">
  <p>${color}</p>
</c:forTokens>
	•	설명: 문자열을 구분자(delims)로 잘라 반복.
	•	사용처: 문자열 목록을 화면에 나열할 때.
	
<c:set var="username" value="홍길동" />
	•	설명: 변수 선언 및 값 저장 (페이지, request 등 범위 설정 가능).
	•	사용처: 반복문 밖에서 변수 준비할 때, 가공값 저장 등.

<c:remove var="username" />
	•	설명: 지정한 변수를 제거함.
	•	사용처: 필요 없어진 데이터를 명시적으로 삭제할 때.
	
<c:catch var="err">
  <% int x = 10 / 0; %> <!-- 예외 발생 -->
</c:catch>

<c:if test="${not empty err}">
  에러 발생: ${err}
</c:if>
	•	설명: JSP에서 발생한 예외를 잡아 변수에 저장.
	•	사용처: JSP 코드에서 안전하게 예외 처리할 때.
	
<c:import url="header.jsp" />
	•	설명: 다른 JSP, HTML, 외부 URL 등 포함.
	•	사용처: 공통 레이아웃 불러오기, 외부 데이터 삽입 등.

<a href="<c:url value='/login' />">로그인</a>
	•	설명: 컨텍스트 경로를 자동으로 붙인 URL 생성.
	•	사용처: 링크, form action 경로 등 contextPath가 필요한 경우.
	
<c:url var="loginUrl" value="/login">
  <c:param name="redirect" value="/main" />
</c:url>
<a href="${loginUrl}">로그인 후 이동</a>
	•	설명: URL에 파라미터 추가.
	•	사용처: 쿼리스트링 동적 생성.
	
✅ 1. 세션에 로그인 여부 체크
<c:if test="${not empty sessionScope.loginUser}">
  <p>${sessionScope.loginUser.name}님, 환영합니다!</p>
  <a href="/logout">로그아웃</a>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
  <a href="/login">로그인</a>
</c:if>
	•	사용처: 로그인 상태에 따라 UI 다르게 표시
	•	핵심 개념: sessionScope를 통해 로그인 여부 판단
	
✅ 2. 관리자와 일반 사용자 화면 분기
<c:choose>
  <c:when test="${sessionScope.loginUser.role eq 'ADMIN'}">
    <a href="/admin">관리자 페이지</a>
  </c:when>
  <c:otherwise>
    <a href="/mypage">마이페이지</a>
  </c:otherwise>
</c:choose>
	•	사용처: 권한(Role)에 따라 다른 메뉴/기능 노출
	•	핵심 개념: role 값 비교
	
✅ 3. Null 체크 및 기본값 처리
<c:out value="${user.phone}" default="전화번호 없음" />
	•	사용처: DB에 null일 수 있는 값에 기본 텍스트 출력
	•	핵심 개념: default 속성 활용
	
✅ 4. 조건부 class 적용 (동적 스타일링)
<li class="<c:if test='${item.selected}'>active</c:if>">${item.name}</li>
	•	사용처: 선택된 항목 강조 표시
	•	핵심 개념: 조건에 따라 class 삽입
	
✅ 5. 페이징 처리
<c:forEach var="i" begin="1" end="${page.totalPages}">
  <a href="?page=${i}" class="<c:if test='${i eq page.current}'>active</c:if>">${i}</a>
</c:forEach>
	•	사용처: 게시판, 목록 페이지네이션
	•	핵심 개념: begin/end 반복 + 현재 페이지 강조
	
✅ 6. 입력값 유지 (폼 재입력)
<input type="text" name="username" value="<c:out value='${param.username}' />" />
	•	사용처: 폼 유효성 검사 실패 시 값 유지
	•	핵심 개념: ${param.변수}로 이전 입력값 사용

✅ 7. 값이 없는 경우 안내 메시지 출력
<c:choose>
  <c:when test="${empty boardList}">
    <p>게시글이 없습니다.</p>
  </c:when>
  <c:otherwise>
    <c:forEach var="board" items="${boardList}">
      <p>${board.title}</p>
    </c:forEach>
  </c:otherwise>
</c:choose>
	•	사용처: 리스트가 비어있을 때 안내 메시지 처리
	•	핵심 개념: empty 체크
	
	