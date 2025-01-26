package kr.bit.DTO;

import java.util.Map;

public class GoogleResponse implements OAuth2Response {
	
	// 매개변수로 받은 데이터를 "GoogleResponse" 클래스 내에서만 고정시켜서 사용하려고 클래스 내에 매개변수와 같은 변수를 선언
	private final Map<String, Object> attributes; //heap
	
	public GoogleResponse(Map<String, Object> attributes) {
		
		this.attributes = attributes; // 네이버와 달리 response로 안쌓여있음 
		// heap에 있는 GoogleResponse 객체의 필드가 heap에 있는 Map 객체를 참조하도록 설정
		System.out.println("GoogleResponse attributes: " + attributes);
	}

	@Override
	public String getProvider() {
		return "google";
	}

	@Override
	public String getProviderId() {
		return attributes.get("sub").toString();
	}

	@Override
	public String getEmail() {
		return attributes.get("email").toString();
	}

	@Override
	public String getName() {
		return attributes.get("name").toString();
	}
	@Override
	public String getNickname() {
		return attributes.get("nickname").toString();
	}

	@Override
	public String profile_image() {
		return attributes.get("profile_image").toString();
	}


}
