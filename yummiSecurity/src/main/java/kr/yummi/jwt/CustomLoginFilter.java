package kr.yummi.jwt;

import java.io.IOException;


import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomLoginFilter extends UsernamePasswordAuthenticationFilter {

	private final AuthenticationManager authenticationManager;
	
	//생성자 주입방식: 불변 
	public CustomLoginFilter(AuthenticationManager authenticationManager) {
		this.authenticationManager = authenticationManager;
	}
	
	//로그인 인증시도 메서드 
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		
		// 클라이언트 요청에서 username, password 추출
		String username = obtainUsername(request);
		String password = obtainPassword(request);
		
		System.out.println("username : " + username);
		System.out.println("password : " + password);
		
		// 스프링시큐리티에서 username과 password를 검증하기 위해서는 Token에 담아줘야 합니다 ->
		// 	UsernamePasswordAuthenticationToken 객체는 Authentication 인터페이스를 구현한 클래스
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password);
		
		// token에 담긴 정보를 검증하기 위해 AuthenticationManager의 authenticate()에게 매개변수로 전달
		return authenticationManager.authenticate(authToken);
	} 
	
	// 로그인 성공시 실행되는 메소드 (여기서 JWT 발급 로직 수행)
	// AbstractAuthenticationProcessingFilter 클래스에 해당 메서드가 정의되어 있다.
	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			FilterChain chain, Authentication authentication) {
		
    }
	
	// 로그인 실패시 실행되는 메소드
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException failed) {
		
	}
}
