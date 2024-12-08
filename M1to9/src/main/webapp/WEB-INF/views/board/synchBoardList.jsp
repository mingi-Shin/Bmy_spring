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
  
  
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.3/jquery-ui.js"></script> <!-- jQuery-ui의 autocomplete() 호출하기 위함  -->
	<link rel="styleSheet" href="${contextPath }/resources/css/synchBoardCss.css"> <!-- 디렉토리x, URL경로  -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoJsApiKey }"></script> <!-- kakaoMap API -->
	
  
  
 	<script type="text/javascript">
		$(document).ready(function(){
			
			const kakaoRestApiKey = "${kakaoRestApiKey}";
			const kakaoJsApiKey = "${kakaoJsApiKey}";
			
			//로그인 오류시 실패 모달창 오픈 
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
			
			
			//책 검색: 버튼(#bookSearch) 클릭시 처리 : 화살표함수로 해볼래 
			$("#bookSearch").on("click", () => {
				const bookName = $("#bookName").val();
				getBookList(bookName);
			});
			
			//책 검색_Ver1: 실시간 조회 처리_keyup()(검색 결과를 즉시 업데이트하거나 로딩 표시가 필요한 경우 적합.)
			/**
			$("#bookName").on("keyup", (event)=> {
				let searchKey = $(event.target).val().trim(); // 화살표함수는 자신만의 this를 가지지 않아. function을 쓰던지, event-event.target을 쓰던지 둘중 하나!!
				getBookList(searchKey);
			});
			*/
			
			//책 검색_Ver2: keyup + autocomplete (사용자가 자동완성 기능을 선호할 때 적합.)
			let searchList = []; //자동완성 목록 저장 배열
			$("#bookName").on("keyup", function(){
				const query = $(this).val();
				if(query.length >= 2){ //최소 2글자 이상에서 
					$.ajax({
						url : "https://dapi.kakao.com/v3/search/book?target=title&size=12",
						headers : {"Authorization": "KakaoAK " + kakaoRestApiKey},
						type : "get",
						data : {"query" : query },
						success : function(data){
							// 서버 응답 데이터를 searchList에 업데이트
							searchList = data.documents.map(item => item.title);
						  // .autocomplete()의 source 동적으로 업데이트
              $("#bookName").autocomplete("option", "source", searchList);
						},
						error : function(){
							alert("Error fetching data");
						}
					});
					
				} else {
					searchList = []; //입력값이 짧아지면 초기화??
				}
			});
			// .autocomplete()로 자동완성 활성화
			$("#bookName").autocomplete({
				source : function(request, response){
					response(searchList); //earchList를 자동완성 목록으로 사용
				},
				minlength: 2, //최소 입력 문자 수 
				select : function(event, ui){
					console.log("선택된 항목: ", ui.item.value);
				}
			});
			
			
			//kakao map 호출
			$("#mapBtn").on("click", ()=>{
				let address = $("#address").val(); //검색키워드 
				if(address == ''){
					alert("주소를 입력해주세요.");
					return false;
				} else { 
					// kkaoMap API 연결 
					$.ajax({
						url : "https://dapi.kakao.com/v2/local/search/keyword.json",
						headers : {"Authorization" : "KakaoAK " + kakaoRestApiKey}, //header가 아니라 headers
						type : "get",
						data : {"query" : address},
						success : mapView,
						error : function() {alert("카카오 MAP 주소 호출 에러 발생");}
					});
				}
			});
			
			
			
			
			  
		});
		// 책 API
 		function getBookList(bookName){
 			if(bookName == ""){
 				//alert("책 제목을 입력하세요."); //아니면 전체 리스트 호출 
 				return false;
 			} else {
 				// 카카오 책 검색 오픈API 연동(REST API키: 72326f8d9250ae5468ec24e75107792a )
 				// URL: https://dapi.kakao.com/v3/search/book?target=title
 				// H: Authorization: KakaoAK ${REST_API_KEY}		
 				$.ajax({
 					url : "https://dapi.kakao.com/v3/search/book?target=title&size=20",
 					headers	: {"Authorization": "KakaoAK " + kakaoRestApiKey},
 					type : "get",
 					data : {"query" : bookName},
 					dataType : "json",
					success : bookPrint,
					error : function(){ alert("error 발생 ");}
 				});
 				// right.jsp 로딩 프로그레스바 표현 
 				$(document).ajaxStart(function(){$(".Loading-progress").show(); });
 				$(document).ajaxStop(function(){$(".Loading-progress").hide(); });
 				
 			}
		} 
		// 책 DATA 호출 
		function bookPrint(data){
			let bookList = $("#bookList");
			bookList.empty(); // 리스트 초기화
			console.log(data);
			
			if(data && data.documents.length > 0){
				console.log("결과 있음:" + data.documents.length );
				
				//table
				const bookTable = $("<table>")
					.addClass("table-hover");
				bookList.append(bookTable);
				
				//table-thead
				const bookTHead = $("<thead>")
					.append($("<tr>")
						.append($("<th>").text("책이미지"))
						.append($("<th>").text("책가격"))
					);
				bookTable.append(bookTHead);
				
				//table-tbody
				const bookTBody = $("<tbody>");
				bookTable.append(bookTBody);
				
				// $.each() - data 뿌리기
				$.each(data.documents, function(index, bvo){
					let bookTd = $("<tr>")
						.append($("<td>")
							.append($("<a>").attr("href", bvo.url).attr("target", "_blank").text(limitTextLength(bvo.title, 5)) //텍스트 길이 표시 제한 함수 적용 
								.append($("<img>").attr("src", bvo.thumbnail).attr("alt", "책 이미지").css({width:"50px", height:"60px"})
								)
							)
						)
						.append($("<td>").text(bvo.price));
					
					bookTBody.append(bookTd);
				});
				
			} else {
				let emptyResultTable = $("<table>")
					.append($("<tr>")
							.append($("<td>").text("조회된 결과가 없습니다.")));
				bookList.append(emptyResultTable);
			}
		}
		
		// 검색어 결과의 텍스트 표시 길이를 제한하는 함수
		function limitTextLength(text, maxLength) {
		    if (text.length > maxLength) {
		        return text.slice(0, maxLength) + "...";
		    }
		    return text;
		}
		
		
		
		//kakao MAP API 호출 함수 
		function mapView(data){
			
			let y = data.documents[0].y;//위도 
			let x = data.documents[0].x;//경도 
			console.log(y, x);
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(y, x), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };

			// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(y, x);  //검색결과의 경도,위도 입력 

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});

			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			// 회원가입 때, mvo.member.address에 내 농장 위치 입력, API홈페이지 보면 주변 nKM내 장소 검색 쿼리 예시문 있음. 참고하길 
			var iwContent = '<div style="padding:5px;">${mvo.member.memName}<br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new kakao.maps.LatLng(y, x); //인포윈도우 표시 위치입니다
	
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 

			// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
			// marker.setMap(null);  
		}
		
		
		
		
		
		
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