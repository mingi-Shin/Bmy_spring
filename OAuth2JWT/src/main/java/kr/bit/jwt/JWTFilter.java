package kr.bit.jwt;

import java.io.IOException;

import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
 * 스프링 시큐리티 filter chain에 요청에 담긴 JWT를 검증하기 위한 커스텀 필터를 등록해야 한다.
 * 해당 필터를 통해 요청 쿠키에 JWT가 존재하는 경우 JWT를 검증하고 강제로SecurityContextHolder에 세션을 생성한다. 
 * (이 세션은 STATLESS 상태로 관리되기 때문에 해당 요청이 끝나면 소멸 된다.)
 * */

public class JWTFilter extends OncePerRequestFilter{
	
	private final JWTUtil jwtUtil;
	public JWTFilter(JWTUtil jwtUtil) {
		
		this.jwtUtil = jwtUtil;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        //cookie들을 불러온 뒤 Authorization Key에 담긴 쿠키를 찾음 (내가 쿠키에 JWT를 담아서 보내줬었으니까)
		String authorization = null;
		
		Cookie[] cookieList = request.getCookies();
		for(Cookie cookie : cookieList) {
			System.out.println("담긴 쿠키 리스트 : " + cookie);
			if(cookie.getName().equals("Authorization")) {
				authorization = cookie.getValue(); //
			}
		}
		
		String token = authorization; // token에는 Authorization 쿠키의 Value가 들어가게 됨, 아래 메서드에 사용됨 
		
		//쿠키 Authorization의 값을 검증
		if(token == null) {
			
			System.out.println("Token is Null");
			filterChain.doFilter(request, response);
			
			//조건이 해당되면 메소드 종료
			return;
		}
		
		//일단 Authorization 값이 null은 아님 -> 토큰의 소멸시간 검증
		if(jwtUtil.isExpired(token)) {
			
			System.out.println("Token is expired");
			filterChain.doFilter(request, response);
		}
		
		//토큰에서 정보빼기 -> UserDTO생성 -> OAuth2User객체 생성 -> 시큐리티 인증토큰 생성 -> 세션에 사용자 등록 
		https://www.youtube.com/watch?v=9g_iN6rLQcQ&t=1s&ab_channel=%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9C%A0%EB%AF%B8
		

		
	}
	

}

