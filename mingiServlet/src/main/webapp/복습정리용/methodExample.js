/**
 * 
 */

// ✅ 버튼, div 등을 클릭했을 때 실행됨
// 기본적인 클릭 이벤트 처리에 사용
element.addEventListener("click", function(e) {
  console.log("클릭됨");
});

// ✅ 더블 클릭했을 때 실행됨 (빠르게 두 번 클릭)
// 단일 클릭과는 구분되어 별도의 액션 처리 가능
element.addEventListener("dblclick", function(e) {
  console.log("더블 클릭됨");
});

// ✅ 마우스 커서가 요소 위로 올라왔을 때 발생
// 툴팁 표시, 강조 효과 등 인터랙션에 사용
element.addEventListener("mouseover", function(e) {
  console.log("마우스 올라옴");
});

// ✅ 마우스 커서가 요소를 벗어났을 때 발생
// 마우스 hover 효과 제거 시 유용
element.addEventListener("mouseout", function(e) {
  console.log("마우스 나감");
});

// ✅ 키보드를 누르는 순간 발생
// 어떤 키를 눌렀는지(e.key) 추적 가능
element.addEventListener("keydown", function(e) {
  console.log("키 누름:", e.key);
});

// ✅ 누른 키에서 손을 뗄 때 발생
// keydown과 함께 자주 사용
element.addEventListener("keyup", function(e) {
  console.log("키 뗌:", e.key);
});

// ✅ input, textarea 등에 입력이 실시간으로 감지될 때
// 자동완성, 글자 수 제한 등 실시간 처리에 사용
element.addEventListener("input", function(e) {
  console.log("입력 중:", e.target.value);
});

// ✅ input, select 등의 값이 변경 완료되었을 때
// 사용자가 선택하거나 입력 후 포커스를 옮겼을 때 실행됨
element.addEventListener("change", function(e) {
  console.log("값 변경됨:", e.target.value)
});

// ✅ form 태그가 제출되었을 때 발생
// e.preventDefault()로 전송을 막고 비동기 처리 가능
formElement.addEventListener("submit", function(e) {
  e.preventDefault();
  console.log("폼 전송됨");
});

// ✅ 요소에 포커스(커서)가 들어왔을 때 발생
// input 포커싱 시 인터페이스 변화 줄 때 사용
element.addEventListener("focus", function(e) {
  console.log("포커스 들어옴");
});

// ✅ 요소에서 포커스가 벗어났을 때 발생
// 입력 완료 후 검증(validation) 처리 등에 사용
element.addEventListener("blur", function(e) {
  console.log("포커스 벗어남");
});

// ✅ 웹 페이지가 완전히 로딩되었을 때 발생
// DOM 요소나 이미지 등 모든 자원이 로드된 이후 실행
window.addEventListener("load", function() {
  console.log("문서 로딩 완료");
});

// ✅ 사용자가 페이지를 스크롤할 때마다 발생
// 무한 스크롤, 헤더 고정/숨김 처리 등에 유용
window.addEventListener("scroll", function() {
  console.log("스크롤 중");
});

// ✅ 마우스 버튼을 누르는 순간 발생 (클릭보다 먼저)
// 드래그 시작 지점 판단 등에 사용
element.addEventListener("mousedown", function(e) {
  console.log("마우스 버튼 누름");
});

// ✅ 마우스 버튼을 누른 후 뗐을 때 발생
element.addEventListener("mouseup", function(e) {
  console.log("마우스 버튼 뗌");
});

// ✅ 마우스가 요소 위에서 움직일 때마다 발생
// 마우스 좌표 추적(e.clientX/Y) 등에 활용
element.addEventListener("mousemove", function(e) {
  console.log("마우스 이동 중");
});

// ✅ 마우스 우클릭 시 발생 (기본 메뉴 열림)
// e.preventDefault()로 기본 우클릭 메뉴 막을 수 있음
element.addEventListener("contextmenu", function(e) {
  e.preventDefault();
  console.log("우클릭 발생");
});

// ✅ 드래그 가능한 요소를 끌기 시작할 때 발생
element.addEventListener("dragstart", function(e) {
  console.log("드래그 시작");
});

// ✅ 드롭 대상 위로 드래그 요소가 올라왔을 때 발생
// e.preventDefault() 없으면 drop 이벤트 발생 안함
element.addEventListener("dragover", function(e) {
  e.preventDefault();
  console.log("드래그 대상 위로 올라옴");
});

// ✅ 드래그 요소가 드롭되었을 때 발생
element.addEventListener("drop", function(e) {
  e.preventDefault();
  console.log("드롭됨");
});

// ✅ 드래그가 완료되었을 때 발생
element.addEventListener("dragend", function(e) {
  console.log("드래그 종료됨");
});

// ✅ 텍스트 복사 시 발생
element.addEventListener("copy", function(e) {
  console.log("텍스트 복사됨");
});

// ✅ 텍스트 잘라내기 시 발생 (Ctrl+X)
element.addEventListener("cut", function(e) {
  console.log("텍스트 잘림");
});

// ✅ 클립보드의 내용이 붙여넣기 되었을 때 발생
element.addEventListener("paste", function(e) {
  console.log("붙여넣기:", e.clipboardData.getData("text"));
});

// ✅ 손가락으로 화면 터치했을 때 발생 (모바일)
// 모바일용 드래그나 슬라이드 기능 구현 시 사용
element.addEventListener("touchstart", function(e) {
  console.log("손가락 터치 시작");
});

// ✅ 손가락을 터치한 채 이동할 때 발생 (모바일)
element.addEventListener("touchmove", function(e) {
  console.log("터치 이동 중");
});

// ✅ 손가락을 화면에서 뗐을 때 발생 (모바일)
element.addEventListener("touchend", function(e) {
  console.log("터치 종료됨");
});

// ✅ 브라우저 창 크기 변경 시 발생
// 반응형 웹 구현 시 재배치 등 처리에 사용
window.addEventListener("resize", function() {
  console.log("창 크기 변경됨");
});

// ✅ 페이지를 떠나기 직전 발생
// 사용자에게 '저장하지 않은 정보가 있습니다' 경고 가능
window.addEventListener("beforeunload", function(e) {
  e.preventDefault();
  console.log("페이지 떠나기 전");
  e.returnValue = ""; // 크롬에서 기본 동작 필요
});

// ✅ 현재 페이지 탭이 숨겨지거나 다시 보여졌을 때 발생
// 백그라운드 상태 감지 및 자원 최적화에 사용
document.addEventListener("visibilitychange", function() {
  if (document.visibilityState === "hidden") {
    console.log("탭이 숨겨졌습니다");
  } else {
    console.log("탭이 다시 활성화되었습니다");
  }
});
