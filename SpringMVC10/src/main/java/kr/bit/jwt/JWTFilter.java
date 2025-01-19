package kr.bit.jwt;

import java.io.IOException;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.bit.DTO.CustomOAuth2User;
import kr.bit.DTO.MemberDTO;

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
			
			System.out.println("token is Null");
			filterChain.doFilter(request, response);
			
			//조건이 해당되면 메소드 종료(필수)
			return;
		}
		
		//토큰
		String token = authorization;
		
		//토큰 소멸시간 검증
		if(jwtUtil.isExpired(token)) {
			
			System.out.println("token is Expired");
			filterChain.doFilter(request, response);
			
            //조건이 해당되면 메소드 종료 (필수)
			return;
		}
		
		//토큰에서 username과 role 획득
		String username = jwtUtil.getUsername(token);
		String role = jwtUtil.getRole(token);
		String name = jwtUtil.getName(token);
		
		//MemberDTO를 생성하여 값set
		MemberDTO memberDTO = new MemberDTO();
		
		memberDTO.setUsername(username);
		memberDTO.setRole(role);
		memberDTO.setName(name);
		
		//UserDetails에 회원 정보 객체 담기
		CustomOAuth2User customOAuth2User = new CustomOAuth2User(memberDTO);
		
		//스프링 시큐리티 인증토큰 생성
		Authentication authToken = new UsernamePasswordAuthenticationToken(customOAuth2User, null, customOAuth2User.getAuthorities());
		
		//세션에 사용자 등록(요청 완료후 삭제될거임 : stateless)
		SecurityContextHolder.getContext().setAuthentication(authToken);
		
        filterChain.doFilter(request, response);

	}

}

/**
 * JWTFilter 클래스에서 Authorization 값의 쿠키를 찾아 처리한 뒤 filterChain에 넘기는 이유는 사용자의 권한과 인증 상태를 확인하여 요청을 처리할 수 있도록 하기 위해서
 * 
 * 필터체인이 실행되면, JWTFilter에서 JWT를 검증한 후, 사용자 인증 정보를 생성하고, 이를 SecurityContextHolder에 저장합니다.
 * 이후 요청 흐름 내에서 이 저장된 정보를 다른 보안 관련 작업에 재사용하구요.(컨트롤러에서 불러와서 model로 JSP에 전달 )
 * 요청이 완료되고 필터 체인이 종료될 때, SecurityContextHolder의 정보를 초기화 합니다.
 * */
