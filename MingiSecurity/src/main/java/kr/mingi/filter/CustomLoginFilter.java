package kr.mingi.filter;


import org.hibernate.annotations.Filter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.mingi.service.CustomUserDetailsService;

public class CustomLoginFilter extends UsernamePasswordAuthenticationFilter {

	private final AuthenticationManager authenticationManager;
	
	public CustomLoginFilter(AuthenticationManager authenticationManager) {
		this.authenticationManager = authenticationManager;
		
	}
	
	// 1. 인증시도 메서드
	@Override
	public Authentication attemptAuthentication(HttpServletRequest req, HttpServletResponse res) throws AuthenticationException {
		
		String username = obtainUsername(req);
		String password = obtainPassword(req);
		System.out.println("로그인 시도 username : " + username);
		System.out.println("로그인 시도 password : " + password);
		
		// 스프링시큐리티에서 username과 password를 검증하기 위해서는 Token에 담아줘야 합니다 ->
		// 	UsernamePasswordAuthenticationToken 객체는 Authentication 인터페이스를 구현한 클래스
		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(username, password, null);
		System.out.println("토큰생성(username, password): " + authenticationToken);
		// 토큰생성 후에는 UserDetailsService의 loadUserByUsername() 실행 
		
		// 예외 핸들링을 추가
		try {
			// token에 담긴 정보를 검증하기 위해 AuthenticationManager의 authenticate()에게 token 전달
		    Authentication authentication = authenticationManager.authenticate(authenticationToken);
		    System.out.println("인증 성공: " + authentication);
		    System.out.println("권한: " + authentication.getAuthorities());
		    return authentication;
		} catch (AuthenticationException e) {
			e.printStackTrace(); //비밀번호가 문제였네??..
		    System.out.println("인증 실패: " + e.getMessage());
		    throw e;
		}
	}
	
	//로그인 성공시 실행 메서드
	@Override
	protected void successfulAuthentication(HttpServletRequest req, HttpServletResponse res, 
			FilterChain filterChain, Authentication authentication) {
		//JWT발급
		System.out.println("successfulAuthentication 실행: 로그인 성공 ");
		
		if (authentication.getAuthorities().isEmpty()) {
	        // 예: 권한이 비어 있을 경우 추가적으로 설정하거나 로그를 남길 수 있습니다.
	        System.out.println("No authorities assigned to the authenticated user");
	    }
		
	}
	
	// 로그인 실패시 실행되는 메소드
	@Override
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException failed){
		
	    System.out.println("로그인 실패 : " + failed.getMessage());  // 실패 이유 출력
		response.setStatus(401);
	}
	
}

/**
 * 	final은 참조가 변경될 수 없게 막는 역할만 하고 객체 내부의 값을 수정하는 것은 막지 않습니다. (내부 값을 final하고 set을 금지)
 * 
 * 	필드 주입 (책 빌려서 수정 가능): 책을 수정해서 누군가 다른 곳에서 그 책을 빌리면, 수정된 내용을 다시 보게됨.
 *
 *	생성자 주입 (책 고정): 책을 빌려서 수정할 수 없고, 고정된 내용대로 동작을 보장합니다.
 * */
