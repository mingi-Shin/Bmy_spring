package kr.mingicom.entity;

import java.util.List;

import lombok.Data;

@Data
public class Member {
	
	private int memIdx;
	private String memID;
	private String memPassword;
	private String memName;
	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;
	private Boolean is_active;
	private List<AuthVO> authList; //한 회원이 여러개의 권한을 가짐(ROLE_READER, ROLE_WRITER, ROLE_MANAGER, ROLE_ADMIN), 
									//authList[0].auth, authList[1].auth, ... 

}

