<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
	<title>Member Join</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>  
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
  
  $(document).ready(function(){
	  checkRegisterDuple();
	  checkPasswordNum(); 
	  checkPasswordConfirm();
	  checkSubmit();
	  if(${!empty msgType}){
		  $("#myMessage").modal("show"); //회원가입 오류시 실패 모달창show
	  }
	  
	  
  });
  
	/* 아이디 중복확인 */
	function checkRegisterDuple(){
		let checkDupleButton = document.getElementById('checkRegisterDuple');
		checkDupleButton.addEventListener('click', checkDuple);
		
		//아이디 중복확인 버튼 활성/비활성 (등록버튼 활성/비활성 연계 )
		$('#memID').on('keyup', ableButton);
		function ableButton(){
			$('#checkRegisterDuple').attr('disabled', false);
			$('#submitButton').attr('disabled', true); //등록 버튼 비활성 

		}
		
		function checkDuple(){
			let memID = $('#memID').val(); 
			
			$.ajax({
				url : "${contextPath}/member/checkDuple.do",
				type : "get",
				data : {
					"memID" : memID
				},
				success : function(result){
					if(result == 0){
						//사용 불가능
						$('#checkMessage').html("사용 불가한 아이디입니다.");
					} else {
						//사용 가능
						$('#checkMessage').html("사용 가능한 아이디입니다.");
						console.log('확인');
						$('#checkRegisterDuple').attr('disabled', true); //중복확인 버튼 비활성 
						$('#submitButton').attr('disabled', false); //등록 버튼 활성 
					}	
					
					$('#myModal').modal("show");
				},
				error : function(){
	  				alert("error");
	  		}
			});
		}
	}
  
  
	
	/* 비밀번호 최소자릿수 확인 */
	function checkPasswordNum(){
		let memPassword1 = document.getElementById('memPassword1');
		memPassword1.addEventListener('keyup',ColorBorder );
		
		function ColorBorder(){
			let length = memPassword1.value.length;
			if(length < 12){
				memPassword1.style.border = '3px solid red';
			} else {
				memPassword1.style.border = '3px solid green';
			}
		}		
	}
	
	/* 비밀번호1,2 일치 여부 확인 및 찐비밀번호 설정! */
	function checkPasswordConfirm(){
		let memPassword1 = $('#memPassword1');
		let memPassword2 = $('#memPassword2');
		memPassword1.on('keyup', passwordConfirm);
		memPassword2.on('keyup', passwordConfirm);
		
		function passwordConfirm(){
			if((memPassword1.val() != memPassword2.val()) || (memPassword2.val().length < 12) ){
				$('#confimPW-container').css('display', 'table-row');
				$('#confirmPW').html("비밀번호가 옳지 않습니다.");
				$('#memPassword2').css('border','3px solid red');
				$('#confirmPW').css('color','red');
				$('#memPassword').val('');
			} else{
				$('#confimPW-container').css('display', 'table-row');
				$('#confirmPW').html("비밀번호가 일치합니다.");
				$('#memPassword2').css('border','3px solid green');
				$('#confirmPW').css('color','green');
				$('#memPassword').val(memPassword2.val());
			}
		}
	}
	
	/* submit시 조건 체크 */
	function checkSubmit(){
		let submitButton = $("#submitButton");
		
		// 초기 등록버튼 비활성화
		submitButton.attr('disabled', true);
		
		// 나이 값 체크, 아이디 중복확인 유무 체크  
		
		submitButton.on('click', checkSubmit);
		
		function checkSubmit(){
			let memAge = $("#memAge").val();
			if (memAge == null || memAge == "" || memAge == 0){
				alert("나이를 입력하세요");
				return false;
			}
			document.frm.submit();
		}
	}
	
	
</script>

</head>
<body>

<div class="container">
<jsp:include page="../common/header.jsp"></jsp:include>
  <h2>Join Page (memJoin.do)</h2>
  <div class="card card-default">

    <div class="card-header">회원가입</div>
    <div class="card-body">
    	<form name="frm" method="post" action="${contextPath }/member/memRegister.do" >     
    		<table class="table table-bordered" style="width:100%; text-align: center; border: 1px solid #dddddd; ">
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">아이디</th>
    				<td><input id="memID" name="memID" class="form-control width" type="text" placeholder="아이디를 입력하세요 (20자 이하)" maxlength="20" /></td>
    				<td style="width: 110px; vertical-align: middle;">
    					<button id="checkRegisterDuple" type="button" class="btn btn-primary">중복확인</button>
   					</td>
    			</tr>
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">비밀번호</th>
    				<td colspan="2"><input id="memPassword1" name="memPassword1" class="form-control width" type="password" placeholder="비밀번호를 입력하세요 (12자이상)" minlength="12" /></td>
    			</tr>
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">비밀번호 확인</th>
    				<td colspan="2"><input id="memPassword2" name="memPassword2"  class="form-control width" type="password" placeholder="비밀번호를 재입력하세요" minlength="12" /></td>
    			</tr>
    			<input type="hidden" id="memPassword" name="memPassword" value="" />
    			<tr id="confimPW-container" style="display: none">
    				<td colspan="3" >
   						<div id="confirmPW"></div>
    				</td>
    			</tr>
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">이름</th>
    				<td colspan="2"><input id="memName" name="memName" class="form-control width" type="text" placeholder="성함을 입력하세요" required/></td>
    			</tr>
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">나이</th>
    				<td colspan="2"><input id="memAge" name="memAge" class="form-control width" type="number" placeholder="나이를 입력하세요" /></td>
    			</tr>
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">성별</th>
    				<td colspan="2">
    					<div>
    						<div class="form-check">
							    <input id="memGender" name="memGender" class="form-check-input" type="radio" name="memGender" value="남자" style="float: none" checked>
							    <label class="form-check-label" for="flexRadioDefault1">남자</label>
							</div>
							<div class="form-check">
							    <input id="memGender" name="memGender" class="form-check-input" type="radio" name="memGender" value="여자" style="float: none" >
							    <label class="form-check-label" for="flexRadioDefault2">여자</label>
							</div>
							<div class="form-check">
							    <input id="memGender" name="memGender" class="form-check-input" type="radio" name="memGender" value="기타" style="float: none" >
							    <label class="form-check-label" for="flexRadioDefault3">기타
							    	<input type="text" id="genderInput" disabled oninput="setGenderValue(this.value)">
							    </label>
							</div>
    					</div>
    				</td>
    			</tr>
    			<tr>
    				<th style="width: 110px; vertical-align: middle;">E-mail</th>
    				<td colspan="2"><input id="memEmail" name="memEmail" class="form-control width" type="text" placeholder="이메일을 입력하세요" /></td>
    			</tr>
	    		<tr>
	    			<td colspan="3" >
		    			<div class="d-flex">
		    				<input type="button" id="submitButton" class="btn btn-primary btn-sm ms-auto" value="등록" />
		    			</div>
	    			</td>
	    		</tr>
    		</table>
    	</form>
    	
			<!-- The Modal -->
			<div class="modal fade" id="myModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">Modal Heading</h4>
			        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body">
			       	<p id="checkMessage">checkMessage</p>
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			      </div>
			
			    </div>
			  </div>
			</div>
			
			<!-- 회원가입 서버사이드 검증 오류 모달창 -->
			<div class="modal fade" id="myMessage" role="dialog">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">${msgType }</h4>
			        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body">
			       	<p>${msg }</p>
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			      </div>
			
			    </div>
			  </div>
			</div>
			
    </div>
    <div class="card-footer">card foot</div>
  </div>
</div>

</body>
</html>