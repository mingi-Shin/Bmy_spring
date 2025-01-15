package kr.mingi.config;

import java.util.Collections;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import jakarta.servlet.http.HttpServletRequest;
import kr.mingi.filter.CustomLoginFilter;
import kr.mingi.jwt.JWTFilter;
import kr.mingi.jwt.JWTUtil;
import kr.mingi.service.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

	//AuthenticationManager가 인자로 받을 AuthenticationConfiguraion 객체를 생성자 주입
	private final AuthenticationConfiguration authenticationConfiguration;
	private final JWTUtil jwtUtil;
	
	public SecurityConfiguration(AuthenticationConfiguration authenticationConfiguration, JWTUtil jwtUtil) {
		
		this.authenticationConfiguration = authenticationConfiguration;
		this.jwtUtil = jwtUtil;
	}
	
    //AuthenticationManager Bean 등록
	@Bean
	public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
		
		return authenticationConfiguration.getAuthenticationManager();
	}
	
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		
		//csrf disable
		http
			.csrf((auth) -> auth.disable());
		http
			.formLogin((auth) -> auth.disable());
		http
			.httpBasic((auth) -> auth.disable());
		
		//http.httpBasic(); // HTTP 헤더에 사용자 이름과 비밀번호를 포함한 인증 요청을 요구하는 방식
		
        http
        	.authorizeHttpRequests((auth) -> auth
        		.requestMatchers("/", "/login", "/join", "/error").permitAll()
        		.requestMatchers("/admin").hasRole("ADMIN")
        		.anyRequest().authenticated()
        		);
        
        
        //JWTFilter 등록 : login 앞에 실행
        http
        	.addFilterBefore(new JWTFilter(jwtUtil), CustomLoginFilter.class);
        
        //CustomLoginFilter 로 UsernamePasswordAuthenticationFilter를 대체한다.
        //	: CustomLoginFilter()는 매개변수로 AuthenticationManager 객체를 받음 -> Manager는 authenticationConfiguration 을 인자로 받음
        http
    		.addFilterAt(new CustomLoginFilter(authenticationManager(authenticationConfiguration), jwtUtil), UsernamePasswordAuthenticationFilter.class);
        
        //세션 설정: JWT를 통한 인증/인가를 위해서 세션을 STATELESS 상태로 설정하는 것
        http
    		.sessionManagement((session) -> session
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS)); // 세션 정책 확인
		
        //CORS = 프론트엔드 도메인과 통신  할 때 사용. (React 등 port가 다를떄 )
        http
        	.cors((corsCustomizer -> corsCustomizer.configurationSource(new CorsConfigurationSource() {
				
				@Override
				public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {

					CorsConfiguration configuration = new CorsConfiguration();
					configuration.setAllowedOrigins(Collections.singletonList("http://localhost:3000")); //허용할 프론트엔드 포트 
					configuration.setAllowedMethods(Collections.singletonList("*")); 			// 모든 메서드 허용
                    configuration.setAllowCredentials(true);									// 쿠키, 인증 관련 정보 허용
                    configuration.setAllowedHeaders(Collections.singletonList("*"));			// 모든 요청 헤더 허용
                    configuration.setExposedHeaders(Collections.singletonList("Authorization"));// 클라이언트에 노출할 응답 헤더 설정
                    configuration.setMaxAge(3600L);												// 1시간 동안 Preflight 요청 결과 캐싱
					
                    
                    return configuration;
				}
			})));
        
		return http.build();
	}
	
}
