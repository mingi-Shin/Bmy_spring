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
		//getUsername()은 CustomOAuth2User클래스에만 있기에 형변환
		CustomOAuth2User customUserDetails = (CustomOAuth2User) authentication.getPrincipal(); 
	    System.out.println("핸들러: authentication.getPrincipal(): " + customUserDetails);
		String username = customUserDetails.getUsername();
		String name = customUserDetails.getName();
		
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		String role = auth.getAuthority();
		
		//위에서 가져온 정보들로 JWT 생성 
		String JWToken = jwtUtil.createJwt(username, role, name, 60*60*1000L); // JWT는 1시간짜리 
		System.out.println("핸들러에서 쿠키 생성: " + JWToken);
		
		response.addCookie(createCookie("Authorization", JWToken));
		
		response.sendRedirect("/boot"); // mapping("/")으로 ㄱㄱ
		// react사용시 3000포트로 보내기
		// response.sendRedirect("http://localhost:3000/");
	}
	
	//내부에서 쓸 쿠키생성 메서드
	private Cookie createCookie(String key, String value) {
		
		Cookie cookie = new Cookie(key, value);
		
		cookie.setMaxAge(60*60*2); // 쿠키 2시간짜리  
		cookie.setSecure(false); //HTTPS 에서만 쿠키가 전송 : 개발환경에서는 false 
		cookie.setPath("/"); //모든 경로에서 쿠키를 전송 
		cookie.setHttpOnly(true); // 스크립트로 접근 불가 
		
		return cookie;
	}
	
	
}
/**
 * 	이것은 OAuth2 로그인 성공시 JWT발급하는 클래스
 * 
 * 	GrantedAuthority 는 ROLE(권한)을 담당하는 인터페이스
 * 
 * 	클라이언트에서 동작하는 기능(흑/백, 영어/한국어 등의 서비스)는
 * 	클라이언트가 쿠키 값을 가져와 자바스크립트에서 실행시키기 때문에
 * 	HttpOnly설정을 하면 동작하지 않음에 주의하자. 
 * 	(개발자도구 console.log(document.cookie); 로 읽을 수 있게된다. 
 * 
 * 	쿠키시간을 JWT보다 길게 가져가 리프레시 토큰을 활용하기!
 * 	
 *	-- 토큰 저장 위치( https://www.devyummi.com/page?id=669514be59f57d23e8a0b6a9 ) --
 * 	Access 토큰  : 로컬 스토리지(localStorage, sessionStorage, Memory ) 	: XSS 공격에 취약 
 * 	Refresh 토큰 : HttpOnly 쿠키 (or DB, Redis 등) 					: CSRF 공격에 취약 
 * 	
 * 	-- Refresh 토큰 탈취에 대비하는 방법: Refresh Rotate
 * 		발급시 : Refresh 토큰을 서버측 저장소에 저장
 * 		갱신시 : 기존 Refresh 토큰을 삭제하고, 새로 발급한 Refresh를 저장 
 * 
 *  -- 로그아웃시 Refresh 토큰을 죽이는데, Access토큰이 만료시간이 남은 시점에서 탈취당하면 방법이 없으므로.. 최대한 만료시간을 짧게 주는 수밖에 없다.
 *  	Access토큰을 서버에 저장하면 관리는 가능하지만 stateless 한 정책에 어긋나고, 서버에 부담이 가므로 추천하지는 않는다..? 
 *  
 * 
 * */
