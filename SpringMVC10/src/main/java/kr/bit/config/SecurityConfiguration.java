package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfiguration {

	@Autowired
	private UserDetailsServiceImpl userDetailServiceImpl;

    @Bean
    public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder(); 
	}

	@Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        
        // CSRF 토큰 검사를 비활성화
    	http.csrf().disable();

    	// 경로별 접근 권한 설정
    	
    	http.authorizeHttpRequests()
    		.requestMatchers("/", "/member/**", "/error", "/WEB-INF/**").permitAll()
            .requestMatchers("/resources/**", "/css/**", "/js/**", "/images/**").permitAll()  // 정적 리소스 경로 추가
    		.requestMatchers("/board/**").authenticated()  
    		
    	.and()
        // 로그인 설정
    	.formLogin()
    	.loginPage("/member/login")
    	.loginProcessingUrl("/member/login")
    	.defaultSuccessUrl("/board/list")
        
    	.and()
        // 로그아웃 설정
    	.logout()
    	.logoutUrl("/member/logout")
    	.logoutSuccessUrl("/");

        // 사용자 세부 정보 서비스 설정 (사용자 인증 정보를 제공하는 서비스)
        http.userDetailsService(userDetailServiceImpl);


        return http.build();
    }
}

/**
 * 		람다식 표현 해석:
 * 		http.csrf()가 호출되면서 CSRF 설정 객체(CsrfConfigurer)가 반환됨.
		반환된 CsrfConfigurer 객체를 람다식의 매개변수로 전달하며, 그 이름을 csrf라고 지정.
		람다식 내부에서 csrf.disable()을 호출하여 CSRF 보호 기능을 끔.


		authorizeReqeust : 5버전 
		authorizeHttpRequest : 6버전대 (뷰페이지 호출도 권한 검색..주의!)
 * 
 * 
 * 		스프링 프레임워크에서는 WebSecurityConfigurerAdapter 클래스를 상속하여 configure(HttpSecurity http) 메서드를 오버라이드해야 합니다. 
 * 		이 클래스는 보안 설정을 커스터마이징하기 위한 기반 클래스로 사용됩니다.
 *      반면, 스프링 부트에서는 SecurityFilterChain 빈을 정의하는 방식으로 설정을 진행할 수 있습니다.
 * 
 * 
 * 		 **스프링 부트 3 이상(또는 스프링 시큐리티 5.7 이상)**부터는 
 * 		@EnableWebSecurity 어노테이션을 명시적으로 추가하지 않아도, 
 * 		SecurityFilterChain 빈을 정의하면 Spring Security 필터가 자동으로 활성화
 * 
 * 
 * */


