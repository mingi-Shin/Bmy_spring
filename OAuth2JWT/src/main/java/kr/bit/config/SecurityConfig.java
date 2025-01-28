package kr.bit.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.oauth2.client.OAuth2LoginConfigurer.UserInfoEndpointConfig;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

import kr.bit.oauth2.CustomSuccessHandler;
import kr.bit.service.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	private final CustomOAuth2UserService customOAuth2UserService;
	private final CustomSuccessHandler customSuccessHandler;
	
	public SecurityConfig(CustomOAuth2UserService customOAuth2UserService, CustomSuccessHandler customSuccessHandler) {
		
		this.customOAuth2UserService = customOAuth2UserService;
		this.customSuccessHandler = customSuccessHandler;
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
