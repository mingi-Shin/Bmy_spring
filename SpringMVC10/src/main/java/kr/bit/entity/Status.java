package kr.bit.entity;

public enum Status {
	
	PENDING, // 추가 정보 입력 필요 (미인증)
	ACTIVE, // 활성 계정
	SUSPENDED, // 정지 계정
	DELETED; // 삭제된 계정 

}

/*	소셜로그인 후, 추가 정보 기입 페이지 | 메인페이지 Redirect 분기점에서 
 * 	Role 보다는 status를 활용하자.
 * 	그게 설계 목적에 더 적합하기 때문이다.
 * 
 * */
