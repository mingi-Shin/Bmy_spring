  package kr.mingi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.mingi.security.MemberUserDetailsService;

// Spring Security : WebSecurityConfigurerAdapter를 확장하여 Spring Security의 기본 보안 기능을 커스터마이즈 
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Bean
	public UserDetailsService memberUserDetailsService() {
		return new MemberUserDetailsService();
	}
	
	//비밀번호 인코딩 객체 설정 
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder authBuilder) throws Exception{
		authBuilder.userDetailsService(memberUserDetailsService()).passwordEncoder(passwordEncoder());
		System.out.println("인증매니저 시작");
	}
	

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//요청에 대한 보안 설정 
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter, CsrfFilter.class);
		
		//요청에 따른 권한을 확인하여 서비스 호출||제한 
		http
			.authorizeRequests() //어플리케이션의 각 요청에 대해 접근 권한을 설정 
				.antMatchers("/").permitAll() //root는 특별한 권한없이 모두 허용 
				.antMatchers("/getMemberList.do").hasRole("ADMIN")
				.and()
			.formLogin()
				.loginPage("/memLoginForm.do")
				//.loginProcessingUrl("/memLogin.do")
				.loginProcessingUrl("/authenticateTheUser") //mvc06 추가: 인증처리필터 호출 
				.permitAll() //쓰지 않으면 기본값으로 접근제한..  
				.and()
			.logout()
				.invalidateHttpSession(true)
				.logoutSuccessUrl("/")
				.and()
			.exceptionHandling().accessDeniedPage("/access-denied");
		
	}
	
	
	
}

/*
 	WebSecurityConfigurerAdapter클래스를 상속하여 SecurityConfig객체를 생성한다.
	- @EnableWebSecurity는 스프링MVC와 스프링 시큐리티를 결합하는 클래스이다.
	- configure() 메서드를 Override하고 관련 설정을 한다.
 * */
