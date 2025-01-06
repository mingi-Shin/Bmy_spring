package kr.mingi.jwt;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.config.annotation.rsocket.RSocketSecurity.JwtSpec;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;

@Component
public class JWTUtil {
	
	private final SecretKey secretKey; //암호화키 객체 

	// properties에서 가져온 내 암호화 문장: mysecret 
	public JWTUtil(@Value("${spring.jwt.mysecret}")String mysecret) {
		
		System.out.println("나만의 시크릿 주주: " + mysecret);
		this.secretKey = new SecretKeySpec(
				mysecret.getBytes(StandardCharsets.UTF_8) 		// UTF-8 형식의 바이트 배열로 변환
				, Jwts.SIG.HS256.key().build().getAlgorithm()	// Jwts의 SIG 객체에서, 서명 알고리즘으로 HS256을 지정
				);												// key() 호출로 반환된 키 빌더를 완성하고, getAlgorithm() 메서드를 호출하여 알고리즘 이름(예: "HmacSHA256")을 가져옵니다.
		
	}
	
	public String getUsername(String token) {

		try {
		    return Jwts.parser()						// 파서(parser)를 생성
		               .verifyWith(secretKey)			// 서명 검증
		               .build()							// 빌더를 완성
		               .parseSignedClaims(token)		// 서명을 검증한 뒤 JWT의 본문(Claims)을 파싱
		               .getPayload()					// 파싱된 클레임 데이터에서 페이로드 부분(실제 데이터를 담고 있는 JSON)을 반환
		               .get("username", String.class);	// JSON 클레임 중 "username"이라는 키에 해당하는 값을 추출
		} catch (JwtException e) {
			e.printStackTrace();
		    throw new IllegalArgumentException("Invalid JWT token", e);
		}	
	}
	
	public String getRole(String token) {
		
		try {
			return Jwts.parser()
						.verifyWith(secretKey)
						.build()
						.parseSignedClaims(token)
						.getPayload()
						.get("role", String.class);
		} catch (JwtException e) {
			e.printStackTrace();
			throw new IllegalArgumentException("Invalid JWT token", e);
		}
		
	}
	
    public Boolean isExpired(String token) {
		
    	try {
			return Jwts.parser()
						.verifyWith(secretKey)
						.build()
						.parseSignedClaims(token)
						.getPayload()
						.getExpiration().before(new Date());
		} catch (JwtException e) {
			e.printStackTrace();
			throw new IllegalArgumentException("Invalid JWT token", e);
		}
    }
    
    public String createJwt(String username, String role, Long expiredMs) {
    	
    	return Jwts.builder()													// 빌더를 통해 JWT의 클레임(Claims), 헤더(Header), 서명(Signature)을 구성이나
    			.claim("username", username)									// JWT의 Custom Claim(사용자 정의 클레임)을 추가 (키 : 값) : 클레임은 JWT 페이로드의 JSON 데이터로 저장
    			.claim("role", role)		
    			.issuedAt(new Date(System.currentTimeMillis()))					// 토큰의 발급 시간(iat, issued at) = 생성 시점을 설정    			
    			.expiration(new Date(System.currentTimeMillis() + expiredMs))   // JWT의 만료 시간(exp, expiration)을 설정 (만료 기간(expiredMs)만큼 더한 값)
    			.signWith(secretKey)											// 입력된 암호화 키(secretKey)를 사용해  JWT의 서명을 생성
    			.compact();														// 최종적으로 JWT를 문자열로 압축(Serialization)하여 반환
    	
    }

	
}
