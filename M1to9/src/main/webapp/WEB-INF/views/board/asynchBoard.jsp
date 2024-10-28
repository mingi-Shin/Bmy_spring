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
<html lang="en">
<head>
  <title>비동기 게시판</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
 	<style>
	  table {
	    border-collapse: collapse;
	    width: 100%;
	    margin: 20px 0;
	  }
	
	  th, td {
	    border: solid 1px #ddd;
	    padding: 10px;
	    text-align: left;
	  }
	
	  th {
	    background-color: #f2f2f2;
	  }
	
	  a {
	    color: #007BFF;
	    text-decoration: none;
	  }
	
	  a:hover {
	    text-decoration: underline;
	  }
	
	  .no-data {
	    text-align: center;
	    color: #888;
	    padding: 10px;
	  }
	</style>
	
  <script type="text/javascript">
  	$(document).ready(function(){ // 문서가 시작되면 가장먼저 동작할 함수 호출 
  		
  		loadBoardList();
  		showBoard();
  		goInsert();
  		
  		//모달
		  if(${!empty msgBody}){
			  $("#myMessage").modal("show"); 
		  }
		
  	});
  	
  	//게시판 목록 불러오기 
  	function loadBoardList(){ 
  		$.ajax({
  			url: `${contextPath}/asynchBoard/list`,
  			method: 'GET',
  			dataType: 'json',
  			success: makeView,
  			error: function(jqXHR){ 
  				alert("에러: ", jqXHR.responseText); 
  			}
  		});
 		
  		// 게시판 동적 생성 
	  	function makeView(data){ // boardList.do의 return값 list가 data 변수에 들어가있다.
	  		let htmlList = "<table><thead>";
	  		htmlList += "<tr>";
	  		htmlList += "<th> 인덱스 </th>";
	  		htmlList += "<th> 제목 </th>";
	  		htmlList += "<th> 글쓴이 </th>";
	  		htmlList += "<th> 작성일 </th>";
	  		htmlList += "<th> 조회수 </th>";
	  		htmlList += "</tr></thead>";
	 			htmlList +="<tbody>";
	 			
	 			if(data){
		  		$.each(data, function(index, vo){
		  			htmlList +="<tr>";
		  			htmlList +="<td>" + vo.boardIdx + "</td>"; 
		 	  		htmlList += "<td id='ti"+vo.boardIdx+"'><a href='javascript:goContent("+vo.boardIdx+")'>"+vo.title+"</a></td>";
		 	  		htmlList += "<td>"+ vo.writer +"</td>";
		 	  		htmlList += "<td>";
		 	  		htmlList += vo.indate;
		 	  		htmlList += "</td>";
		 	  		htmlList += "<td id='cnt"+vo.boardIdx+"'>"+ vo.count +"</td>";
		 	  		htmlList += "</tr>";
		 	  		htmlList += "<tr id='c"+ vo.boardIdx + "' style='display:none'>";
		 	  		htmlList += "<th>내용</th>";
		 	  		htmlList += "<td colspan='4'>";
		 	  		htmlList += "<textarea id='con"+ vo.boardIdx + "' rows='7' class='form-control' readonly ></textarea>";
	 				
		 	  		if('${mvo.member.memID}' == vo.memID){
			  	  		htmlList += "<br>"
			  	  		htmlList += "<a href='javascript:goUpdateForm("+vo.boardIdx+")' id='m"+vo.boardIdx+"' class='btn btn-warning btn-sm'> 수정 </a> &nbsp;"
			  	  		htmlList += "<a href='javascript:goDelete("+vo.boardIdx+")' id='d"+vo.boardIdx+"' class='btn btn-danger btn-sm'> 삭제 </a> &nbsp;"
	  	  		}
	 	  			htmlList += "</td>";
	  	  		htmlList += "</tr>";
	 				}) 
		  		
	 			}	else {
		 	  		htmlList += "<tr>";
		 	  		htmlList += "<td colspan='5' class='no-data'>";
		 	  		htmlList += "현재 조회가능한 게시물이 없습니다.";
		 	  		htmlList += "</td>";
		 	  		htmlList += "</tr>";
		 			}
	 			
	  			htmlList += "</tbody>";
	  			htmlList += "</table>";
	  			
	  			$("#view").html(htmlList);
	  	  		
  	  		$("#view").css("display", "block");  // 글쓰기 완료후 리스트창 오픈
  	  		$("#writeForm").css("display", "none"); // 글쓰기 완료후 글쓰기 폼 닫기
  	  		
 			}
 		}
  		
  	/* 게시물 글쓰기 버튼 클릭시 이벤트 */
  	function showBoard(){
	  	let writeButton = document.getElementById('writeBoardButton');
	  	
	  	writeButton.addEventListener('click', showForm);
  	
  	
	  	function showForm(){
	  		$("#view").css("display", "none"); //감춰
	  		$("#writeForm").css("display", "block"); //보여줘
	  		
	  		document.getElementById('writeBoardButton').innerText = "목록으로"; // innerHTML은 XSS공격에 취약. 
	  		
	  		document.getElementById('writeBoardButton').removeEventListener('click', showForm);
	  		document.getElementById('writeBoardButton').addEventListener('click', goBackMain);
	  		
	  	}
	  	
	  	function goBackMain(){  
	  		$("#view").css("display", "block"); 
	  		$("#writeForm").css("display", "none"); 
	  		
	  		document.getElementById('writeBoardButton').innerText = "글쓰기";
	  		
	  		document.getElementById('writeBoardButton').removeEventListener('click', goBackMain);
	  		document.getElementById('writeBoardButton').addEventListener('click', showForm);
	  		
	  		/*목록 누를 떄 리스트 갱신!*/
	  		loadBoardList();
	  	}
	  	
	  	window.goBackMain = goBackMain; //재활용하기 위해서 전역메서드화 ()
	  	
  	}
  	
  	/* 글 쓰기 */
   	function goInsert(){
  		
  		const insertButton = document.getElementById('insertBoard');
  		insertButton.addEventListener('click', insertBoard);
  		
  		function insertBoard(){
  			let fData = $("#frm").serialize(); //폼의 모든 파라미터 직렬화, ==쿼리형으로 넘김, JSON아님 
  			console.log(fData);
  	  		
  			let csrfHeaderName = "${_csrf.headerName}";
  			let csrfTokenValue = "${_csrf.token}";
  			
 	  		$.ajax({
 	  			url : "board/new",
 	  			type : "post",
 	  			data : fData,
 	  			beforeSend: function(xhr){
 	  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
 	  			},
 	  			success : function(response){
 	  				alert('게시물 작성에 성공');
 	  				
 	  				window.goBackMain(); //쓰고나면 리스트 갱신해, 목록으로 텍스트를 글쓰기로 다시 바꿔. 
 	  				},
 	  			error : function(){alert('error');}
 	  		});
  			
  			// 폼 작성됐던 글 초기화
  			//$("#title").val("");
  			//$("#content").val("");
  			//$("#writer").val("");
  			$("#resetForm").trigger("click"); //trigger함수 : 이벤트 발생 -
  			
  			$("#frm")[0].reset(); //jQueryr객체 -> DOM객체 -> reset()함
  			
  		}
  	}
  	
  	/* 상세보기 : content 보이기_숨기기 */
  	function goContent(boardIdx){ //1, 2, 3 ...
  		if($("#c"+boardIdx).css("display") == "none"){
  			
  			$.ajax({
  				url : "board/"+boardIdx,
  				type : "GET",
  				//data : {"idx" : idx},
  				datatype: "JSON",
  				success : function(voData){
  					$("#con"+boardIdx).val(voData.content);
  					
  					$("#cnt"+boardIdx).text(voData.count);
  				},
  				error: function(error){
						alert("조회 중 오류가 발생했습니다.");
						console.error("조회 중 오류 발생:", error);
					}
  				
  			});

	  		$("#c"+boardIdx).css("display", "table-row"); // block이 아니라 table-row 
  		}else{
	  		$("#c"+boardIdx).css("display", "none"); 
  		}

  	}
  	
  	/* 글 수정 준비 (폼 생성) */
  	function goUpdateForm(boardIdx){  		
  		$("#c"+boardIdx+" textarea").prop("readonly", false); //or textarea에 id값을 주고 $().attr("readonly", false)로 수정 
  		$("#c"+boardIdx+" textarea").css({"border-color" : "red", 
  									 "border-width" : "2px"}); //테두리 강조  
  		
  		
  		let titleValueOrin = $("#ti"+boardIdx).text(); //원래제목 
  		let newTitle = "<input type='text' id='newTi"+boardIdx+"' class='form-control' value='"+titleValueOrin+"' style='border-color:red; border-width:2px;'> </input>"; //제목창 form
  		$("#ti"+boardIdx).html(newTitle); //제목창 호출 
  		
  		let updateButton = "<a href='javascript:boardUpdate("+boardIdx+")' id='up"+boardIdx+"' class='btn btn-primary btn-sm'> 등록 </a> &nbsp;"
  		//$("#m"+idx).html(updateButton); // css깨짐 발생 
  		$("#m"+boardIdx).replaceWith(updateButton);
  		
  		let cancelButton = "<a href='javascript:loadBoardList()' class='btn btn-warning btn-sm'>취소</a>";
  		$("#d"+boardIdx).replaceWith(cancelButton);
  		
  	}
  	/* 글 수정 완료 (폼 업로드_Ajax) */
	function boardUpdate(boardIdx){
  		
  		let newContent = $("#c"+boardIdx+" textarea").val(); //일반적으로 textarea의 값은 val()로 가져온다. 
  		let newTitle = $("#newTi"+boardIdx).val();
  		
			let csrfHeaderName = "${_csrf.headerName}";
 			let csrfTokenValue = "${_csrf.token}";
  		
  		$.ajax({
  			url : "board/update",
  			method : "PUT",
  			contentType : 'application/json;charset=utf-8', // data가 JSON형식임을 서비스에게 알림 (아래)
  			data : JSON.stringify({ // Javascript를 JSON으로 바꿔주기 
  				"boardIdx" : boardIdx,
  				"title" : newTitle,
  				"content" : newContent,
  			}),
  			beforeSend: function(xhr){
	  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
  			},
  			success : function(){
  				alert('수정 성공');
  				loadBoardList();
  			}, 
  			error: function(error){
				alert("수정 중 오류가 발생했습니다.");
				console.error("수정 중 오류 발생:", error);
				}
  		});
	}
  	
  	/* 글 삭제 */
  	function goDelete(boardIdx){
  		
  		if(confirm(boardIdx + '번 글을 삭제하시겠습니까?')){
  			deleteBoard(boardIdx);
  		} else {
  			alert('삭제가 취소되었습니다.');
  		}
  		
  		function deleteBoard(boardIdx){
  			
  			let csrfHeaderName = "${_csrf.headerName}";
 				let csrfTokenValue = "${_csrf.token}";
  			
	  		$.ajax({
	  			url : "board/" + boardIdx, // PathVariable 값 
	  			type : "DELETE",
	  			//data : { "idx" : idx }, //주의 : data값은 객체형식이어야 한다. RESTful방식에선 생략 
	  			beforeSend: function(xhr){
 	  				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
 	  			},
	  			success : function(response){
	 	  				alert( boardIdx+'번 게시물을 삭제하였습니다.');
	 	  				loadBoardList(); //쓰고나면 리스트 갱신해
  				},
	 	  		error : function(){alert('error : ' + boardIdx);}
	  		});
  		}
  	}
  </script>
</head>

<body>
<div class="container">
<jsp:include page="../common/header.jsp" />
  <h2>회원 게시판</h2>
  <div class="card card-default">
    <div class="card-body" id="view">card Content</div>
    
    <div class="card-body"><button id="writeBoardButton" class='btn btn-primary btn-sm'>글쓰기</button></div>
    
    <div class="card-body" id="writeForm" style="display: none;">
    	<p align="center">게시판 글쓰기</p>
  
    	<form id="frm">
	      <table class="table">
	      <input type="hidden" name="memID" value="${mvo.member.memID }"/>
	    		<tr>
	          <td>제목</td>
	        	<td><input type="text" id="title" name="title" class="form-control"/></td>
	        </tr>
	        <tr>
	       	  <td>내용</td>
	         	<td><textarea rows="7" id="content" name="content" class="form-control"></textarea> </td>
	        </tr>
	        <tr>
	          <td>작성자</td>
	          <security:authorize access="isAuthenticated()">
		          <td><input type="text" id="writer" name="writer" class="form-control" value="${mvo.member.memName }" readonly/></td>
	          </security:authorize>
	        </tr>
	        <tr>
	         	<td colspan="2" align="center">
	         		<button type="button" id="insertBoard" class="btn btn-success btn-sm">등록</button>
	         		<button type="reset" id="resetForm" class="btn btn-warning btn-sm">리셋</button>
	         	</td>
	        </tr>
	     	</table>
    	</form>
    	
    </div>
    <div class="card-footer">인프런_박매일</div>
  </div>


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