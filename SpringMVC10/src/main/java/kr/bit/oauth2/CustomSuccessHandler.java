package kr.bit.oauth2;

import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.bit.DTO.CustomOAuth2User;
import kr.bit.jwt.JWTUtil;

@Component
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	private final JWTUtil jwtUtil;
	
	public CustomSuccessHandler(JWTUtil jwtUtil) {
		this.jwtUtil = jwtUtil;
	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		
		//OAuth2 User
		CustomOAuth2User customUserDetails = (CustomOAuth2User) authentication.getPrincipal();
		
		String username = customUserDetails.getUsername();
		
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		String role = auth.getAuthority();
		
		String token = jwtUtil.createJwt(username, role, 60*60*1000L);
		
		response.addCookie(createCookie("Authorization", token));
		response.sendRedirect("http://localhost:8082/");
				
	}
	//내부에서 쓸 쿠키생성 메서드
	private Cookie createCookie(String key, String value) {
		
		Cookie cookie = new Cookie(key, value);
		
		cookie.setMaxAge(60*60*60);
		//cookie.setSecure(true);
		cookie.setPath("/");
		cookie.setHttpOnly(true);
		
		return cookie;
	}
	
	
}
/**
 * 	로그인성공 JWT발급 클래스.
 * 
 * 	GrantedAuthority 는 ROLE(권한)을 담당하는 인터페이스
 * 
 * 
 * */
