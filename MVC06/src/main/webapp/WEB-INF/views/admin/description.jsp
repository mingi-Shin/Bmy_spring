<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
	<title>template</title>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
   <style>
   	img {
   		width: 100%;
   	}
   </style>
</head>
<body>

<div class="container">
	<jsp:include page="../common/header.jsp"></jsp:include>

  <h2>Spring MVC06</h2>
  <div class="card card-default">

    <div class="card-header" >card title</div>
    <div class="card-body" >
			<h1>MVC04부터 부가설명 </h1>
			
			<h2>XML에서 Java 클래스로 환경 설정을 옮기는 트렌드는 여러 가지 이유로 발생했습니다. 주요 이유는 다음과 같습니다:</h1>
			<p>
			1.	타입 안정성 (Type-Safety): XML은 순수한 문자열 기반의 설정 파일이기 때문에 컴파일 시점에 오류를 감지하기 어렵습니다. 반면에, Java 클래스를 사용하면 컴파일 시점에 잘못된 설정을 발견할 수 있어 더 안전합니다.<br>
			2.	코드 자동 완성 및 리팩토링: Java 클래스에서 설정을 작성하면 IDE의 자동 완성 기능을 활용할 수 있고, 리팩토링 작업도 수월해집니다. 반면, XML은 이런 편리함이 떨어집니다.<br>
			3.	유연성 및 표현력: Java는 프로그래밍 언어이기 때문에 로직을 기반으로 동적인 설정을 할 수 있습니다. 조건문, 반복문 등을 사용해 설정을 동적으로 조정하는 것이 가능해지며, 이는 XML에서 매우 어렵거나 불가능한 작업입니다.<br>
			4.	XML의 복잡성 감소: XML은 규모가 커지면 복잡해지고 가독성이 떨어집니다. 이를 해결하기 위해 Java 클래스로 설정을 이동하면 코드의 가독성이 좋아지고 유지보수가 쉬워집니다.<br>
			5.	스프링 부트와 같은 현대적인 프레임워크 도입: Spring Boot와 같은 현대적인 프레임워크는 기본적으로 XML이 아닌 Java 기반 설정을 권장합니다. 이는 프로젝트 설정이 더 직관적이고 간결해지는 효과를 가져옵니다. 또한, Spring Boot는 많은 자동 설정을 제공하여 설정에 신경 쓸 필요가 줄어듭니다.<br>
					이러한 이유들로 인해 기존 XML 기반의 설정이 점점 Java 클래스 기반 설정으로 대체되는 추세가 되었습니다.
			</p>
			<hr>
			
			<h2>Spring Security와 같은 보안 프레임워크는 여러 가지 유형의 공격으로부터 애플리케이션을 보호</h1>
			<p>
			1.	CSRF는 공격자가 사용자의 인증 정보를 도용하여, 사용자가 원하지 않는 요청을 애플리케이션에 보내는 공격 기법입니다. 이를 방지하기 위해 Spring Security는 CSRF 토큰을 활용해 요청의 유효성을 검증합니다. CSRF 보호를 통해 애플리케이션은 같은 사이트에서 생성된 요청만을 허용하고, 다른 사이트에서 생성된 악의적인 요청을 차단할 수 있습니다.<br>
			2.	XSS(Cross-Site Scripting): 공격자가 악성 스크립트를 웹 페이지에 삽입하여 사용자의 브라우저에서 실행되도록 유도하는 공격입니다. Spring Security는 콘텐츠 보안 정책(CSP) 및 입력값 필터링으로 이를 방어할 수 있습니다.<br>
			3.	SQL Injection: 공격자가 입력값을 조작해 SQL 쿼리를 변형시키는 공격입니다. Spring Security와 함께 사용하는 JPA나 MyBatis와 같은 ORM(Object-Relational Mapping) 도구들은 안전한 쿼리 생성을 지원하여 SQL Injection 방지를 돕습니다.<br>
			4.	인증 및 권한 부여 문제: 다른 사이트에서 해킹된 정보로 잘못된 요청을 보내는 공격이 성공하려면, 인증이 제대로 되어 있지 않거나, 사용자가 해당 요청을 보낼 권한이 없는 경우가 많습니다. Spring Security는 세밀한 인증(Authentication) 및 권한 부여(Authorization) 메커니즘을 제공하여, 올바르게 인증된 사용자만이 권한을 가지고 적절한 요청을 할 수 있도록 보장합니다.	
			</p>
			<hr>
			<h2>CSRF토큰 생성, 교환 과정</h2>
			<h3>서버에서 CSRF토큰 생성: </h3>
			<p>사용자가 특정 페이지를 요청하거나, 처음 사이트를 방문할 때 서버가 CSRF토큰을 생성: 이 토큰은 사용자의 세션과 연결되며 고유한 값을 가짐 </p>
			<h3>CSRF토큰을 클라이언트에 전달 </h3>
			<p>방법: 쿠키, HTML폼 내의 hidden필드, HTML의 meta태그</p>
			<p>클라이언트가 form 제출, AJAX요청시 서버로부터 받은 토큰을 요청에 포함하여 전달, 서버는 이를 비교하여 일치시 요청 처리  </p>
			<hr>
			
			<div>
				<img alt="spring web security" src="${contextPath }/resources/images/스프1탄_48.png" >
			</div>
			<div>
				<p>1. xhr: XMLHttpRequest객체, 브라우저가 서버와 비동기적으로 데이터를 주고받기 위해 사용하는 기본적인 HTTP요청 객체 </p>
				<p>2. enctype으로 form을 넘길때는 URL쿼리스트링으로 토큰을 넘겨주어야 한다. </p>
				<p>2. get방식은 CSRF검사를 하지 않는다.  </p>
			</div>
			<hr>
			<div>
				<h2>resultMap 사용법</h2>
				<img alt="spring web security" src="${contextPath }/resources/images/스프1탄_54.png" >
			</div>
			<div>
				<p>1. DB에서 넘어오는 Column을 entity의 property에 맵핑하는 모습  </p>
				<p>2. 결과가 arrayList이기 때문에 collection 활용   </p>
			</div>
			
    </div>
    <div class="card-footer">card foot</div>
  </div>
</div>

</body>
</html>