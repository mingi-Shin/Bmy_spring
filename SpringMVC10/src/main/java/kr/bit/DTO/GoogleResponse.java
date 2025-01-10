package kr.bit.DTO;

import java.util.Map;

public class GoogleResponse implements OAuth2Response {
	
	private final Map<String, Object> attribute;
	
	public GoogleResponse(Map<String, Object> attribute) {
		
		this.attribute = attribute; // 네이버와 달리 response로 안쌓여있음 
		System.out.println("GoogleResponse attribute: " + attribute);
	}

	@Override
	public String getProvider() {
		return "google";
	}

	@Override
	public String getProviderId() {
		return attribute.get("id").toString();
	}

	@Override
	public String getEmail() {
		return attribute.get("email").toString();
	}

	@Override
	public String getName() {
		return attribute.get("name").toString();
	}

}
