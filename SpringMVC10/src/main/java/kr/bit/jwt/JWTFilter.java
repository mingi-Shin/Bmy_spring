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
