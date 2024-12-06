<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }" />
    
<!DOCTYPE html>
<html>
<head>
	<title>동기적 게시판 리스트</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  
	<link rel="styleSheet" href="${contextPath }/resources/css/synchBoardCss.css"> <!-- 디렉토리x, URL경로  -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  
  
 	<script type="text/javascript">
		$(document).ready(function(){
			
			//로그인 오류시 실패 모달창show
		  if(${!empty msgBody}){
			  $("#myMessage").modal("show"); 
		  }
			
			$("#registerButton").click(function(){
				location.href="${contextPath}/synchBoard/register"; //GET
			});
			
			//관리자용 글 랜덤생성기 
			$("#randomRegisterBtn").click(randomRegister);
			
			
			/** 폼 하나로 n개의 메서드와 매개변수 생성 */
			// 1. 페이지이동 jQuery로 
			let pageFrm = $("#pageFrm");
			$(".page-item a").on("click", function(e){ //page-item클래스 하의 a태그들 
				e.preventDefault(); // e tag의 기능을 막음
				
				let currentPage = $(this).attr("href"); //페이지 번호 값 
				pageFrm.find("#currentPage").val(currentPage); //버튼의 href속성 값을 form의 currentPage값에 대입 
				pageFrm.submit(); // ${contextPath}/synchBoard/list
			});
			
			// 2. 상세보기 클릭시 이동하기(a링크 태그에는 boardIdx값만 전달) -> 페이지이동 jQuery와 합친 코드 
			$(".move").on("click", function(event){ //move클래스 클릭시 기능 활성화 
				event.preventDefault(); // a tag의 기능 막음
				let boardIdx = $(this).attr("href"); // 클릭된 요소의 href 값 가져오기: boardIdx 
				
				let tag = "<input type='hidden' name='boardIdx' value='"+ boardIdx +"'>"; // boardIdx값 넣은 input태그 생성 : 컨트롤러에서 @RequestParm으로 받아야함.
				pageFrm.append(tag); //form에 input태그를 추가하고, 
				pageFrm.attr("action", "${contextPath}/synchBoard/get/"+boardIdx); //메서드를 바꿈, 나는 @PathVariable로 받고싶어서 Idx를 추가함 -> 이러면 input으로 넘기는게 무의미해지긴 함 
				
				pageFrm.submit();
			});
			
			
			//책 검색 버튼 클릭시 처리 : 화살표함수로 해볼래 
			$("#bookSearch").on("click", () => {
				const bookName = $("#bookName").val();
				getBookList(bookName);
			});
			
			
			
			  
		});
		
		function randomRegister(){
			console.log("랜덤글 등록 실행");
			// memID, title, content, writer,
			const member = [['winter', '윈터'], ['karina', '카리나'], ['ningning', '닝닝'], ['jijel', '지젤']];
			const title1 = ['즐거운 ','행복한 ','우울한 ','바쁜 ', '절망적인 '];
			const title2 = ['아침', '오후', '하루', '야식시간'];
			const content = ['월요일입니다.','화요일입니다.','수요일입니다.','목요일입니다.','금요일입니다.','토요일입니다.','일요일입니다.'];
			register();
			
			function register(){
				console.log("register()실행");
				let selectedM = member[Math.floor(Math.random() * member.length)];
				let selectedT1 = title1[Math.floor(Math.random() * title1.length)]; 
				let selectedT2 = title2[Math.floor(Math.random() * title2.length)]; 
				let selectedC = content[Math.floor(Math.random() * content.length)];
				
				$.ajax({
					url: `${contextPath}/asynchBoard/board/new`,
					type: 'post',
					data: {
						'memID' : selectedM[0],
						'writer' : selectedM[1],
						'title' : selectedT1 + selectedT2,
						'content' : selectedC,
					},
					beforeSend: function(xhr){
		  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
	  			},
					success : function(data){
						window.location.href='${contextPath}/synchBoard/list';
					},
					error: function(jqXHR) {
			    	let errorMessage = "알 수 없는 오류가 발생했습니다.";
				    if (jqXHR.status === 403) {
			        errorMessage = "권한이 없습니다. 접근할 수 없습니다.";
				    } else if (jqXHR.status === 500) {
			        errorMessage = jqXHR.responseText || "서버 오류가 발생했습니다.";
				    }
				    console.log(errorMessage);
				    alert("오류: " + errorMessage + "\n" + jqXHR.status + "입니다");
					}
				});
			}
		}
		
 		function getBookList(bookName){
 			if(bookName == ""){
 				alert("책 제목을 입력하세요."); //아니면 전체 리스트 호출 
 				return false;
 			} else {
 				alert(bookName);
 				// 카카오 책 검색 오픈API 연동(키 발급)
 				
 			}
 			
 			
		} 

 	</script>  

</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp" />

  <div class="card">
    <div class="card-header" >동기식 게시판 List</div>
		<security:authorize access="hasRole('ADMIN')">
			<button type="button" id="randomRegisterBtn">관리자 랜덤글 등록</button>
		</security:authorize>
    <div class="card-body" >
    	<div class="row">
    		<div class="col-sm-2">
    			<jsp:include page="../common/left.jsp"></jsp:include>
    		</div>
    		<div class="col-sm-7">
					<table>
					  <thead>
					    <tr>
					      <th>인덱스</th>
					      <th>제목</th>
					      <th>글쓴이</th>
					      <th>작성일</th>
					      <th>조회수</th>
					    </tr>
					  </thead>
					  <tbody>
					    <c:if test="${!empty vo}">
					      <c:forEach var="bvo" items="${vo}">
					        <tr>
					          <td>${bvo.boardIdx}</td>
					          <c:if test="${bvo.boardAvailable eq false }">
					          	<td class="deleted-data">
						      			[삭제된 게시물입니다.]
						      		</td>
					          </c:if>
					          <c:if test="${bvo.boardAvailable ne false }">
					          	<td>
						            <a class="move" href="${bvo.boardIdx}">
						            	<c:out value="${bvo.title}"/> <!-- c:out -> xss방지  -->
						            </a> 
					          	</td>
					          </c:if>
					          <td>${bvo.writer}</td>
					          <td>
					            <fmt:formatDate value="${bvo.indate}" pattern="yyyy-MM-dd"/>
					          </td>
					          <td>${bvo.count}</td>
					        </tr>
					      </c:forEach>
					    </c:if>
					
					    <c:if test="${empty vo}">
					      <tr>
					        <td colspan="5" class="no-data">
					          조회가능한 게시물이 없습니다.
					        </td>
					      </tr>
					    </c:if>
					  </tbody>
					</table>
			    <button id="registerButton" class="btn btn-primary float-end">글쓰기 </button>
		    		
    		</div>
    		<div class="col-sm-3">
    			<jsp:include page="../common/right.jsp"></jsp:include>
    		</div>
    	</div>

    </div>
    
    <div class="card-footer">
    	<!-- 페이징 처리 뷰: ${pageMaker } -->
			<div>  
				<ul class="pagination justify-content-center" style="margin:20px 0">
			<!-- 이전처리 -->
				<c:if test="${pageMaker.prev }">
				  <li class="page-item previous">
				  	<a class="page-link" href="${pageMaker.startPage - 1}">previous</a>
			  	</li>
				</c:if>
			<!-- 페이지 번호 처리 -->
					<c:forEach var="pageNum" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
						<li class="page-item ${pageMaker.cri.currentPage != pageNum ? '' : 'active' }" >
						<a class="page-link" href="${pageNum}">
						${pageNum }
						</a></li>				
					</c:forEach>
			<!-- 다음처리 -->
		 		<c:if test="${pageMaker.next }">
				  <li class="page-item next">
				  	<a class="page-link" href="${pageMaker.endPage + 1}">next</a>
			  	</li>
				</c:if>
				</ul>		
			</div>
			<!-- END -->
			
			<!-- 검색메뉴 -->
			<div class="d-flex justify-content-center">
				<form action="${contextPath }/synchBoard/list" method="get" class="d-flex w-30">
					<select class="form-select" name="type" style="width: 30%;">
						<!-- 페이지 이동시에도 검색기록 유지 -->
						<option value="title" 	${pageMaker.cri.type == 'title' ? 'selected' : ''}>		제목</option>
						<option value="content" ${pageMaker.cri.type == 'content' ? 'selected' : ''}>	내용</option>
						<option value="writer" 	${pageMaker.cri.type == 'writer' ? 'selected' : ''}>	작성자</option>
						<option value="titcont" ${pageMaker.cri.type == 'titcont' ? 'selected' : ''}>	제목+내용</option>
					</select>
					<input type="text" class="form-control" name="keyword" style="width: 50%;" value="${pageMaker.cri.keyword }">
					<button type="submit" class="btn btn-outline-success ms-3" style="width: 20%;">Search</button>
				</form>
			</div>
			
    </div>
    
  </div>
	
	
	<!-- jQuery로 링크 및 매개변수 던지기 -->
	<form id="pageFrm" action="${contextPath }/synchBoard/list" method="get">
		<!-- 여기 하나 더, 게시물 번호(boardIdx) 추가: JS로 동적추가 해줌  -->
		<input type="hidden" id="currentPage" name="currentPage" value="${pageMaker.cri.currentPage}" >
		<input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}" >
		<!-- 페이지 이동시 검색결과 유지 -->
		<input type="hidden" id="type" name="type" value="${pageMaker.cri.type}" >
		<input type="hidden" id="keyword" name="keyword" value="${pageMaker.cri.keyword}" >
	</form>
	
	
	<!-- Modal 추가 -->
	<div class="modal fade" id="myMessage" role="dialog">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">${msgTitle }</h4>
	        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	       	<p>${msgBody }</p>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
  
</div>


</body>
</html>