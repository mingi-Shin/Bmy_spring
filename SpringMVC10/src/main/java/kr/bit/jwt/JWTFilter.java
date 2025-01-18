package kr.bit.jwt;

import java.io.IOException;

import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class JWTFilter extends OncePerRequestFilter{

	private final JWTUtil jwtUtil;
	
	public JWTFilter(JWTUtil jwtUtil) {
		
		this.jwtUtil = jwtUtil;
	}
	
	// 왜 쿠키를 가져오는걸 doFilterInternal 클래스에서 하는거지? 
	// ->
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
        //cookie들을 불러온 뒤 Authorization Key에 담긴 쿠키를 찾음
		String authorization = null;
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			
			System.out.println(cookie.getName());
			if(cookie.getName().equals("Authorization")) {
				
				authorization = cookie.getValue();
			}
		} 
		
		//Authorization 헤더 검증
		if(authorization == null) {
			
			System.out.println("token null");
			filterChain.doFilter(request, response);
			
			//조건이 해당되면 메소드 종료(필수)
			return;
		}
		
	}

}

/**
 * JWTFilter 클래스에서 Authorization 값의 쿠키를 찾아 처리한 뒤 filterChain에 넘기는 이유는 사용자의 권한과 인증 상태를 확인하여 요청을 처리할 수 있도록 하기 위해서
 * */
