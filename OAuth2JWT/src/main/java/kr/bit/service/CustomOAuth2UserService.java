package kr.bit.service;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import kr.bit.DTO.GoogleResponse;
import kr.bit.DTO.NaverResponse;
import kr.bit.DTO.OAuth2Response;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService{

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oauth2User = super.loadUser(userRequest);
		System.out.println("loadUser(userRequest)처리 후 oauth2user : " + oauth2User);
		
		String registrationId = userRequest.getClientRegistration().getClientId();
		
		OAuth2Response oAuth2Response = null;
		if(registrationId.equals("naver")) {
			//네이버처리
			oAuth2Response = new NaverResponse(oauth2User.getAttributes());
		}
		else if (registrationId.equals("google")) {
			//구글처리 
			oAuth2Response = new GoogleResponse(oauth2User.getAttributes());
		}
		else {
			throw new IllegalArgumentException("지원하지 않는 OAuth2 provider: " + registrationId);
		}
		
		//https://www.youtube.com/watch?v=Sl3A879RS5o&ab_channel=%EA%B0%9C%EB%B0%9C%EC%9E%90%EC%9C%A0%EB%AF%B8
		
		
		
		
	}
}
