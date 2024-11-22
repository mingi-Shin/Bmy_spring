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
 * **/