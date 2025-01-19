<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }" />

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
			
			console.log('${user }');
			console.log('${user.member.name }');
			console.log('${auth }');
			console.log('${auth[0] }');
			
			let regForm = $("#regForm"); //JQuery 객체이므로, regForm은 Object임 
			$("button").on("click", function(e){
				let whatYouGonnaDo = $(this).data("what");
				if (whatYouGonnaDo == 'register'){
					//등록 전 유효성 검사.. 
					if(regForm[0].checkValidity()){ //JQuery객체에 [0]을 붙여서, JQuery객체를 DOM객체로 만들고 checkValidity() 내장함수 호출 
						regForm.submit();
					} else {
						regForm[0].reportValidity(); //사용자에게 피드백을 제공
					}
				} else if (whatYouGonnaDo == 'reset'){
					regForm[0].reset();
				} else if (whatYouGonnaDo == 'list'){
					location.href="${cpath}/board/list";
				} else if (whatYouGonnaDo == 'remove'){
					//let idx = '${vo.boardIdx }'; //json으로 가져온 거라 안됨.
					let boardIdx = regForm.find('#boardIdx').val();
					if(confirm(boardIdx + "번 게시물을 삭제하시겠습니까? ")){
						location.href="${cpath}/board/remove?boardIdx="+boardIdx;	
					}
				} else if (whatYouGonnaDo == 'updateForm'){
					regForm.find("#title").prop("readonly", false); //수정가능하게 
					regForm.find("#content").prop("readonly", false); //수정가능하게 
					// .html()에 의해 완전히 교체된 요소와 .append()에 의해 새로 생긴 요소는 기존의 이벤트리스너가 작동하지 못한다.
					// .html()은 상황에 따라 XSS위험이 존재, append()로 해보자.
					let button = $('<button>', {
						type: 'button',
						id: 'changeButton',
						class: 'btn btn-sm btn-primary m-1',
						text: '수정완료'
					});
					$('#updateSpan').empty().append(button);
					
					//이벤트위임, 자식요소에 onclick함수를 넣는 것보다 낫다=https://www.notion.so/html-append-DOM-147e2244683d80a1838be94583b10301?pvs=4
					$('#updateSpan').on('click','#changeButton',function(){
						alert('수정합니다.');
						regForm.attr('action','${cpath}/board/modify');
						regForm.submit();
					});
					
					
				} 
			});
			
			

			
			// a tag 클릭시 상세보기
			$("a").on("click", function(e){
				e.preventDefault(); // 1.a태그 기능 막고
				let boardIdx = $(this).attr("href"); // 2.href값 가져오고
				
				$.ajax({
					url : "${cpath}/board/get",
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
			console.log(vo); 
			//값 대입
			let regForm = $("#regForm");
			regForm.find("#title").val(vo.title); //아, find는 몰랐네!
			regForm.find("#content").val(vo.content);
			regForm.find("#writer").val(vo.writer);
			regForm.find("#boardIdx").val(vo.boardIdx);
			//값 읽기전용으로 
			regForm.find("input").prop("readonly", true);
			regForm.find("textarea").prop("readonly", true);
			//버튼UI 수정
			$("#regDiv button").hide();
			
			if('${user.member.name}' != vo.writer ){
				regForm.find("[data-what='remove']").prop("disabled", true);
				$("button[data-what='updateForm']").attr("disabled", true);
			}
			if('${user.member.name}' == vo.writer ){
				regForm.find("[data-what='remove']").prop("disabled", false);
				$("button[data-what='updateForm']").attr("disabled", false);
			}
			
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
    	
    	<div class="row"> <!-- 총 12 길이 -->
    		<div class="col-lg-2" >
    			<div class="card">
    				<div class="card-body">
    					<h4 class="card-title"><sec:authentication property="principal.Member.name"></sec:authentication></h4>
    					<p class="card-text">회원님 방문을 환영합니다.</p>
    					<br>
    					<form action="${cpath}/member/logoutProc" method="post">
    						<button type="submit" class="btn btn-sm btn-primary form-control mt-3">로그아웃</button>
    					</form>
    					<sec:authorize access="hasRole('ROLE_ADMIN')">
    					<div>등급: <sec:authentication property="principal.Member.role"/> MENU</div>
    					<p>관리자</p>
    					</sec:authorize>
    					<sec:authorize access="hasRole('ROLE_MANAGER')">
    					<div>등급: <sec:authentication property="principal.Member.role"/> MENU</div>
    					<p>매니저</p>
    					</sec:authorize>
    					<sec:authorize access="hasRole('ROLE_MEMBER_READ_ONLY')">
    					<div>등급: <sec:authentication property="principal.Member.role"/> MENU</div>
    					<p>읽기전용 멤버</p>
    					</sec:authorize>
    					<sec:authorize access="hasRole('ROLE_MEMBER_READ_WRITE')">
    					<div>등급: <sec:authentication property="principal.Member.role"/> MENU</div>
    					<p>읽기.쓰기 멤버</p>
    					</sec:authorize>
    					<!--
    						authorize는 권한을 검사해서 UI를 설정,  
    						authentication은 principal의 필드값을 출력하기
    					-->
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
    					<form id="regForm" action="${cpath }/board/register" method="post">
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
    							<input type="text" class="form-control" id="writer" name="writer" placeholder="Enter wirter" 
    								value='<sec:authentication property="principal.Member.name"/>' readonly>
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


JWT사용시 주의사항! : 
	Stateless 환경에서는 요청이 끝날 때 SecurityContextHolder가 초기화되므로, JSP에서 SPRING_SECURITY_CONTEXT.authentication.principal을 직접 참조할 수 없습니다. 
	대신, 컨트롤러 내에서 필터 체인을 거치는 동안 설정된 SecurityContextHolder의 인증 정보를 가져와서 JSP로 전달하는 방식으로 처리합니다.

 -->

