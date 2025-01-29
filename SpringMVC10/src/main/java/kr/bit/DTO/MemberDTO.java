package kr.bit.DTO;

import lombok.Data;

@Data
public class MemberDTO {

	private String username;
	private String name;
	private String email;
	private String role;
	private String profile;
}

/*
 * 	MemberDTO 역할
 * 	-> OAuth2UserService 에서 사용자정보를 비교적 가벼운 DTO타입으로 가공하여 처리함.
 * 	: OAuth2 인증 후 사용자의 정보를 담는 객체로 사용됨.
 * 		이 객체는 주로 JWT발급을 위한 정보 전달에 사용됨.
 * 
 * 	MemberDTO 와 Entity 를 왜 분리하여 사용?
 * 	1. 책임분리: DTO는 데이터 전송,가공 / Entity는 DB와의 연동 및 영속성을 관리
 *  2. DTO는 가벼워서 네트워크와 메모리 사용량을 줄임 
 * 		
 * 
 * */
