package kr.mingi.jwt;

import java.io.IOException;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.mingi.DTO.CustomUserDetails;
import kr.mingi.entity.Member;

public class JWTFilter extends OncePerRequestFilter { //상속:  동일한 요청에서 필터 체인을 여러 번 거칠 가능성이 있는 경우에도, 특정 작업을 HTTP 요청 당 한 번만 실행

	private final JWTUtil jwtUtil;
	
	public JWTFilter(JWTUtil jwtUtil) {
		this.jwtUtil = jwtUtil;
	}
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		//1. request에서 Authorization 헤더를 찾음
		String authorization = request.getHeader("Authorization");
		System.out.println("헤더 Authorization값: " + authorization);
		
		//2. Authorization 헤더 검증
		if(authorization == null || !authorization.startsWith("Bearer")) {
			
			System.out.println("token null");
			filterChain.doFilter(request, response);
			
			//조건이 해당되면 메서드 종료(필수)
			return;
		}
		
		System.out.println("authorization now");
		//Bearer 부분 제거 후 순수 토큰만 획득
		String token = authorization.split(" ")[1];
		
		//3. 토큰 소멸 시간 검증
		if(jwtUtil.isExpired(token)) {
			
			System.out.println("token expired");
			filterChain.doFilter(request, response);
			
			return;
		}
		
		//4. 검증 완료 -> 일시적 세션 생성
		
		//토큰에서 username과 role 획득
		String username = jwtUtil.getUsername(token);
		String role = jwtUtil.getRole(token);
		
		//Member객체 생성 값set
		Member member = new Member();
		member.setUsername(username);
		member.setPassword("tempPassword"); //DB에서 가져올 필요없어
		member.setRole(role);
		
		//UserDetails에 회원 정보 객체 담기
		CustomUserDetails customUserDetails = new CustomUserDetails(member);
		
		//스프링 시큐리티 인증 토큰 생성
		Authentication authToken = new UsernamePasswordAuthenticationToken(customUserDetails, null, customUserDetails.getAuthorities());
		System.out.println("시큐리티 인증 토큰: " + authToken);
		
		//세션에 사용자 등록(요청끝나면 사라짐)
		SecurityContextHolder.getContext().setAuthentication(authToken);
		
		filterChain.doFilter(request, response);
		
	} 

}
