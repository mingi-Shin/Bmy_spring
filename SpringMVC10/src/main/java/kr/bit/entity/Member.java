package kr.bit.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Member {
	
	@Id
	private String username; // ID
	private String password;
	private String name;
	
	@Enumerated(EnumType.STRING) // EnumType.ORDINAL : 0 1 2 ..
	private Role role;
	
	private boolean isEnabled;
	private Date deleted_at;

}

/**
 * @Enumerated는 **JPA(Java Persistence API)**에서 
 * 열거형(Enum) 타입을 데이터베이스에 저장할 때 사용되는 어노테이션입니다. 
 * 이 어노테이션은 엔터티 클래스의 enum 필드를 어떤 방식으로 데이터베이스에 매핑할지 결정하는 역할 
 * 
 * ORDINAL 보다 STRING이 더 안전하고 가독성이 좋으며, 순서 변경에 강한 방식
 * 
 * 
 * */
 