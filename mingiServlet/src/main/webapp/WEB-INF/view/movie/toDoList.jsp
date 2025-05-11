<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>달력 기반 To-Do List</title>
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
        .calendar {
            width: 100%;
            margin-bottom: 20px;
        }
        .calendar th {
            background-color: #4CAF50;
            color: white;
        }
        .calendar td {
            height: 100px;
            vertical-align: top;
            padding: 5px;
        }
        .calendar .date {
            font-weight: bold;
            text-align: right;
            margin-bottom: 5px;
            font-size: 14px;
        }
        .calendar .today {
            background-color: #e8f5e9;
        }
        .calendar .other-month {
            background-color: #f9f9f9;
            color: #ccc;
        }
        .todo-item {
            margin: 2px 0;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 12px;
            text-align: left;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            cursor: pointer;
        }
        .todo-item.priority-high {
            background-color: #ffcdd2;
        }
        .todo-item.priority-medium {
            background-color: #fff9c4;
        }
        .todo-item.priority-low {
            background-color: #c8e6c9;
        }
        .todo-item.completed {
            text-decoration: line-through;
            opacity: 0.5;
        }
        .month-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .month-nav button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
        }
        .month-nav button:hover {
            background-color: #45a049;
        }
        .month-title {
            font-size: 24px;
        }
        .add-todo-btn {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            float: right;
            margin-bottom: 10px;
        }
        .add-todo-btn:hover {
            background-color: #0b7dda;
        }
        
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 60%;
            max-width: 500px;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .close:hover {
            color: black;
        }
        .modal-form label {
            display: block;
            margin-top: 10px;
        }
        .modal-form input[type="text"], 
        .modal-form select, 
        .modal-form textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }
        .modal-form button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .modal-form button:hover {
            background-color: #45a049;
        }
        .modal-buttons {
            margin-top: 20px;
            text-align: right;
        }
        .modal-buttons button {
            margin-left: 10px;
            padding: 8px 16px;
            cursor: pointer;
        }
        .edit-btn {
            background-color: #2196F3;
            color: white;
            border: none;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
            border: none;
        }
        .complete-btn {
            background-color: #4CAF50;
            color: white;
            border: none;
        }
    </style>
    <script>
        // DOM이 완전히 로드된 후 실행
        document.addEventListener('DOMContentLoaded', function() {
            // 모달 관련 변수들
            var addModal = document.getElementById('addTodoModal');
            var viewModal = document.getElementById('viewTodoModal');
            var addBtn = document.getElementById('addTodoBtn');
            var closeBtns = document.getElementsByClassName('close');
            
            // '할 일 추가' 버튼 클릭 시 모달 열기
            addBtn.onclick = function() {
                // 현재 날짜를 기본값으로 설정
                var today = new Date();
                var year = today.getFullYear();
                var month = (today.getMonth() + 1).toString().padStart(2, '0');
                var day = today.getDate().toString().padStart(2, '0');
                document.getElementById('todoDate').value = year + '-' + month + '-' + day;
                
                addModal.style.display = 'block';
            }
            
            // 모달 닫기 버튼들
            for (var i = 0; i < closeBtns.length; i++) {
                closeBtns[i].onclick = function() {
                    addModal.style.display = 'none';
                    viewModal.style.display = 'none';
                }
            }
            
            // 모달 외부 클릭 시 닫기
            window.onclick = function(event) {
                if (event.target == addModal) {
                    addModal.style.display = 'none';
                }
                if (event.target == viewModal) {
                    viewModal.style.display = 'none';
                }
            }
            
            // Todo 항목 클릭 시 상세 정보 보기
            var todoItems = document.getElementsByClassName('todo-item');
            for (var i = 0; i < todoItems.length; i++) {
                todoItems[i].onclick = function() {
                    // 실제 구현에서는 Ajax로 서버에서 데이터를 가져와 표시
                    var todoId = this.getAttribute('data-id');
                    viewTodoDetails(todoId);
                }
            }
            
            // 오늘 날짜 셀 하이라이트
            highlightToday();
        });
        
        // 오늘 날짜 셀 하이라이트 함수
        function highlightToday() {
            var today = new Date();
            var currentMonth = parseInt(document.getElementById('currentMonth').value);
            var currentYear = parseInt(document.getElementById('currentYear').value);
            
            // 현재 표시된 달력이 현재 월/년과 일치하는 경우에만 하이라이트
            if (today.getFullYear() === currentYear && today.getMonth() + 1 === currentMonth) {
                var todayDate = today.getDate();
                var dateCells = document.querySelectorAll('.calendar td:not(.other-month) .date');
                
                for (var i = 0; i < dateCells.length; i++) {
                    if (parseInt(dateCells[i].innerText) === todayDate) {
                        dateCells[i].parentElement.classList.add('today');
                        break;
                    }
                }
            }
        }
        
        // Todo 상세 정보 표시 함수 (실제로는 AJAX로 데이터를 가져와야 함)
        function viewTodoDetails(todoId) {
            var viewModal = document.getElementById('viewTodoModal');
            
            // 예시 데이터 (실제로는 서버에서 가져온 데이터로 대체해야 함)
            var todoData = {
                id: todoId,
                title: '프로젝트 회의 준비',
                date: '2025-05-15',
                priority: '높음',
                completed: false,
                description: '팀 프로젝트 회의 자료 준비하기. PPT 만들고 발표 연습하기.'
            };
            
            // ID에 따라 다른 데이터 (예시용)
            if (todoId === '101') {
                todoData.title = '보고서 제출';
                todoData.date = '2025-05-01';
                todoData.description = '분기별 실적 보고서를 작성하여 상사에게 이메일로 제출하기';
            } else if (todoId === '105') {
                todoData.title = '가족 모임';
                todoData.date = '2025-05-10';
                todoData.priority = '중간';
                todoData.description = '할머니 댁에서 가족 모임 참석하기. 선물 준비하기.';
            }
            
            // 모달에 데이터 설정
            document.getElementById('viewTodoTitle').innerText = todoData.title;
            document.getElementById('viewTodoDate').innerText = todoData.date;
            document.getElementById('viewTodoPriority').innerText = todoData.priority;
            document.getElementById('viewTodoStatus').innerText = todoData.completed ? '완료' : '미완료';
            document.getElementById('viewTodoDesc').innerText = todoData.description;
            
            // 수정 및 삭제 버튼에 todoId 설정
            document.getElementById('editTodoBtn').setAttribute('data-id', todoId);
            document.getElementById('deleteTodoBtn').setAttribute('data-id', todoId);
            document.getElementById('toggleCompleteBtn').setAttribute('data-id', todoId);
            
            // 완료/미완료 버튼 텍스트 설정
            document.getElementById('toggleCompleteBtn').innerText = todoData.completed ? '미완료로 표시' : '완료로 표시';
            
            // 모달 표시
            viewModal.style.display = 'block';
        }
        
        // 이전 달로 이동
        function previousMonth() {
            var currentMonth = parseInt(document.getElementById('currentMonth').value);
            var currentYear = parseInt(document.getElementById('currentYear').value);
            
            if (currentMonth === 1) {
                currentMonth = 12;
                currentYear--;
            } else {
                currentMonth--;
            }
            
            document.getElementById('currentMonth').value = currentMonth;
            document.getElementById('currentYear').value = currentYear;
            document.getElementById('calendarForm').submit();
        }
        
        // 다음 달로 이동
        function nextMonth() {
            var currentMonth = parseInt(document.getElementById('currentMonth').value);
            var currentYear = parseInt(document.getElementById('currentYear').value);
            
            if (currentMonth === 12) {
                currentMonth = 1;
                currentYear++;
            } else {
                currentMonth++;
            }
            
            document.getElementById('currentMonth').value = currentMonth;
            document.getElementById('currentYear').value = currentYear;
            document.getElementById('calendarForm').submit();
        }
        
        // Todo 항목 완료/미완료 토글
        function toggleTodoStatus(todoId) {
            // 실제로는 Ajax로 서버에 상태 변경 요청
            console.log('Todo ' + todoId + ' 상태 변경');
            
            // 간단한 시각적 효과만 적용 (실제로는 서버 응답 후 처리해야 함)
            var todoItem = document.querySelector('.todo-item[data-id="' + todoId + '"]');
            if (todoItem) {
                todoItem.classList.toggle('completed');
            }
            
            // 오늘의 할 일 테이블에서 체크박스를 업데이트
            var checkbox = document.querySelector('input[type="checkbox"][onchange="toggleTodoStatus(' + todoId + ')"]');
            if (checkbox) {
                checkbox.checked = !checkbox.checked;
            }
            
            // 모달이 열려있는 경우 모달 닫기
            var viewModal = document.getElementById('viewTodoModal');
            if (viewModal.style.display === 'block') {
                viewModal.style.display = 'none';
            }
        }
        
        // Todo 삭제 함수
        function deleteTodo(todoId) {
            if (confirm('정말 이 할 일을 삭제하시겠습니까?')) {
                // 실제로는 서버에 삭제 요청을 보냄
                console.log('Todo ' + todoId + ' 삭제');
                
                // 간단한 시각적 효과만 적용 (실제로는 서버 응답 후 처리해야 함)
                var todoItems = document.querySelectorAll('.todo-item[data-id="' + todoId + '"]');
                todoItems.forEach(function(item) {
                    item.parentElement.removeChild(item);
                });
                
                // 오늘의 할 일 테이블에서 해당 행 제거
                var todoRow = document.querySelector('tr[data-id="' + todoId + '"]');
                if (todoRow) {
                    todoRow.parentElement.removeChild(todoRow);
                }
                
                // 모달 닫기
                document.getElementById('viewTodoModal').style.display = 'none';
            }
        }
        
        // Todo 수정 모드로 전환
        function editTodo(todoId) {
            // 실제로는 서버에서 데이터를 가져와 폼에 채우고 수정 모달을 표시
            console.log('Todo ' + todoId + ' 수정');
            
            // 예시: 간단히 수정 페이지로 이동하는 것으로 처리
            location.href = 'editTodo.do?id=' + todoId;
        }
        
        // 할 일 추가 폼 제출
        function submitAddTodoForm() {
            // 실제로는 폼 데이터를 서버에 제출
            var form = document.getElementById('addTodoForm');
            
            // 간단한 유효성 검사
            var title = form.elements['todoTitle'].value;
            var date = form.elements['todoDate'].value;
            
            if (!title || !date) {
                alert('제목과 날짜는 필수 입력 항목입니다.');
                return false;
            }
            
            // 실제로는 서버에 제출하고 응답을 처리
            console.log('할 일 추가 폼 제출:', {
                title: form.elements['todoTitle'].value,
                date: form.elements['todoDate'].value,
                priority: form.elements['todoPriority'].value,
                description: form.elements['todoDesc'].value
            });
            
            // 폼 초기화 및 모달 닫기
            form.reset();
            document.getElementById('addTodoModal').style.display = 'none';
            
            // 페이지 새로고침 (실제로는 Ajax로 처리하고 동적으로 UI 업데이트)
            alert('할 일이 추가되었습니다.');
            location.reload();
            
            return false; // 폼의 기본 제출 동작 방지
        }
    </script>
</head>
<body>
    <!-- Header 영역 -->
    <jsp:include page="header.jsp" />
    
    <!-- 달력 기반 To-Do List 메인 컨텐츠 -->
    <div class="content">
        <h1>달력 기반 To-Do List</h1>
        
        <!-- 할 일 추가 버튼 -->
        <button id="addTodoBtn" class="add-todo-btn">+ 할 일 추가</button>
        
        <!-- 월 이동 폼 -->
        <form id="calendarForm" action="todoCalendar.do" method="get">
            <input type="hidden" id="currentMonth" name="month" value="${param.month == null ? currentMonth : param.month}">
            <input type="hidden" id="currentYear" name="year" value="${param.year == null ? currentYear : param.year}">
            
            <div class="month-nav">
                <button type="button" onclick="previousMonth()">&lt; 이전 달</button>
                <div class="month-title">
                    <!-- 실제로는 서버에서 계산된 값을 사용 -->
                    <c:set var="month" value="${param.month == null ? 5 : param.month}" />
                    <c:set var="year" value="${param.year == null ? 2025 : param.year}" />
                    ${year}년 ${month}월
                </div>
                <button type="button" onclick="nextMonth()">다음 달 &gt;</button>
            </div>
        </form>
        
        <!-- 달력 테이블 -->
        <table class="calendar">
            <thead>
                <tr>
                    <th>일</th>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                    <th>토</th>
                </tr>
            </thead>
            <tbody>
                <!-- 실제로는 서버에서 계산된 달력 데이터를 JSTL로 출력 -->
                <!-- 5월 달력 예시 (2025년 5월) -->
                <tr>
                    <td class="other-month">
                        <div class="date">27</div>
                    </td>
                    <td class="other-month">
                        <div class="date">28</div>
                    </td>
                    <td class="other-month">
                        <div class="date">29</div>
                    </td>
                    <td class="other-month">
                        <div class="date">30</div>
                    </td>
                    <td>
                        <div class="date">1</div>
                        <div class="todo-item priority-high" data-id="101" onclick="viewTodoDetails('101')">보고서 제출</div>
                    </td>
                    <td>
                        <div class="date">2</div>
                    </td>
                    <td>
                        <div class="date">3</div>
                        <div class="todo-item priority-medium" data-id="102" onclick="viewTodoDetails('102')">쇼핑</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="date">4</div>
                    </td>
                    <td>
                        <div class="date">5</div>
                        <div class="todo-item priority-high completed" data-id="103" onclick="viewTodoDetails('103')">병원 예약</div>
                    </td>
                    <td>
                        <div class="date">6</div>
                    </td>
                    <td>
                        <div class="date">7</div>
                    </td>
                    <td>
                        <div class="date">8</div>
                        <div class="todo-item priority-low" data-id="104" onclick="viewTodoDetails('104')">도서관 책 반납</div>
                    </td>
                    <td>
                        <div class="date">9</div>
                    </td>
                    <td class="today">
                        <div class="date">10</div>
                        <div class="todo-item priority-medium" data-id="105" onclick="viewTodoDetails('105')">가족 모임</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="date">11</div>
                    </td>
                    <td>
                        <div class="date">12</div>
                    </td>
                    <td>
                        <div class="date">13</div>
                        <div class="todo-item priority-high" data-id="106" onclick="viewTodoDetails('106')">프로젝트 회의</div>
                    </td>
                    <td>
                        <div class="date">14</div>
                    </td>
                    <td>
                        <div class="date">15</div>
                        <div class="todo-item priority-high" data-id="107" onclick="viewTodoDetails('107')">프로젝트 회의 준비</div>
                    </td>
                    <td>
                        <div class="date">16</div>
                    </td>
                    <td>
                        <div class="date">17</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="date">18</div>
                    </td>
                    <td>
                        <div class="date">19</div>
                    </td>
                    <td>
                        <div class="date">20</div>
                        <div class="todo-item priority-low" data-id="108" onclick="viewTodoDetails('108')">친구 생일</div>
                    </td>
                    <td>
                        <div class="date">21</div>
                    </td>
                    <td>
                        <div class="date">22</div>
                    </td>
                    <td>
                        <div class="date">23</div>
                        <div class="todo-item priority-medium" data-id="109" onclick="viewTodoDetails('109')">집안 청소</div>
                    </td>
                    <td>
                        <div class="date">24</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="date">25</div>
                    </td>
                    <td>
                        <div class="date">26</div>
                    </td>
                    <td>
                        <div class="date">27</div>
                    </td>
                    <td>
                        <div class="date">28</div>
                        <div class="todo-item priority-high" data-id="110" onclick="viewTodoDetails('110')">세미나 참석</div>
                    </td>
                    <td>
                        <div class="date">29</div>
                    </td>
                    <td>
                        <div class="date">30</div>
                    </td>
                    <td>
                        <div class="date">31</div>
                    </td>
                </tr>
                <tr>
                    <td class="other-month">
                        <div class="date">1</div>
                    </td>
                    <td class="other-month">
                        <div class="date">2</div>
                    </td>
                    <td class="other-month">
                        <div class="date">3</div>
                    </td>
                    <td class="other-month">
                        <div class="date">4</div>
                    </td>
                    <td class="other-month">
                        <div class="date">5</div>
                    </td>
                    <td class="other-month">
                        <div class="date">6</div>
                    </td>
                    <td class="other-month">
                        <div class="date">7</div>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <!-- 오늘의 할 일 목록 -->
        <h2>오늘의 할 일</h2>
        <table>
            <thead>
                <tr>
                    <th width="5%">완료</th>
                    <th width="45%">제목</th>
                    <th width="15%">기한</th>
                    <th width="10%">우선순위</th>
                    <th width="25%">작업</th>
                </tr>
            </thead>
            <tbody>
                <!-- 실제로는 서버에서 가져온 오늘의 할 일 목록을 JSTL로 출력 -->
                <!-- 샘플 데이터 -->
                <tr data-id="105">
                    <td>
                        <input type="checkbox" onchange="toggleTodoStatus('105')">
                    </td>
                    <td>가족 모임</td>
                    <td>2025-05-10</td>
                    <td>중간</td>
                    <td>
                        <button onclick="viewTodoDetails('105')">상세</button>
                        <button onclick="editTodo('105')">수정</button>
                        <button onclick="deleteTodo('105')">삭제</button>
                    </td>
                </tr>
                <!-- 추가 오늘의 할 일 -->
                <tr data-id="111">
                    <td>
                        <input type="checkbox" onchange="toggleTodoStatus('111')">
                    </td>
                    <td>장보기</td>
                    <td>2025-05-10</td>
                    <td>낮음</td>
                    <td>
                        <button onclick="viewTodoDetails('111')">상세</button>
                        <button onclick="editTodo('111')">수정</button>
                        <button onclick="deleteTodo('111')">삭제</button>
                    </td>
                </tr>
                <tr data-id="112">
                    <td>
                        <input type="checkbox" checked onchange="toggleTodoStatus('112')">
                    </td>
                    <td>이메일 확인</td>
                    <td>2025-05-10</td>
                    <td>높음</td>
                    <td>
                        <button onclick="viewTodoDetails('112')">상세</button>
                        <button onclick="editTodo('112')">수정</button>
                        <button onclick="deleteTodo('112')">삭제</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <!-- 할 일 추가 모달 -->
    <div id="addTodoModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>할 일 추가</h2>
            <form id="addTodoForm" class="modal-form" onsubmit="return submitAddTodoForm()">
                <label for="todoTitle">제목:</label>
                <input type="text" id="todoTitle" name="todoTitle" required>
                
                <label for="todoDate">날짜:</label>
                <input type="date" id="todoDate" name="todoDate" required>
                
                <label for="todoPriority">우선순위:</label>
                <select id="todoPriority" name="todoPriority">
                    <option value="high">높음</option>
                    <option value="medium" selected>중간</option>
                    <option value="low">낮음</option>
                </select>
                
                <label for="todoDesc">설명:</label>
                <textarea id="todoDesc" name="todoDesc" rows="4"></textarea>
                
                <button type="submit">추가</button>
            </form>
        </div>
    </div>
    
    <!-- 할 일 상세 정보 모달 -->
    <div id="viewTodoModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="viewTodoTitle">할 일 제목</h2>
            <div>
                <p><strong>날짜:</strong> <span id="viewTodoDate">2025-05-15</span></p>
                <p><strong>우선순위:</strong> <span id="viewTodoPriority">높음</span></p>
                <p><strong>상태:</strong> <span id="viewTodoStatus">미완료</span></p>
                <p><strong>설명:</strong></p>
                <div id="viewTodoDesc" style="padding: 10px; background-color: #f9f9f9; border-radius: 5px; margin-bottom: 15px;">
                    설명 내용이 여기에 표시됩니다.
                </div>
                
                <div class="modal-buttons">
                    <button id="toggleCompleteBtn" class="complete-btn" data-id="" onclick="toggleTodoStatus(this.getAttribute('data-id'))">완료로 표시</button>
                    <button id="editTodoBtn" class="edit-btn" data-id="" onclick="editTodo(this.getAttribute('data-id'))">수정</button>
                    <button id="deleteTodoBtn" class="delete-btn" data-id="" onclick="deleteTodo(this.getAttribute('data-id'))">삭제</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer 영역 -->
    <jsp:include page="footer.jsp" />
</body>
</html>