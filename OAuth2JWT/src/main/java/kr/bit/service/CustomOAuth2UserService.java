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
import kr.bit.DTO.UserDTO;
import kr.bit.entity.UserEntity;
import kr.bit.repository.UserRepository;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService{

	private final UserRepository userRepository;
	
	public CustomOAuth2UserService (UserRepository userRepository) {
		
		this.userRepository = userRepository;
	}
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		
		OAuth2User oauth2User = super.loadUser(userRequest); //JSON -> JAVA
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
		
		//받아온 정보가 겹칠 수 있으므로, 우리서비스에서 이용할 수 있도록 고유한 아이디가 필요
		String username = oAuth2Response.getProvider() + " " + oAuth2Response.getProviderId();
		
		//회원 조회
		UserEntity existData = userRepository.findByUsername(username);
		
		// -비회원
		if(existData == null) {
			
			//DB저장 
			UserEntity userEntity = new UserEntity();
			userEntity.setUsername(username);
			userEntity.setName(oAuth2Response.getName());
			userEntity.setEmail(oAuth2Response.getEmail());
			userEntity.setRole("ROLE_TEMP");
			userEntity.setProfile(oAuth2Response.getProfile_image());
			
			userRepository.save(userEntity);
			
			// SecurityContextHolder에 임시저장 
			UserDTO userDTO = new UserDTO();
			userDTO.setUsername(username);
			userDTO.setName(userEntity.getName());
			userDTO.setEmail(userEntity.getEmail());
			userDTO.setProfile(userEntity.getProfile());
			userDTO.setRole(userEntity.getProfile());
			
			return new CustomOAuth2User(userDTO);
		}
		// -회원(새로 응답받은 수정포함)
		else {
			
			existData.setName(oAuth2Response.getName());
			existData.setEmail(oAuth2Response.getEmail());
			existData.setProfile(oAuth2Response.getProfile_image());
		
			userRepository.save(existData);
			
			// SecurityContextHolder에 임시저장 
			//existData는 예전 데이터, oAuth2Response는 응답받은 최신 데이터 
			UserDTO userDTO = new UserDTO();
			userDTO.setUsername(existData.getUsername());
			userDTO.setName(oAuth2Response.getName());
			userDTO.setEmail(oAuth2Response.getEmail());
			userDTO.setProfile(oAuth2Response.getProfile_image());
			userDTO.setRole(existData.getProfile());
			
			return new CustomOAuth2User(userDTO);
			// 반환된 CustomOAuth2User 객체는 OAuth2AuthenticationToken의 principal로 설정됩니다. (SuccessHandler에서)
		}
		
	}
}
/**
	Spring Security는 반환된 CustomOAuth2User 객체를 기반으로 Authentication 객체(OAuth2AuthenticationToken)를 생성합니다.
	이 객체는 내부적으로 관리되며, 이후 인증 성공 핸들러에게 전달됩니다.
	이후 핸들러에서 
	이 Authentication 객체는 CustomOAuth2UserService에서 반환한 CustomOAuth2User를 principal로 포함합니다.
*/