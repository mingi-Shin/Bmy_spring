package kr.bit.jwt;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import io.jsonwebtoken.ExpiredJwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.bit.entity.CustomUser;
import kr.bit.entity.Member;
import kr.bit.entity.Role;

//JWTFilter의 역할 = 쿠키 검증 -> 세션저장 
// access 토큰과 refresh 토큰 모두 발급하는 JWTFilter 작성 

public class JWTFilter extends OncePerRequestFilter {
	
	private final JWTUtil jwtUtil;
	
	public JWTFilter (JWTUtil jwtUtil) {
		
		this.jwtUtil = jwtUtil;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		// 헤더에서 Authorization키에 담긴 토큰을 꺼냄 
		String accessToken = request.getHeader("Authorization");
		
		// 토큰이 없다면 다음 필터로 넘김 
		if(accessToken == null) {
			
			filterChain.doFilter(request, response);
			
			return;
		}
		
		// 토큰 만료 여부 확인, 만료시 다음 필터로 넘기지 않음 
		try {
			jwtUtil.isExpired(accessToken);
		} catch (ExpiredJwtException e) {
			
			//response Body
			PrintWriter writer = response.getWriter(); // ??
			writer.print("Access token expired");
			
		    //response status code
		    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // ??
		    return;
		}
		
		// 토큰이 access인지 확인 (발급시 페이로드에 명시)
		String category = jwtUtil.getCategory(accessToken);
		
		if(!category.equals("access")) {
			
		    //response body
		    PrintWriter writer = response.getWriter();
		    writer.print("invalid access token");

		    //response status code
		    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		    return;
		}
		
		// username, role 값을 획득
		String username = jwtUtil.getUsername(accessToken);
		String role = jwtUtil.getRole(accessToken);
		
		Member member = new Member();
		member.setUsername(username);
		try {
		    Role roleEnum = Role.valueOf(role); //문자열을 Enum으로 변환하여 설정 
		    member.setRole(roleEnum);
		} catch (IllegalArgumentException e) {
		    throw new RuntimeException("Invalid role: " + role); // Role Enum에 없는 경우, 명확한 예외 메시지를 출력
		} 
		
		CustomUser customUser = new CustomUser(member);
		
		Authentication authToken = new UsernamePasswordAuthenticationToken(customUser, null, customUser.getAuthorities());
		
		SecurityContextHolder.getContext().setAuthentication(authToken);
		
		filterChain.doFilter(request, response);

	}

}
/**
 * 	https://www.devyummi.com/page?id=669516f159f57d23e8a0b6af
 * 
 */
