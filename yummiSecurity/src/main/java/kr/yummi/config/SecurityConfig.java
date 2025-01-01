package kr.yummi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import kr.yummi.jwt.CustomLoginFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//AuthenticationManager가 인자로 받을 AuthenticationConfiguraion 객체 생성자 주입
    private final AuthenticationConfiguration authenticationConfiguration;
    public SecurityConfig(AuthenticationConfiguration authenticationConfiguration) {

        this.authenticationConfiguration = authenticationConfiguration;
    }
    
    //AuthenticationManager Bean 등록
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {

        return configuration.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

    	//csrf disable
        http
            .csrf((auth) -> auth.disable());

		//From 로그인 방식 disable : 해당필터 비활성 
        http
            .formLogin((auth) -> auth.disable());

		//http basic 인증 방식 disable
        http
           .httpBasic((auth) -> auth.disable());
        
        //..대신에 커스텀 login 필터 등록
        //필터 추가 CustomLoginFilter()는 인자를 받음 = (AuthenticationManager() 메소드에 authenticationConfiguration 객체를 넣어야 함) 따라서 등록 필요
        http
        	.addFilterBefore(new CustomLoginFilter(authenticationManager(authenticationConfiguration)), UsernamePasswordAuthenticationFilter.class);
        

		//경로별 인가 작업
        http
        	.authorizeHttpRequests((auth) -> auth
                .requestMatchers("/", "/login", "/join").permitAll()
                .requestMatchers("/", "/index.html", "/static/**", "/css/**", "/js/**").permitAll()
				.requestMatchers("/admin").hasRole("ADMIN")
                .anyRequest().authenticated()
            );

		//세션 설정: JWT를 통한 인증/인가를 위해서 세션을 STATELESS 상태로 설정하는 것
        http
            .sessionManagement((session) -> session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        return http.build();
    }
}

