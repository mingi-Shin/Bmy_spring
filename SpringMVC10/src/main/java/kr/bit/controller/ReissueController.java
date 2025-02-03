package kr.bit.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.bit.jwt.JWTUtil;

/**
 * 서버측 JWTFilter에서 Access 토큰의 만료로 인한 특정한 상태 코드가 응답되면 프론트측 Axios Interceptor와 같은 예외 핸들러에서 
 * Access 토큰 재발급을 위한 Refresh을 서버측으로 전송한다.
 * 이때 서버에서는 Refresh 토큰을 받아 새로운 Access 토큰을 응답하는 코드를 작성하면 된다.
 * 
 * */
@Controller
@ResponseBody
public class ReissueController {

	private final JWTUtil jwtUtil;
	
	public ReissueController(JWTUtil jwtUtil) {
		
		this.jwtUtil = jwtUtil;
	}
	
	@PostMapping("/reissue")
	public ResponseEntity<?> reissue (HttpServletRequest request, HttpServletResponse response){
		
        //get refresh token
		String refresh = null;
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			
			if(cookie.getName().equals("refresh")) {
				
				refresh = cookie.getValue();
			}
		}
		
		if(refresh == null) {
			
            //response status code
            return new ResponseEntity<>("refresh token null", HttpStatus.BAD_REQUEST);
		}
		
        //expired check
		try {
			jwtUtil.isExpired(refresh);
		} catch (Exception e) {
			
			
		}
		
		return null;
		
	}
	
}
