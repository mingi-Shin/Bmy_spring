package kr.mingi.entity;

import java.util.List;

import lombok.Data;

@Data
public class Member {
	
	private int memIdx;
	private String memID;
	private String memPwd;
	private String memName;
	private String memPhone;
	private String memEmail;
	private String memProfile;
	private Boolean is_active;
	private String memAddr;
	private float latitude;
	private float longitude;
	private List<AuthVO> authList; //한 회원이 여러개의 권한을 가짐(ROLE_READER, ROLE_WRITER, ROLE_MANAGER, ROLE_ADMIN), 
									//authList[0].auth, authList[1].auth, ... 
									// 그래서 List로 한거.. 
}
