package kr.bit.oauth2;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.io.IOException;
import jakarta.servlet.ServletException;
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
		
		//OAuth2User (Service에서 return한 값. authentication의 principal로 저장되어 있음)
		CustomOAuth2User customUserDetails = (CustomOAuth2User) authentication.getPrincipal();
	    System.out.println("User Info: " + customUserDetails);

		//getUsername()은 CustomOAuth2User클래스에만 있기에 형변환
		
	    
	    https://www.devyummi.com/page?id=66936efad148f039dce569bd
	    	https://www.youtube.com/watch?v=s6D_zXnrXNo&ab_channel=%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9C%A0%EB%AF%B8
	}
	
	
}
