package kr.mingi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
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
@EnableWebSecurity(debug = true) //시큐리티 필터 추가할거야 선언  (debug는 서비스할 땐 삭제해)
@EnableGlobalMethodSecurity(prePostEnabled = true) // 메소드에 보안을 활성화.
public class SecurityConfig {
	
	@Bean
	public UserDetailsService memberUserDetailsService() { //AuthenticationManager에서 사용
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
        AuthenticationManagerBuilder authenticationManagerBuilder = http.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder.userDetailsService(memberUserDetailsService()).passwordEncoder(passwordEncoder());
        return authenticationManagerBuilder.build();
    }
    
    
    //나만의 커스텀 SecurityFilterChain 생성(@Bean) = @EnableWebSecurity가 있을 때만 활성화
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		
		// CSRF필터보다 먼저 문자인코딩을 강제(항상)처리 
		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");
		characterEncodingFilter.setForceEncoding(true);
		http.addFilterBefore(characterEncodingFilter, CsrfFilter.class); // CsrfFilter 이전에 CharacterEncodingFilter 추가
		
		//요청에 따른 권한을 확인하여 서비스 호출||제한 
		http
			.csrf()
				//.ignoringAntMatchers("/member/memUpdate.do") //업로드 요청에 대해서만 CSRF 예외 처리 -> 권장되지 않음 
			.and()
	        .authorizeRequests()
		        .antMatchers(HttpMethod.POST, "/synchBoard/register").hasRole("WRITE")
		        .antMatchers(HttpMethod.POST, "/asynchBoard/board/new").hasRole("WRITE")
	        	.antMatchers("/member/memImageForm.do").authenticated() //이미지업로드 페이지 접근제한
		        .antMatchers("/synchBoard/*").authenticated()
		        .antMatchers("/asynchBoard/*").authenticated()
	        	.anyRequest().permitAll() // 모든 요청을 허용: 맨밑 위치 
	        .and()
		    .formLogin()
		        .loginPage("/member/memLoginForm.do")
		        .loginProcessingUrl("/memLogin.do")
		        .failureUrl("/member/memLoginForm.do?error=true")
		        .permitAll()
		        .and()
		    .logout()
		        .invalidateHttpSession(true)
		        .logoutSuccessUrl("/")
		        .and()
		    .exceptionHandling()
		        .accessDeniedPage("/m019/access-denied");
	        //.and()
				
		
		return http.build(); // 새로운 방식으로 SecurityFilterChain을 빌드하여 반환
	}
	
	 
	@Bean
	public SecurityFilterChain customFilterChain2(HttpSecurity http) throws Exception {
		// 하나더 만들고 싶다면.. 
		
		return http.build();
	}
    
	
}
/**
 * 	https://www.devyummi.com/page?id=66969cd412b680b5762f67d5 -> SecurityFilterChain 등록 방법 
 * 
  	시큐리티 5.4이상부터는 
  	WebSecurityConfigurerAdapter를 사용하지 않고, 대신 SecurityFilterChain을 정의하여 보안 구성
  	또한, AuthenticationManagerBuilder는 별도로 관리할 수 있도록 구성
*/
/**
 	시큐리티 5.4 이하 버전: 
 	WebSecurityConfigurerAdapter클래스를 상속하여 SecurityConfig객체를 생성한다.
	- @EnableWebSecurity는 스프링 시큐리티(Web Security)를 활성화하는 어노테이션입니다.
	- configure() 메서드를 Override하고 관련 설정을 한다.
*/
/**
  	시큐리티로 로그인/로그아웃을 처리하면
  	mapper까지 기입 안해도 된다. 
  	mapper에 기입할땐 커스텀인증을 내가 직접 만들때이다. 
*/
/**
	@EnableGlobalMethodSecurity(prePostEnabled = true)
	Controller의 메서드에 보안을 설정할 수 있게된다.
	예)
	@PreAuthorize("hasRole('ADMIN')")
	public void someAdminMethod() {
	    // 관리자만 접근할 수 있는 메소드
	}
	
    @PreAuthorize("hasRole('USER') and #userId == authentication.name")
    @GetMapping("/user/{userId}")
    public String getUserData(@PathVariable String userId) {
        return "User data for " + userId;
    }
    
*/


