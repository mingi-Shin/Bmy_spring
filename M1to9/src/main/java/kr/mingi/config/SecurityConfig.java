package kr.mingi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.mingi.security.MemberUserDetailsService;

// Spring Security : WebSecurityConfigurerAdapter를 확장하여 Spring Security의 기본 보안 기능을 커스터마이즈 
@Configuration
@EnableWebSecurity //시큐리티 필터 추가할거야 선언 
@EnableGlobalMethodSecurity(prePostEnabled = true) // 메소드 수준의 보안 활성화
public class SecurityConfig {
	
	@Bean
	public UserDetailsService memberUserDetailsService() {
		return new MemberUserDetailsService();
	}
	
	//비밀번호 인코딩 객체 설정 
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	// AuthenticationManager 설정
    @Bean
    public AuthenticationManager authManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder = 
            http.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder.userDetailsService(memberUserDetailsService())
            .passwordEncoder(passwordEncoder());
        return authenticationManagerBuilder.build();
    }
    
    
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		
		// CSRF필터보다 먼저 문자인코딩을 강제(항상)처리 
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class); // CsrfFilter 이전에 CharacterEncodingFilter 추가
		
		//요청에 따른 권한을 확인하여 서비스 호출||제한 
		http
			.authorizeRequests() //어플리케이션의 각 요청에 대해 접근 권한을 설정 
				.antMatchers("/").permitAll() //root는 특별한 권한없이 모두 허용 
				.antMatchers("/getMemberList.do").hasRole("ADMIN")
				.antMatchers("/boardMain.do").authenticated()
				.and()
			.formLogin()
				.loginPage("/member/memLoginForm.do") //맵핑 주의! 
				.loginProcessingUrl("/memLogin.do") //mvc06 추가: 인증처리필터 호출 
				.permitAll() //쓰지 않으면 기본값으로 접근제한..  
				.and()
			.logout()
				.invalidateHttpSession(true)
				.logoutSuccessUrl("/")
				.and()
			.exceptionHandling().accessDeniedPage("/access-denied");
		
		return http.build(); // 새로운 방식으로 SecurityFilterChain을 빌드하여 반환
	}
    
	
	
}
/**
  	시큐리티 5.4?7?이상부터는 
  	WebSecurityConfigurerAdapter를 사용하지 않고, 대신 SecurityFilterChain을 정의하여 보안 구성
  	또한, AuthenticationManagerBuilder는 별도로 관리할 수 있도록 구성
*/
/*
 	WebSecurityConfigurerAdapter클래스를 상속하여 SecurityConfig객체를 생성한다.
	- @EnableWebSecurity는 스프링MVC와 스프링 시큐리티를 결합하는 클래스이다.
	- configure() 메서드를 Override하고 관련 설정을 한다.
 * */
