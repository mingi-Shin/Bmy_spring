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
		
		System.out.println("CustomSuccessHandler_onAuthenticationSuccess()_authentication : " + authentication);
				
		//OAuth2 User
		CustomOAuth2User customUserDetails = (CustomOAuth2User) authentication.getPrincipal(); //getUsername()은 CustomOAuth2User클래스에만 있기에 형변환 
		String username = customUserDetails.getUsername();
		String name = customUserDetails.getName();
		
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		String role = auth.getAuthority();
		
		//더 많은 정보를 담고싶다면 principal에서 더 가져와 
		String token = jwtUtil.createJwt(username, role, name, 60*60*1000L);
		
		response.addCookie(createCookie("Authorization", token));
		response.sendRedirect("http://localhost:8082/");
				
	}
	
	//내부에서 쓸 쿠키생성 메서드
	private Cookie createCookie(String key, String value) {
		
		Cookie cookie = new Cookie(key, value);
		
		cookie.setMaxAge(60*60*60); // 60시간짜리  
		//cookie.setSecure(true); //HTTPS 에서만 쿠키가 전송
		cookie.setPath("/");
		cookie.setHttpOnly(true); // 스크립트로 접근 불가 
		
		return cookie;
	}
	
	
}
/**
 * 	OAuth2 로그인 성공시 JWT발급하는 클래스
 * 
 * 	GrantedAuthority 는 ROLE(권한)을 담당하는 인터페이스
 * 
 * 	클라이언트에서 동작하는 기능(흑/백, 영어/한국어 등의 서비스)는
 * 	클라이언트가 쿠키 값을 가져와 자바스크립트에서 실행시키기 때문에
 * 	HttpOnly설정을 하면 동작하지 않음에 주의하자. 
 * 	(개발자도구 console.log(document.cookie); 로 읽을 수 있게된다. 
 * 
 * */
