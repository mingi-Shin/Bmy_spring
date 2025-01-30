package kr.bit.DTO;

import java.util.Map;

public class GoogleResponse implements OAuth2Response {
	
	// 매개변수로 받은 데이터를 "GoogleResponse" 클래스 내에서만 고정시켜서 사용하려고 클래스 내에 매개변수와 같은 변수를 선언
	private final Map<String, Object> attribute;
	
	public GoogleResponse(Map<String, Object> attribute) {
		
		this.attribute = attribute; // 네이버와 달리 response로 안쌓여있음 
		// heap에 있는 GoogleResponse 객체의 필드가 heap에 있는 Map 객체를 참조하도록 설정
		System.out.println("GoogleResponse attribute: " + attribute);
	}

	@Override
	public String getProvider() {
		return "google";
	}

	@Override
	public String getProviderId() {
		return attribute.get("sub").toString();
	}

	@Override
	public String getEmail() {
		return attribute.get("email").toString();
	}

	@Override
	public String getName() {
		return attribute.get("name").toString();
	}

	@Override
	public String getNickname() {
		return attribute.get("nickname").toString();
	}

	@Override
	public String getProfile_image() {
		return attribute.get("picture").toString();
	}

	@Override
	public String username() {
		return getProvider()+ " " + getProviderId();
	}

}
