package kr.bit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringMvc10Application {

	public static void main(String[] args) {
		SpringApplication.run(SpringMvc10Application.class, args);
	}

}


/*
@SpringBootApplication
은 아래의 3 어노테이션을 포함한다. 

@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan


- 스프링 부트에서는 @SpringBootApplication 어노테이션으로 자동으로 보안 설정을 활성화하지만, 
- 스프링 프레임워크에서는 @Configuration과 @EnableWebSecurity 어노테이션을 사용하여 보안 설정을 명시적으로 활성화해야 합니다.
 * **/