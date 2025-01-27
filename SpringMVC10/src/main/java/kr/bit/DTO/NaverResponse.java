package kr.bit.DTO;

import java.util.Map;

public class NaverResponse implements OAuth2Response {

	// 매개변수로 받은 데이터를 "NaverResponse" 클래스 내에서만 고정시켜서 사용하려고 클래스 내에 매개변수와 같은 변수를 선언
	private final Map<String, Object> attributes;
	
	public NaverResponse(Map<String, Object> attributes) {
		
		this.attributes = (Map<String, Object>) attributes.get("response");
		System.out.println("NaverResponse생성자_attribute.get('response') : " + this.attributes);
	}
	
	@Override
	public String getProvider() {
		return "naver";
	}

	@Override
	public String getProviderId() {
		return attributes.get("Id").toString();
	}

	@Override
	public String getEmail() {
		return attributes.get("email").toString();
	}

	@Override
	public String getName() {
		return attributes.get("name").toString();
	}

}

/*	네이버 JSON양식:
	{ resultcode=00, message=success, response={id=123123123, name=개발자유미}}	
* 
* */
