package kr.mingi.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;


//Spring Security 동작 클래스 만들기
public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer {

	//기타 코드 필요없음 
}


/**
	AbstractSecurityWebApplicationInitializer클래스를 상속하여 SecurityInitializer를 생성한다.
	- 내부적으로 DelegatingFilterProxy를 스프링에 등록하여 스프링 시큐리티를 내부적으로 동작시킨다.
 * */
 