package kr.bit.service;

import org.springframework.stereotype.Service;

import io.jsonwebtoken.ExpiredJwtException;
import kr.bit.jwt.JWTUtil;

@Service
public class TokenService {

	private final JWTUtil jwtUtil;
	
	public TokenService(JWTUtil jwtUtil) {
		this.jwtUtil = jwtUtil;
	}
	
	public String reissueAccessToken(String refreshToken) {
		
		// 1.토큰만료체크
		if(jwtUtil.isExpired(refreshToken)) {
			
			throw new RuntimeException("Refresh token expired");
		} 
		
		
		return null;
	}
	
}
