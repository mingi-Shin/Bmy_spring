<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			let regForm = $("#regForm"); //JQuery 객체이므로, regForm은 Object임 
			$("button").on("click", function(e){
				let whatYouGonnaDo = $(this).data("what");
				if (whatYouGonnaDo == 'register'){
					//등록 전 유효성 검사.
					if(regForm[0].checkValidity()){ //JQuery객체에 [0]을 붙여서, JQuery객체를 DOM객체로 만들고 checkValidity() 내장함수 호출 
						regForm.submit();
					} else {
						regForm[0].reportValidity(); //사용자에게 피드백을 제공
					}
				} else if (whatYouGonnaDo == 'reset'){
					regForm[0].reset();
				} else if (whatYouGonnaDo == 'list'){
					location.href="${cpath}/list";
				} else if (whatYouGonnaDo == 'remove'){
					//let idx = '${vo.boardIdx }'; //json으로 가져온 거라 안됨.
					let boardIdx = regForm.find('#boardIdx').val();
					if(confirm(boardIdx + "번 게시물을 삭제하시겠습니까? ")){
						location.href="${cpath}/remove?boardIdx="+boardIdx;	
					}
				} else if (whatYouGonnaDo == 'updateForm'){
					regForm.find("#title").prop("readonly", false); //수정가능하게 
					regForm.find("#content").prop("readonly", false); //수정가능하게 
					let changeButton = "<button type='button' class='btn btn-sm btn-primary m-1'> 수정완료 </button> ";
					$("#updateSpan").html(changeButton); //html()은 DOM 요소를 갈아치운다 .. html이 최선일까? 보안은 어떡하고??
				} 
			});
			
			
			// a tag 클릭시 상세보기
			$("a").on("click", function(e){
				e.preventDefault(); // 1.a태그 기능 막고
				let boardIdx = $(this).attr("href"); // 2.href값 가져오고
				
				$.ajax({
					url : "${cpath}/get",
					type : "get",
					data : {"boardIdx" : boardIdx}, // 클라 -> 서버
					dataType : "json", // 서버 -> 클라
					success : printBoard,
					error : function(){
						alert("error");
					}
				});
			});
		});	
		
		// a tag클릭시 가져온 데이터 뿌려줘 
		function printBoard(vo){
			//값 대입
			let regForm = $("#regForm");
			regForm.find("#title").val(vo.title); //아, find는 몰랐네!
			regForm.find("#content").val(vo.content);
			regForm.find("#writer").val(vo.writer);
			regForm.find("#boardIdx").val(vo.boardIdx);
			//값 읽기전용으로 
			regForm.find("input").prop("readonly", true);
			regForm.find("textarea").prop("readonly", true);
			console.log($("#updateDiv")); 
			//버튼UI 수정: jQuery 함수 사용
			$("#regDiv button").hide(); 
			$("#updateDiv button").show(); 
			
		}
	
	</script>
	
	<style type="text/css">
	/* .row의 자식으로 있는 모든 col-? 클래스에 스타일 적용 */
	.row > [class*="col-"] {
		background-color: #FFFAF0;
	}
	.row > [class*="col-"] > .card {
		background-color: red;
		min-height: 500px; 
		max-height: 1000px;
	}
	.row > [class*="col-"] > .card > .card-body {
		background-color: #FFF8DC;
	}
	
	</style>
</head>
<body>

<div class="container mt-3">
  <h2>Card Header and Footer</h2>
  <div class="card">
    <div class="card-header">
	  	<div class="card text-center bg-light my-5">
		    <h1 class="card-title display-4">Spring WEB MVC(스프2탄)</h1>
		    <p class="card-text lead">This is a modern alternative to the jumbotron using the card component</p>
	    </div>
  	</div>
  	
    <div class="card-body">
    	<h4 class="card-title">Spring boot: row와 3개의 행(2:5:5) </h4>
    	
    	<div class="row">
    		<div class="col-lg-2" >
    			<div class="card">
    				<div class="card-body">
    					<h4 class="card-title">Guest</h4>
    					<p class="card-text">회원님 방문을 환영합니다.</p>
    					<form action="">
    						<div class="form-group">
    							<label for="memId">아이디</label>
    							<input type="text" class="form-control" id="memId" name="memId">
    						</div>
    						<div class="form-group">
    							<label for="memPwd">비밀번호</label>
    							<input type="password" class="form-control" id="memPwd" name="memPwd"> 
    						</div>
    						<button type="button" class="btn btn-sm btn-primary form-control mt-3">로그인</button>
    					</form>
    				</div>
    			</div>
    		</div>
    		<div class="col-lg-5">
    			<div class="card">
    				<div class="card-body">
    					<table class="table table-hover">
    						<thead>
    							<th>번호</th>
    							<th>제목</th>
    							<th>작성자</th>
    							<th>작성일</th>
    						</thead>
    						<tbody>
    							<c:forEach var="vo" items="${list}">
    								<tr>
    									<td>${vo.boardIdx }</td>
    									<td><a href="${vo.boardIdx}">${vo.title }</a></td>
    									<td>${vo.writer }</td>
    									<td><fmt:formatDate value="${vo.indate }" pattern="yyyy-MM-dd" /></td>
    								</tr>
    							</c:forEach>
    						</tbody>
    					</table>
    				</div>
    			</div>
    		</div>
    		<div class="col-lg-5">
    			<div class="card">
    				<div class="card-body">
    					<form id="regForm" action="${cpath }/register" method="post">
    						<input type="hidden" id="boardIdx" name="boardIdx" > <!-- boardIdx 가져오려고 만든 hidden -->
    						<div class="form-group">
    							<label for="title">제목: </label>
    							<input type="text" class="form-control" id="title" name="title" placeholder="Enter title" required>
    						</div>
    						<div class="form-group">
    							<label for="title">내용: </label>
    							<textarea rows="9" class="form-control" id="content" name="content" required></textarea>
    						</div>
    						<div class="form-group">
    							<label for="writer">작성자: </label>
    							<input type="text" class="form-control" id="writer" name="writer" placeholder="Enter wirter" required>
    						</div>
    						<div id="regDiv" class="d-flex justify-content-end">
	    						<button type="button" data-what="register" class="btn btn-sm btn-primary m-1" >등록</button>
	    						<button type="button" data-what="reset" class="btn btn-sm btn-secondary m-1" >취소</button>
    						</div>
    						<div id="updateDiv" class="d-flex justify-content-end">
    							<button type="button" data-what="list" 				class="btn btn-sm btn-info m-1" 		style="display:none ">목록</button>
    							<span id="updateSpan"><button type="button" data-what="updateForm" 	class="btn btn-sm btn-warning m-1" 	style="display:none ">수정</button></span>
    							<button type="button" data-what="remove" 			class="btn btn-sm btn-danger m-1" 	style="display:none ">삭제</button>
    						</div>
    					</form>
    				</div>
    			</div>
    		</div>
    	</div>
    	
    	<hr>
    	
    	<h4>반응형 그리드 시스템 공부</h4>
    	<div class="row">
    		<div class="col-12 col-md-6 col-lg-4">
			    <div class="content">Column 1</div>
			  </div>
			  <div class="col-12 col-md-6 col-lg-4">
			    <div class="content">Column 2</div>
			  </div>
			  <div class="col-12 col-md-6 col-lg-4">
			    <div class="content">Column 3</div>
			  </div>
    	</div>
    	<!--  
    	row는 그 안에 포함된 열(col) 을 그룹화하고, 이를 통해 콘텐츠를 수평으로 배치할 수 있습니다.
			예를 들어, col 클래스를 가진 여러 개의 div 요소를 row로 감싸면, 그리드 시스템이 시작되며 반응형 레이아웃이 적용됩니다.
    		•	col-12: 화면 크기가 xs부터 sm까지일 경우, 각 열이 100% 너비를 차지합니다.(제일 작은 창)
				•	col-md-6: 화면 크기가 md 이상일 경우, 각 열이 50% 너비를 차지합니다.
				•	col-lg-4: 화면 크기가 lg 이상일 경우, 각 열이 33.33% 너비를 차지합니다.
    	-->
    	
    </div> 
    	
    <div class="card-footer">Footer</div>
  </div>
</div>

</body>
</html>

<!-- 
* button이 submit이면 required가 자동 작동하는데, button이므로 내가 script에서 수동으로 해줘야함. 
regForm은 jQuery 객체이기 때문에, checkValidity()와 reportValidity()를 직접 호출할 수 없습니다. 
이 메서드는 DOM 객체에서만 동작합니다.
jQuery 객체를 DOM 객체로 변환하려면 .get(0) 또는 [0]을 사용해야 합니다.


•	html(): 기존 내용을 완전히 덮어씌움.
•	append()/prepend(): 기존 내용은 유지하면서 새로운 콘텐츠를 추가.
•	text(): HTML이 아닌 단순 텍스트를 설정.


 -->

