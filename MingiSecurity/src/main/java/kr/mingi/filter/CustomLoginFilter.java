package kr.mingi.filter;


import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.Iterator;

import org.hibernate.annotations.Filter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.util.StreamUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import io.jsonwebtoken.io.IOException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletInputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.mingi.DTO.CustomUserDetails;
import kr.mingi.DTO.LoginDTO;
import kr.mingi.jwt.JWTUtil;
import kr.mingi.service.CustomUserDetailsService;

public class CustomLoginFilter extends UsernamePasswordAuthenticationFilter {

	private final AuthenticationManager authenticationManager;
	private final JWTUtil jwtUtil;
	
	public CustomLoginFilter(AuthenticationManager authenticationManager, JWTUtil jwtUtil) {
		
		this.authenticationManager = authenticationManager;
		this.jwtUtil = jwtUtil;
	}
	
	// 1. 인증시도 메서드
	@Override
	public Authentication attemptAuthentication(HttpServletRequest req, HttpServletResponse res) throws AuthenticationException {
		
/**
		// 로그인 JSON요청으로 받기 : fetch, axios
		
		LoginDTO loginDTO = new LoginDTO();
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			ServletInputStream inputStream = req.getInputStream(); // HTTP 요청 본문의 내용을 바이트 단위로 읽어와 (JSON등)
			String messageBody = StreamUtils.copyToString(inputStream, StandardCharsets.UTF_8);
			loginDTO = objectMapper.readValue(messageBody, LoginDTO.class);
			
		} catch (IOException | java.io.IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		System.out.println("JSON 로그인 : " + loginDTO.getUsername());
		
		String username = loginDTO.getUsername();
		String password = loginDTO.getPassword();
*/
		 
		String username = obtainUsername(req);
		String password = obtainPassword(req);
		System.out.println("form 로그인 : " + username);

		// 2. 스프링시큐리티에서 username과 password를 검증하기 위해서는 Token에 담아줘야 합니다 ->
		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(username, password, null);
		System.out.println("토큰생성(username, password): " + authenticationToken);
		
		try {
			// 3. 토큰생성 후에는 UserDetailsService의 loadUserByUsername() 실행 
			// token에 담긴 정보를 검증하기 위해 AuthenticationManager의 authenticate()에게 token 전달
		    Authentication authentication = authenticationManager.authenticate(authenticationToken);
		    System.out.println("인증 성공: " + authentication);
		    System.out.println("권한: " + authentication.getAuthorities());
		    return authentication;
		} catch (AuthenticationException e) {
			e.printStackTrace(); //비밀번호가 문제였네??..
		    System.out.println("인증 실패: " + e.getMessage());
		    throw e;
		}
	}
	
	//로그인 성공시 실행 메서드 
	@Override 
	protected void successfulAuthentication(HttpServletRequest req, HttpServletResponse res, 
			FilterChain filterChain, Authentication authentication) {
		
		System.out.println("로그인 성공 -> authentication값: " + authentication);
		
		// 아래부터는 JWT 인증 코드 
		CustomUserDetails customUserDetails = (CustomUserDetails)authentication.getPrincipal();
		
		String username = customUserDetails.getUsername();
		
		// 아래 3개 코드 = 권한 빼내기. (코드 왜케 김??)
		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iterator = authorities.iterator();
		GrantedAuthority auth = iterator.next();
		// -> auth = authentication.getAuthorities().iterator().next();
		String role = auth.getAuthority();
		
		
		// JWT토큰 생성
		String jwtToken = jwtUtil.createJwt(username, role, 60*60*1000L); // Long이라서 L접두사 첨부, 1시간짜리 
		System.out.println("생성된 JWT 토큰: " + jwtToken);
		
		
		// HTTP 응답 헤더에 Authorization이라는 키와 값으로 Bearer <token> 형식을 설정
		res.addHeader("Authorization", "Bearer " + jwtToken); 
	}
	
	// 로그인 실패시 실행되는 메소드
	@Override
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException failed){
		
	    System.out.println("로그인 실패 : " + failed.getMessage());  // 실패 이유 출력
	    
		response.setStatus(401);
	}
	
}

/**
 * 	final은 참조가 변경될 수 없게 막는 역할만 하고 객체 내부의 값을 수정하는 것은 막지 않습니다. (내부 값을 final하고 set을 금지)
 * 
 * 	필드 주입 (책 빌려서 수정 가능): 책을 수정해서 누군가 다른 곳에서 그 책을 빌리면, 수정된 내용을 다시 보게됨.
 *
 *	생성자 주입 (책 고정): 책을 빌려서 수정할 수 없고, 고정된 내용대로 동작을 보장합니다.
 *
 * -------------------------------------------------------------------
 * 
 * 	Authorization =  HTTP 요청이나 응답에서 인증 관련 정보를 전달하는데 사용하는 표준 헤더 키
 *	Bearer는 인증 유형을 나타내며, 뒤에 오는 <token>은 실제 인증에 사용되는 토큰 값입니다.
 *
 * */
