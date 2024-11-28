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
		
		//http.csrf().disable(); //CSRF 토큰 검사를 비활성화 -> 기존의 절차적 스타일
		http.csrf(csrf -> csrf.disable()); //-> security6.1 부터 권장되는 빌더 스타일
		
		/**
		http.authorizeHttpRequests()
			.requestMatchers("/", "/member/**", "/error").permitAll()
			.requestMatchers("/board/**").permitAll()
			.and()
			.formLogin()
			.loginPage("/member/login")
			.defaultSuccessUrl("/board/list")
			.and()
			.logout()
			.logoutUrl("/member/logout")
			.logoutSuccessUrl("/list");
		http.userDetailsService(userDetailServiceImpl);
		*/
		
		return http.build();
	}
	
}


/**
 * 		람다식 표현 해석:
 * 		http.csrf()가 호출되면서 CSRF 설정 객체(CsrfConfigurer)가 반환됨.
		반환된 CsrfConfigurer 객체를 람다식의 매개변수로 전달하며, 그 이름을 csrf라고 지정.
		람다식 내부에서 csrf.disable()을 호출하여 CSRF 보호 기능을 끔.

 * 
 * 
 * */
