<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" scope="request" /> 
<!-- scope: request > page(기본값) 다른 페이지에서 var사용가능 -->

<nav class="navbar navbar-expand-sm bg-dark navbar-dark sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">MVC03</a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/boardMain.do">게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>  
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">고객센터</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="${contextPath}/admin/showMemberList.do">멤버 조회(admin)</a></li>
            <li><a class="dropdown-item" href="${contextPath}/admin/showDescription.do">MVC04 설명보드</a></li>
            <li><a class="dropdown-item" href="#">A third link</a></li>
          </ul>
        </li>
      </ul>
      <div style="margin-right: 10px;">
	      <form class="d-none d-sm-flex">
	        <input class="form-control me-2" type="text" placeholder="전체 게시물 검색">
	        <button class="btn btn-primary" type="button">search</button>
	      </form>
      </div>
      
			<c:if test="${!empty loginM}">
				<c:if test="${loginM.memProfile eq ''}" >
					<img alt="기본이미지" src="${contextPath }/resources/images/defaultProfile.jpg" style="width: 50px; height: 50px;" class="rounded-circle"> 
				</c:if>
				<c:if test="${loginM.memProfile ne ''}" >
					<img alt="회원 이미지" src="${contextPath }/resources/upload/${loginM.memProfile}" style="width: 50px; height: 50px;" class="rounded-circle"> 
				</c:if>
			</c:if>		
			
      <c:if test="${empty loginM}"> 
	      <ul class="navbar-nav navbar-right">
	      	<li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">접속</a>
	          <ul class="dropdown-menu dropdown-menu-end">
	            <li><a class="dropdown-item" href="${contextPath}/member/memLoginForm.do">로그인</a></li>
	            <li><a class="dropdown-item" href="${contextPath}/member/memJoin.do">회원가입</a></li>
	          </ul>
	        </li>
	      </ul>
      </c:if>

       <c:if test="${!empty loginM}">
	      <ul class="navbar-nav navbar-right">
	      	<li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">${loginM.memName }</a>
	          <ul class="dropdown-menu dropdown-menu-end">
	            <li><a class="dropdown-item" href="${contextPath}/member/memUpdateForm.do">회원정보수정</a></li>
	            <li><a class="dropdown-item" href="${contextPath}/member/memImageForm.do">프로필사진등록</a></li>
	            <li><a class="dropdown-item" href="${contextPath}/member/memLogout.do">로그아웃</a></li>
	          </ul>
	        </li>
	      </ul>
      </c:if>
      
    </div>
  </div>
</nav>