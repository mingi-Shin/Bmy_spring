package kr.bit.service;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import kr.bit.DTO.CustomOAuth2User;
import kr.bit.DTO.GoogleResponse;
import kr.bit.DTO.NaverResponse;
import kr.bit.DTO.OAuth2Response;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
	
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oAuth2User = super.loadUser(userRequest);
		System.out.println("OAuth2UserService_loadUser()_oAuth2User : " + oAuth2User);
		
		//application.properties 파일에서 설정된 OAuth2 client-name에 해당
		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		System.out.println("OAuth2UserService_loadUser()_registrationId : " + registrationId);
		
		OAuth2Response oAuth2Response = null;
		
		// 제공자에 맞는 각 하위 구현자 객체를 상위 인터페이스 객체에 할당
		// java17이상에서 if대신 switch문
		oAuth2Response = switch (registrationId) {
	    case "naver" ->  new NaverResponse(oAuth2User.getAttributes());
	    case "google" -> new GoogleResponse(oAuth2User.getAttributes());
	    default -> throw new IllegalArgumentException("지원하지 않는 OAuth2 provider: " + registrationId);
		};
		
		
		String role = "ROLE_TEST";// 권한 임시구현
		
		return new CustomOAuth2User(oAuth2Response, role);
		
	}

}

/*			OAuth2Response 인터페이스를 도입함으로써 코드 중복 제거, 확장성 확보, 가독성 향상
 * 			-> 절레절레.. 
 * 			NaverResponse vo1 = new NaverResponse(oAuth2User.getAttributes());
			String role = "ROLE_USER";
			return new CustomOAuth2User(vo1, role);
 * 
 * */
