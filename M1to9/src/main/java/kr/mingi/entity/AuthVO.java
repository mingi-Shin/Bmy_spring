package kr.mingi.entity;

import lombok.Data;

@Data
public class AuthVO {
	private int num; //일련번호
	private String memID; //회원아이디
	private String auth; //회원권한, 예: Ajax게시판, 일반게시판 / 읽기, 쓰기, 수정, 삭제 권한 등..
	
}
