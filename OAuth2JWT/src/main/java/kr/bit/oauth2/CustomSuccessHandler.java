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
	 
	//로그인 성공시 아래 메서드 동작 
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		
		//OAuth2User (Service에서 return한 사용자 정보. authentication의 principal로 저장되어 있음)
		CustomOAuth2User customUserDetails = (CustomOAuth2User) authentication.getPrincipal();
	    System.out.println("User Info: " + customUserDetails);

		//getUsername()은 CustomOAuth2User클래스에만 있기에 형변환
		String username = customUserDetails.getUsername();
		
		Collection<? extends GrantedAuthority> authorities = customUserDetails.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		String role = auth.getAuthority();
		
		//위에서 가져온 정보들로 JWT 생성 
		String JWToken = jwtUtil.createJwt(username, role, username,  60*60*60L);
		
		//JWT를 쿠키에 담기 
		response.addCookie(createCookie("Authorization", JWToken));
		
		// 3000포트로 보내기(FrontEnd)
        response.sendRedirect("http://localhost:3000/");

	}
	
	
	//쿠키생성 메서드
	private Cookie createCookie(String key, String value) {
	
		Cookie cookie = new Cookie(key, value);
		cookie.setMaxAge(60*30); //30분 
		//cookie.setSecure(true); //HTTPS 에서만 쿠키가 전송
		cookie.setPath("/"); //모든 경로에서 쿠키를 전송 
		cookie.setHttpOnly(true); // 스크립트로 접근 불가 
		
		return cookie;
		
	}
	
	
}

/*
 *	Authentication 객체 내부에는 -
 *	- principal : 인증된 사용자의 정보(CustomOAuth2User 객체가 들어감)
 *	- Authorities : 사용자의 권한(Role)정보
 *	- Details : 기타 요청 정보를 담을 수 있는 객체 
 * 
 * */
