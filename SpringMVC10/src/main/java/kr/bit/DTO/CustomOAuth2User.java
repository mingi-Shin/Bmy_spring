package kr.bit.DTO;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class CustomOAuth2User implements OAuth2User{
	
	// 매개변수로 받을 값을 고정시키기 위해 final선언
	//private final OAuth2Response oAuth2Response;
	//private final String role;
	
	private final MemberDTO memberDTO;
	
	public CustomOAuth2User(MemberDTO memberDTO) {
		
		this.memberDTO = memberDTO;
	}
	

	@Override
	public Map<String, Object> getAttributes() { //로그인하면 리소스서버로부터 넘어오는 모든 데이터 

		return null;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		Collection<GrantedAuthority> collection = new ArrayList<>();
		
		// GrantedAuthority는 인터페이스이므로 직접 인스턴스화 X. 그래서 익명클래스 사용하여 일회성 구현. 
		collection.add(new GrantedAuthority() {
			
			@Override
			public String getAuthority() { //GrantedAuthority 인터페이스에 정의된 추상 메서드
				
				return memberDTO.getRole();
			}
		});
		
		return collection;
	}

	@Override
	public String getName() {
		
		return memberDTO.getName();
	}
	
	//내가 보고싶어서 만든 메서드 
	public String getUsername() {
		
		return memberDTO.getUsername(); // ID
		
	}


}
