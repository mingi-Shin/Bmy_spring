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

/**
 *	User클래스는 UserDetails 인터페이스를 구현한(implements) 클래스:
 *		UserDetails에는 많은 메서드가 있어서, 편의성과 학습성 그리고 코드중복성을 방지하기 위해 User라는 기본 구현 클래스를 제공
 *		개발자는 User클래스를 직접 쓰거나, 위와 같이 확장(extends)하여 커스텀클래스를 만들어서 사용.
 *
 *		UserDetails를 implements 하여 CustomUserDetails클래스를 직접 만들어 쓰기도 함 
 *		GPT는 UserDetails를 커스텀으로 구현하는 것을 추천 
 * 	
 * */
