package kr.bit.DTO;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

public class CustomOAuth2User implements OAuth2User {

	private final UserDTO userDTO;
	public CustomOAuth2User(UserDTO userDTO) {
		
		this.userDTO = userDTO;
	}
	
	@Override
	public Map<String, Object> getAttributes() {
		// 구글, 네이버의 response구성이 서로 달라 attributes가져오는 메서드는 짜기 힘들어 
		return null;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		Collection<GrantedAuthority> collection = new ArrayList<>();
		
		collection.add(new GrantedAuthority() {
			
			@Override
			public String getAuthority() {
				return userDTO.getRole();
			}
		});
		
		
		return collection;
	}

	@Override
	public String getName() {
		
		return userDTO.getName();
	}
	
	public String getUsername() {
		
		return userDTO.getUsername();
	}
	

}
