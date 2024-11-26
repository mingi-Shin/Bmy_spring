package kr.bit.entity;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Data;


@Data
public class CustomUser extends User { // User = UserDetails의 구현체 -> Security에서 꼭 필요 
	
	private Member member;
	
	public CustomUser (Member member) {
		// Security에서 쓰려면 User클래스 생성해야함 
		super(member.getUsername(), member.getPassword(), 
				AuthorityUtils.createAuthorityList("ROLE_" + member.getRole().toString()));
		this.member = member;
	}
}
