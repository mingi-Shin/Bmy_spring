package kr.bit.DTO;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class CustomOAuth2User implements OAuth2User{
	
	private final OAuth2Response oAuth2Response;
	private final String role;
	
	public CustomOAuth2User(OAuth2Response oAuth2Response, String role) {
		
		this.oAuth2Response = oAuth2Response;
		this.role = role;
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
				
				return role;
			}
		});
		
		return collection;
	}

	@Override
	public String getName() {
		
		return oAuth2Response.getName();
	}
	
	//내가 보고싶어서 만든 메서드 
	public String getUsername() {
		
		return oAuth2Response.getProvider()+ " " + oAuth2Response.getProviderId();
		
	}


}