package kr.mingi.config;

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


import kr.mingi.filter.CustomLoginFilter;
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
	
	public SecurityConfiguration(AuthenticationConfiguration authenticationConfiguration) {
		
		this.authenticationConfiguration = authenticationConfiguration;
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
        
        //CustomLoginFilter 로 UsernamePasswordAuthenticationFilter를 대체한다.
        //	: CustomLoginFilter()는 매개변수로 AuthenticationManager 객체를 받음 -> Manager는 authenticationConfiguration 을 인자로 받음
        http
    		.addFilterAt(new CustomLoginFilter(authenticationManager(authenticationConfiguration)), UsernamePasswordAuthenticationFilter.class);
        
        //세션 설정: JWT를 통한 인증/인가를 위해서 세션을 STATELESS 상태로 설정하는 것
        http
    		.sessionManagement((session) -> session
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS)); // 세션 정책 확인
		
		return http.build();
	}
	
}
