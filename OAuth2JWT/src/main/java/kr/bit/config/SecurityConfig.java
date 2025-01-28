package kr.bit.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.oauth2.client.OAuth2LoginConfigurer.UserInfoEndpointConfig;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import kr.bit.jwt.JWTFilter;
import kr.bit.jwt.JWTUtil;
import kr.bit.oauth2.CustomSuccessHandler;
import kr.bit.service.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	private final CustomOAuth2UserService customOAuth2UserService;
	private final CustomSuccessHandler customSuccessHandler;
	private final JWTUtil jwtUtil;
	
	public SecurityConfig(CustomOAuth2UserService customOAuth2UserService, CustomSuccessHandler customSuccessHandler, JWTUtil jwtUtil) {
		
		this.customOAuth2UserService = customOAuth2UserService;
		this.customSuccessHandler = customSuccessHandler;
		this.jwtUtil = jwtUtil;
	}
	
	
	@Bean
	public SecurityFilterChain filterChain (HttpSecurity http) throws Exception{
		
        //csrf disable : JWT(stateless이므로 비활성화)
        http
            .csrf((auth) -> auth.disable());

        //Form 로그인 방식 disable
        http
            .formLogin((auth) -> auth.disable());

        //HTTP Basic 인증 방식 disable
        http
            .httpBasic((auth) -> auth.disable());

        //JWTFilter 추가
        http
        .addFilterBefore(new JWTFilter(jwtUtil), UsernamePasswordAuthenticationFilter.class);
        
        
        //https://www.youtube.com/watch?v=9g_iN6rLQcQ&t=1s&ab_channel=%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9C%A0%EB%AF%B8 
        // 댓글 보고 추가 수정 
        
        
        //oauth2
        http
            //.oauth2Login(Customizer.withDefaults());
        	.oauth2Login((oauth2) -> oauth2
        		.userInfoEndpoint((userInfoEndpointConfig) -> userInfoEndpointConfig
    				.userService(customOAuth2UserService)
				)
        		.successHandler(customSuccessHandler)
        		
    		);

        //경로별 인가 작업
        http
            .authorizeHttpRequests((auth) -> auth
                .requestMatchers("/").permitAll()
                .anyRequest().authenticated());

        //세션 설정 : STATELESS
        http
            .sessionManagement((session) -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS));
		
		return http.build();
	}
	
}
