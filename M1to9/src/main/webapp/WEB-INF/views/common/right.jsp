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
	<div class="card-body">
		<h4>BOOK Search</h4>
		<div class="input-group input-group-sm"> 
			<input class="form-control" id="searchBook" type="text" placeholder="SearchBook">
			<div class="input-group-append">
				<button type="button" class="btn btn-sm btn-success">Go</button>
			</div>
		</div>
	</div>	
</div>