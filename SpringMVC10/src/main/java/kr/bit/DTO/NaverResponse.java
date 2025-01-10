package kr.bit.DTO;

import java.util.Map;

public class NaverResponse implements OAuth2Response {

	private final Map<String, Object> attribute;
	
	public NaverResponse(Map<String, Object> attribute) {
		this.attribute = (Map<String, Object>) attribute.get("response");
		System.out.println("NaverResponse생성자_attribute.get('response') : " + this.attribute);
	}
	
	@Override
	public String getProvider() {
		return "naver";
	}

	@Override
	public String getProviderId() {
		return attribute.get("Id").toString();
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

/*	네이버 JSON양식:
	{
	resultcode=00, message=success, response={id=123123123, name=개발자유미}
	}	
* 
* */
