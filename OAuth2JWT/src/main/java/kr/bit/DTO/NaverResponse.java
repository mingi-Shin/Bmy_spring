package kr.bit.DTO;

import java.util.Map;

/**
 * 	네이버 JSON양식:
 *	{ resultcode=00, message=success, response={id=123123123, name=개발자유미}}	
 *	네이버는 사용자 정보가 response변수에 한번 더 포장되어 있어서 추가로 꺼내주는 작업이 필요.
 * */

public class NaverResponse implements OAuth2Response {

	// 매개변수로 받은 데이터를 "NaverResponse" 클래스 내에서만 고정시켜서 사용하려고 클래스 내에 매개변수와 같은 변수를 선언
	private final Map<String, Object> attributes; //heap
	
	public NaverResponse(Map<String, Object> attributes) {
		
		this.attributes = (Map<String, Object>) attributes.get("response"); 
		// stack에있는 attributes를 heap에있는 attributes에 할당
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

	@Override
	public String getNickname() {
		return attributes.get("nickname").toString();
	}

	@Override
	public String profile_image() {
		return attributes.get("profile_image").toString();
	}

}

/*	
* */
