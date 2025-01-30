package kr.bit.service;

import java.util.Map;

import org.springframework.security.oauth2.client.registration.ClientRegistration;
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
import kr.bit.entity.OAuth2Entity;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;
import kr.bit.repository.OAuth2Repository;

/*
 *  	소셜 로그인 처리
 * */
@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
	// 인증 및 사용자 정보를 반환하는 역할에 집중하도록 로직 설계하세요. 
	private final OAuth2Repository oAuth2Repository;
	private final MemberRepository memberRepository;
	
	public CustomOAuth2UserService(OAuth2Repository oAuth2Repository, MemberRepository memberRepository) {
		
		this.oAuth2Repository = oAuth2Repository;
		this.memberRepository = memberRepository;
	}

	@Override
	public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException { //OAuth2UserRequest 객체 = 액세스 토큰과, 클라이언트 등록 정보 등의 내용이 캡슐화 된 객체
		
		OAuth2User oAuth2User = super.loadUser(userRequest); // oAuth2User.getAttributes()를 하면 Map으로 가져와야 햄 
		System.out.println("loadUser() : 사용자정보,역할/권한 JSON -> JAVA) : " + oAuth2User);

//-----------------------------------------------------------------------------------------------------------------------------------
		//클라이언트 등록 정보 접근해보기, 궁금해
		ClientRegistration clientRegistration =  userRequest.getClientRegistration();
		System.out.println("clientRegistration 궁금해 : " + clientRegistration);
		//userRequest에서 AccessToken 가져와봐, 함 보고싶네
		OAuth2AccessToken accessToken = userRequest.getAccessToken();
		System.out.println("accessToken궁금해 : " + accessToken);
		//사용자 정보를 요청하기 위한 URL
		String userInfoEndPointUrl = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUri();
		System.out.println("userInfoEndPointUrl궁금해 : " + userInfoEndPointUrl);
		//OAuth2Reponse객체 생성에 뭐가 쓰일지 보고싶네.
		Map<String, Object> attributes =  oAuth2User.getAttributes();
		System.out.println("oAuth2User.getAttributes() 궁금해 : " + attributes);
//-----------------------------------------------------------------------------------------------------------------------------------
		
		//resistrationId 가져오기 (third-party id)
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
		//oAuth2User.getAttributes()는 Map형식이라 oAuth2Response에 대입이 될수있다.
		
		/**
		 * 로그인 상황 분류: 0. 기존 회원 조회 
		 * 	1. 기존회원 = 정상 로그인 -> DTO 생성하여 return
		 * 	2. 기존회원 = 새로운 외부 계정 연동 -> OAuth2Entity에 계정 추가 
		 * 	3. 비회원 = 예외를 던짐 -> filter에서 .AuthenticationFailureHandler 로 AuthenticationFailureHandler 구현하여 예외 발생시 회원가입 페이지로 리다이렉트 
		 */
		
		//받아온 정보가 겹칠 수 있으므로, 우리서비스에서 이용할 수 있도록 고유한 아이디가 필요
		String username = oAuth2Response.getProvider() + " " + oAuth2Response.getProviderId();
		
		// OAuth2Entity 테이블에서 회원 조회
		OAuth2Entity existData = oAuth2Repository.findByUsername(username);	
		
		//-비회원
		if(existData == null) {
			
			//DB저장 
			OAuth2Entity userEntity = new OAuth2Entity();
			userEntity.setUsername(username);
			userEntity.setName(oAuth2Response.getName());
			userEntity.setProfile(oAuth2Response.getProfile_image());
			userEntity.setProvider(oAuth2Response.getProvider());
			userEntity.setProviderId(oAuth2Response.getProviderId());
			oAuth2Repository.save(userEntity);
			System.out.println("비회원-DB저장 : " + userEntity);
			
			// SecurityContextHolder에 임시저장 하기위한 MemberDTO 클래스
			MemberDTO memberDTO = new MemberDTO();
			memberDTO.setUsername(username); //새로 만든 username 저장 
			memberDTO.setRole(Role.MEMBER_READ_ONLY.toString()); //처음가입시 주는 Role값 부여 
			memberDTO.setName(userEntity.getName());
			memberDTO.setEmail(userEntity.getEmail());
			memberDTO.setProfile(userEntity.getProfile());
			System.out.println("비회원-memberDTO : " + memberDTO);
			
			return new CustomOAuth2User(memberDTO); 
		}
		//-회원(새로 응답받은 수정을 포함)
		else {
			
			existData.setName(oAuth2Response.getName());
			existData.setEmail(oAuth2Response.getEmail());
			existData.setProfile(oAuth2Response.getProfile_image());
			
			oAuth2Repository.save(existData); // OAuth2 데이터 최신정보 업데이트 
			
			//existData는 예전 데이터, oAuth2Response는 응답받은 최신 데이터이므로 set할때 구분해서 사용 
			MemberDTO memberDTO = new MemberDTO();
			memberDTO.setUsername(existData.getUsername()); //기존의 username 호출 
			memberDTO.setName(oAuth2Response.getName());
			memberDTO.setEmail(oAuth2Response.getEmail());
			memberDTO.setProfile(oAuth2Response.getProfile_image());
			
			Member member = existData.getMemberIdx(); //OAuth2Entity의 memIdx가 Member자료형으로 되어있어서 가능 
			memberDTO.setRole(member.getRole().toString());
			System.out.println("회원-memberDTO : " + memberDTO);
			
			return new CustomOAuth2User(memberDTO);
			// 반환된 CustomOAuth2User 객체는 OAuth2AuthenticationToken의 principal로 설정됩니다. (SuccessHandler에서!)
		}
		// 추가 가입 정보 기재 페이지로 리다이렉트해서, 핸드폰 인증(API) 같은 걸로 소셜 중복가입을 방지하는 로직도 필요할 듯
	}

}

/**
 * 
 * 	OAuth2Response 인터페이스를 도입함으로써 코드 중복 제거, 확장성 확보, 가독성 향상
	-> 안그러면 아래처럼 하나하나 작성해야 함 
	NaverResponse vo1 = new NaverResponse(oAuth2User.getAttributes());
	String role = "ROLE_USER";
	return new CustomOAuth2User(vo1, role);
	
	해당 로직에서 가입 로직을 추가하는 것은 책임분리원칙에서 어긋남 
	
	loadUser( OAuth2UserRequest ) :
	OAuth2UserRequest 객체로부터 액세스 토큰을 가져와 인증서버의 사용자 정보 엔드포인트에 요청,
	요청에의해 반환된 JSON응답에는 사용자 프로필 정보(이름, 이메일, 아이디 등)이 포함되어있다.
	이를 자바 객체로 매핑, OAuth2User 클래스로 변환하여 인증에 활용해요.
	
	리턴된 OAuth2User 객체는 Authentication 객체를 생성하는데 사용되고,  
	최종적으로 Authentication 객체가 SecurityContextHolder에 저장이 됩니다.
	참고로, 요청 단위로만 인증 정보를 유지하고, 글로벌 상태나 세션 기반 상태를 유지하지 않기 때문에 stateless 입니다!
	
	Spring Security는 반환된 CustomOAuth2User 객체를 내부적으로 Authentication 객체(OAuth2AuthenticationToken)를 생성할 때 포함시킵니다. 
	이 객체는 SecurityContext에 저장되고, 인증 성공 핸들러에게 전달됩니다.
	
	
 */
	