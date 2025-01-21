package kr.bit.service;

import java.util.Map;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AccessToken;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import kr.bit.DTO.CustomOAuth2User;
import kr.bit.DTO.GoogleResponse;
import kr.bit.DTO.MemberDTO;
import kr.bit.DTO.NaverResponse;
import kr.bit.DTO.OAuth2Response;
import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
	
	private final MemberRepository memberRepository;
	public CustomOAuth2UserService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	
	
	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
		//OAuth2UserRequest 객체 = 액세스 토큰과, 클라이언트 등록 정보 등의 내용이 캡슐화 된 객체
		
		OAuth2User oAuth2User = super.loadUser(userRequest);
		System.out.println("OAuth2UserService_loadUser()_oAuth2User(사용자정보,역할/권한) : " + oAuth2User);
		
		
		//userRequest에서 AccessToken 가져와봐, 함 보고싶네
		OAuth2AccessToken accessToken = userRequest.getAccessToken();
		System.out.println("accessToken궁금해 : " + accessToken);
		//사용자 정보를 요청하기 위한 URL
		String userInfoEndPointUrl = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUri();
		System.out.println("userInfoEndPointUrl궁금해 : " + userInfoEndPointUrl);
		//OAuth2Reponse객체 생성에 뭐가 쓰일지 보고싶네.
		Map<String, Object> attributes =  oAuth2User.getAttributes();
		System.out.println("oAuth2User.getAttributes() 궁금해 : " + attributes);
		
		//OAuth2 client-name에 해당
		String registrationId = userRequest.getClientRegistration().getRegistrationId();
		
		OAuth2Response oAuth2Response = null;
		
		// 제공자에 맞는 각 하위 구현 객체를 상위 인터페이스 객체에 할당, get메서드로 값 가져오면 됨 
		// java17이상에서 if대신 switch문
		oAuth2Response = switch (registrationId) {
		//사용자 정보에서 
	    case "naver" ->  new NaverResponse(oAuth2User.getAttributes());
	    case "google" -> new GoogleResponse(oAuth2User.getAttributes());
	    default -> throw new IllegalArgumentException("지원하지 않는 OAuth2 provider: " + registrationId);
		};
		
		// 고유 아이디 생성: 확장 가능성과 안전성을 고려.. 다수의 OAuth2 계정 등록 가능. 이러면 username을 고유 계정으로 만들어야..
		String username = oAuth2Response.getProvider() + " " + oAuth2Response.getProviderId(); 
		
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setUsername(username);
		memberDTO.setName(oAuth2Response.getName());
		memberDTO.setRole((Role.MEMBER_TEMP_USER).toString());
		
		
		//받은 정보 넘김 
		return new CustomOAuth2User(memberDTO);
		
		// 추가 가입 정보 기재 페이지로 리다이렉트해서, 핸드폰 인증(API) 같은 걸로 소셜 중복가입을 방지하는 로직도 필요할 듯
		// memberRepository.save(memberVO);회원가입 로직은 해당 메서드 목적과 어긋남. 
		
	}

}

/*			OAuth2Response 인터페이스를 도입함으로써 코드 중복 제거, 확장성 확보, 가독성 향상
 * 			-> 안그러면 아래처럼 하나하나 작성해야 함 
 * 			NaverResponse vo1 = new NaverResponse(oAuth2User.getAttributes());
			String role = "ROLE_USER";
			return new CustomOAuth2User(vo1, role);
			
			해당 로직에서 가입 로직을 추가하는 것은 책임분리원칙에서 어긋남 
			
			loadUser() 에서 받는 OAuth2UserRequest객체는 OAuth2 인증과정을 통해 클라이언트가 
			리소스 서버로부터 받는 액세스 토큰과, 클라이언트 등록 정보 등의 내용이 캡슐화 된 객체임 
			사용자 정보 엔드포인트를 호출하여 JSON 형태의 데이터를 가져오고, 이를 내부적으로 OAuth2User 타입의 객체로 변환
 * 
 * */
