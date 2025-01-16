package kr.bit.jwt;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.nimbusds.jose.util.StandardCharset;

import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;

@Component
public class JWTUtil {
	
	private SecretKey secretKey;
	
	public JWTUtil(@Value("${spring.jwt.mysecret}")String secret) {
		
		secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
	}
	
	public String getUsername(String token) { //JWT 넣어서 이름뽑기()

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
	
    public Boolean isExpired(String token) { //JWT 토큰 만료 여부 
		
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
        
    	try {
            return Jwts.builder()  // 빌더를 통해 JWT의 클레임(Claims), 헤더(Header), 서명(Signature)을 구성
                    .claim("username", username)  // JWT의 Custom Claim(사용자 정의 클레임)을 추가 (키 : 값)
                    .claim("role", role)         
                    .issuedAt(new Date(System.currentTimeMillis()))  // 토큰의 발급 시간(iat, issued at) 설정
                    .expiration(new Date(System.currentTimeMillis() + expiredMs))  // JWT의 만료 시간(exp, expiration) 설정
                    .signWith(secretKey)  // 입력된 암호화 키(secretKey)를 사용해 JWT의 서명을 생성
                    .compact();  // 최종적으로 JWT를 문자열로 압축하여 반환
        } catch (Exception e) {
            // 예외 처리 (로그 기록, 재처리 등)
            e.printStackTrace();
            throw new RuntimeException("JWT 생성 실패", e);  // 예외 발생 시 RuntimeException 던짐
        }
    }

	
	
	
	
	

}

