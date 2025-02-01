package kr.bit.oauth2;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;

@Configuration
public class CustomClientRegistrationRepo {

	private final SocialClientRegistration socialClientRegistration;
	
	public CustomClientRegistrationRepo(SocialClientRegistration socialClientRegistration) {
		this.socialClientRegistration = socialClientRegistration;
	}
	
	@Bean
	public ClientRegistrationRepository clientRegistrationRepository() {
		
		
		//Inmemory 방식과 DB저장방식이 있다. 이 프로젝트에서는 Inmemory 방식을 써보겠다. 사실 OAuth2로그인 제공자가 보통 몇개 안돼서 메모리에 해도 괜찮다.
		return new InMemoryClientRegistrationRepository(
				socialClientRegistration.naverClientRegistration(),
				socialClientRegistration.googleClientRegistration()
				
				);
				
	}
}
