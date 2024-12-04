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
				<div class="input-group input-group-sm"> 
					<input class="form-control" id="searchAddr" type="text" placeholder="SearchAddr">
					<div class="input-group-append">
						<button type="button" class="btn btn-sm btn-success">Go</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 
authorize: 권한을 부여 - 권한허용: 권한이름 
authentication: 인증 - 값: 블러올 정

 -->