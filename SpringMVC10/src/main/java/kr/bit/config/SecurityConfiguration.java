package kr.bit.config;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.web.OAuth2LoginAuthenticationFilter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import jakarta.servlet.http.HttpServletRequest;
import kr.bit.jwt.JWTFilter;
import kr.bit.jwt.JWTUtil;
import kr.bit.oauth2.CustomClientRegistrationRepo;
import kr.bit.oauth2.CustomOAuth2AuthorizedClientService;
import kr.bit.oauth2.CustomSuccessHandler;
import kr.bit.service.CustomOAuth2UserService;

@Configuration
public class SecurityConfiguration {
	
    @Bean
    public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder(); 
	}
/** 더 진보된 BCryptPasswordEncoder 암호화를 사용하자.
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
    	return new BCryptPasswordEncoder();
    }
*/
    
    private final CustomSuccessHandler customSuccessHandler;
    private final CustomOAuth2UserService customOAuth2UserService;
    private final UserDetailsServiceImpl userDetailServiceImpl;
    private final CustomClientRegistrationRepo customClientRegistrationRepo;
	private final CustomOAuth2AuthorizedClientService customOAuth2AuthorizedClientService;
	private final JdbcTemplate jdbcTemplate;
	private final JWTUtil jwtUtil;
    
    public SecurityConfiguration(CustomOAuth2UserService customOAuth2UserService, UserDetailsServiceImpl userDetailServiceImpl, CustomClientRegistrationRepo clientRegistrationRepo, CustomOAuth2AuthorizedClientService customOAuth2AuthorizedClientService, JdbcTemplate jdbcTemplate, CustomSuccessHandler customSuccessHandler, JWTUtil jwtUtil) {
    	this.customOAuth2UserService = customOAuth2UserService;
    	this.userDetailServiceImpl = userDetailServiceImpl;
    	this.customClientRegistrationRepo = clientRegistrationRepo;
    	this.customOAuth2AuthorizedClientService = customOAuth2AuthorizedClientService;
    	this.jdbcTemplate = jdbcTemplate;
    	this.customSuccessHandler = customSuccessHandler;
    	this.jwtUtil = jwtUtil;
    	
    }
    
	@Bean
    public SecurityFilterChain filterChain01(HttpSecurity http) throws Exception {

		//csrf disable
		http
			.csrf((auth) -> auth.disable()); //CSRF토큰 검사 비활용 
        //From 로그인 방식 disable
        http
            .formLogin((auth) -> auth.disable());
        //HTTP Basic 인증 방식 disable (= url쿼리 로그인 x)
        http
            .httpBasic((auth) -> auth.disable());
        
        //JWTFilter 추가
        http
        	.addFilterBefore(new JWTFilter(jwtUtil), UsernamePasswordAuthenticationFilter.class);
        
        //JWTFilter 추가 : 무한 루프 방지 -> https://www.devyummi.com/page?id=6693762f034f9479696f1e45
        http
            .addFilterAfter(new JWTFilter(jwtUtil), OAuth2LoginAuthenticationFilter.class);
        
    	// 경로별 접근 권한 설정
		http.authorizeHttpRequests((auth) -> auth
				.requestMatchers("/", "/error", "/member/**", "/yummi/**", "/WEB-INF/**").permitAll()
				.requestMatchers("/resources/**", "/css/**", "/js/**", "/images/**").permitAll()  // 정적 리소스 경로 추가
				.requestMatchers("/admin/**").hasRole("ADMIN")
				.requestMatchers("/my/**").hasAnyRole("ADMIN", "MANAGER")
				.anyRequest().authenticated()
			);
		
		http
			.oauth2Login((oauth2) -> oauth2
				.loginPage("/member/login")
				.clientRegistrationRepository(customClientRegistrationRepo.clientRegistrationRepository())
				.authorizedClientService(customOAuth2AuthorizedClientService.oAuth2AuthorizedClientService(jdbcTemplate, customClientRegistrationRepo.clientRegistrationRepository() )) //Access토큰 정보등을 DB에 담기위해 
				.defaultSuccessUrl("/", true) // 로그인 성공 후 항상 루트 경로로 리디렉션, ROLE체크해서 비회원이면 추가 기입 페이지로 리다이렉트.
				.failureUrl("/login?error=true") // 로그인 실패 시 이동 경로
				.userInfoEndpoint((userInfoEndpointConfig) -> userInfoEndpointConfig
					.userService(customOAuth2UserService))
				.successHandler(customSuccessHandler)
				
			); //= OAuth2인증 후 Security말고 내 커스텀 서비스로 처리하겠다.
	

		http
			.formLogin((auth) -> auth
				.loginPage("/member/login")
				.loginProcessingUrl("/member/loginProc")
				.defaultSuccessUrl("/", true) //로그인 성공시 해당 페이지로 가겠다는 의미 
			);

		http
			.logout((auth) -> auth
				.logoutUrl("/member/logoutProc") //혹은 logoutRequestMatcher()로 더 복잡한 사용 
				.logoutSuccessUrl("/") // = 리디렉션, 이거아니면 logoutSuccessHandler()로 더 복잡한 사용 
			);
		
		http
			.sessionManagement((auth) -> auth
				.invalidSessionUrl("/member/login?timeout=true") // 세션 만료 시 이동할 페이지
				.maximumSessions(1) //다중로그인 허용 갯수 
				.maxSessionsPreventsLogin(true)// true : 초과시 새로운 로그인 차단,  false : 초과시 기존 세션 하나 삭제
			);
		
		//세션 고정 공격 방어코드 
		http
			.sessionManagement((session) -> session
				.sessionFixation().changeSessionId() //로그인 시 동일한 세션에 대한 id변경
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
			);
		

        // 사용자 세부 정보 서비스 설정 (사용자 인증 정보를 제공하는 서비스)
        http
        	.userDetailsService(userDetailServiceImpl);
        
/** 리액트 사용시 오픈 
 
        //Cors 설정 : https://www.devyummi.com/page?id=669370b17bfb6833e187f285 
        http
        	.cors(corsCustomizer -> corsCustomizer.configurationSource(new CorsConfigurationSource() {
				
				@Override
				public CorsConfiguration getCorsConfiguration(HttpServletRequest request) {
					
					CorsConfiguration configuration = new CorsConfiguration();
					
					configuration.setAllowedOrigins(Collections.singletonList("http://localhost:3000"));
					configuration.setAllowedMethods(Collections.singletonList("*"));
					configuration.setAllowCredentials(true);
					configuration.setAllowedHeaders(Collections.singletonList("*"));
					configuration.setMaxAge(3600L);
					
					configuration.setExposedHeaders(Collections.singletonList("Set-Cookie"));
					configuration.setExposedHeaders(Collections.singletonList("Authorization"));
				
					return configuration;
				}
		}));
*/

        return http.build(); //build()를 호출해 설정이 완료된 후에는 변경할 수 없도록 객체를 불변으로 만듦.
    }
	
	
	
}


/**
 *		Security 기본방식은 세션 -> 세션기반 코드인 csrf, 로그인, 로그아웃이 활성화
 *		JWT는 토근방식 -> csrf, 로그인, 로그아웃 모두 off, 커스텀화  
 *
 * 		람다식 표현 해석:
 * 		http.csrf()가 호출되면서 CSRF 설정 객체(CsrfConfigurer)가 반환됨. 
 * 		반환된 CsrfConfigurer 객체를 람다식의 매개변수로 전달하며, 그 이름을 csrf라고 지정.
 * 		람다식 내부에서 csrf.disable()을 호출하여 CSRF 보호 기능을 끔.
 * 
 * 		http .authorizeReqeusts : 아주옛버전
 * 		http .authorizeHttpRequests : 요즘버전 (뷰페이지 호출도 권한 검색..주의!)
 * 		-> (https://www.devyummi.com/page?id=668bd7fe16014d6810ed85f7 참고)
 * 
 * 
 * 		 **스프링 부트 3 이상(또는 스프링 시큐리티 5.7 이상)**부터는 
 * 		@EnableWebSecurity 어노테이션을 명시적으로 추가하지 않아도, 
 * 		SecurityFilterChain 빈을 정의하면 Spring Security 필터가 자동으로 활성화!
 * 
 * 
 * 		보안경로 설정에서, 
 * 		"/member" 는 해당하는 단일 페이지만
 * 		"/member/*"는 하위의 페이지만
 * 		"/member/**"는 하위 모든 페이지에 적용 한다는 의미.
 * 
 * 
 * 		userInfoEndpoint()부분에 대한 설명링크: https://www.notion.so/OAuth2_SecurityConfig-java-175e2244683d80099bb6f78c155112d7?pvs=4
 * 
 * 		
 *
 *		
 * 
 * */


