<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax JSON</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function(){
		$("#getDataBtn").on("click", ajaxGetJsonMembers);
	});
	
	function ajaxGetJsonMembers() {
		alert(">> ajaxGetJsonMembers() 실행~~");
		
		$.ajax("getJsonMembers", {
			type : "get",
			dataType : "json", //응답 받을 데이터 타입(형식)
			success : function(respData){
				alert(">> Ajax 처리 성공 - 응답받은 데이터 : " + respData);
				console.log(respData);
				console.log(respData.list);
				
				//전달받은 JSON 데이터 사용 tr 태그 만들고 화면출력
				let htmlTag = "";
				let alist = respData.list; //JSON 객체의 속성명 "list"의 값 추출
				$.each(alist, function(index, member){
					//console.log("this.name : " + this.name);
					//console.log("member.name : " + member.name);
					htmlTag += "<tr>";
					htmlTag += "<td>" + this.idx + "</td>";
					htmlTag += "<td>" + this.name + "</td>";
					htmlTag += "<td>" + this["age"] + "</td>";
					htmlTag += "<td>" + this["addr"] + "</td>";
					htmlTag += "<td>" + this["regdate"] + "</td>";
					htmlTag += "</tr>";
				});
				$("#dispData").html(htmlTag);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(">> Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
		});
	}
</script>
</head>
<body>
	<h1>Ajax JSON 데이터 요청 처리</h1>
	<button id="getDataBtn">Ajax - JSON 데이터 가져오기</button>
	<hr>
	<table border>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>나이</th>
				<th>주소</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody id="dispData">
			<%-- JSON 데이터 활용 목록 출력할 곳 --%>
		</tbody>
	</table>
	<hr>
	<a href="javascript:getJsonMembersName('홍길동')">JSON 데이터 조회(이름으로 검색)</a>
<script>
	function getJsonMembersName(name) {
		alert(">> getJsonMembersName 실행~~ 이름 : " + name);
		alert(">> encodeURIComponent(name) : " + encodeURIComponent(name));
		
		$.ajax("getJsonMembersName", {
			type : "get",
			data : "name=" + encodeURIComponent(name), //서버로 전달하는 데이터
			dataType : "json", //응답 받는 데이터 타입
			success : function(data) {
				alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
			},
			error : function() {
				alert("실패~~~");
			}
		});
	}
</script>	
	
</body>
</html>