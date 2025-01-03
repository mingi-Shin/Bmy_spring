<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal }" />
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }" />    

<div class="card" style="min-height: 500px; max-height: 1000px;">
	<!-- 첫번째 로우 -->
	<div class="row">
		<div class="col-sm-12">
			<div class="card-body">
				<h4 class="card-title">
					<security:authorize access="isAnonymous()">
						<h4>GUEST</h4>
					</security:authorize>
					<security:authorize access="isAuthenticated()" >
						<security:authentication property="principal.member.memName"/>
					</security:authorize>
				</h4>
				<p class="card-text">회원님 Welcome!</p>
					<p>로그인 Form (구현안함)</p>
			</div>
		</div>
	</div>
	<!-- 두번째 로우 -->
	<div class="row">
		<div class="col-sm-12">
			<div class="card-body">
				<p class="card-text">MAP View</p>
				<!-- 프로그래스 바 -->
				<div class="Loading-progress" style="display: block;">
					<div class="spinner-grow text-primary" role="status"> <!-- role: 접근성(Accessibility)을 위한 속성 -->
						<span class="visually-hidden">Loading... </span>
					</div>
				</div>
				<div class="input-group input-group-sm"> 
					<input class="form-control" type="text" id="address" placeholder="SearchAddr">
					
					<div class="input-group-append">
						<button type="button" class="btn btn-sm btn-success" id="mapBtn">Go</button>
					</div>
				</div>
				
				<!-- 지도를 표시할 div 입니다 -->
				<div id="map" style="width:100%;height:250px;"></div>
				
				
			</div>
		</div>
	</div>
</div>


<!-- 
authorize: 권한을 부여 - 권한허용: 권한이름 
authentication: 인증 - 값: 블러올 정

 -->