package kr.mingicom.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;


//인증 후 사용자 정보를 저장 (UserDetails)
@Data
public class MemberUsers extends User{ //User는 UserDetails인터페이스의 구현체 

	private Member member; // MemberUsers 객체가 Member 객체를 참조가능: MemberUsers는 Member와 User 클래스의 합성을 위한 클래스이다. 
	
	public MemberUsers(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		// TODO Auto-generated constructor stub
	}
	
	//User클래스에 담아주기 위한 생성 
	public MemberUsers(Member mvo) {
		super(mvo.getMemID(), mvo.getMemPassword(), 
				mvo.getAuthList().stream()
					.map( auth -> new SimpleGrantedAuthority(auth.getAuth()))
						.collect(Collectors.toList())
						//List<AuthVO> --> collection<SimpleGrantedAuthority> 변환해줘야 함 
						/**
						 mvo.getAuthList()로 AuthVO 목록을 가져오고, 
						 이를 스트림으로 변환한 후 각 AuthVO 객체에서 권한 문자열(auth.getAuth())을 추출하여 
						 SimpleGrantedAuthority 객체로 변환합니다.
						 최종적으로 collect(Collectors.toList())를 통해 Collection<SimpleGrantedAuthority> 형태로 변환하여 
						 User 클래스의 생성자에 전달합니다.
						 * */
			);
		System.out.println("4.MemberUsers()생성자: super()로 부모인 User클래스 생성자 호출 -> Get ID, Password, Auth , 또한 this.Member객체에 mvo 초기화");
		this.member = mvo;
		//member객체를 추가함으로써 사용자 정보를 보다 풍부하게 관리가 가능해짐 
		//이로써 MemberUsers 클래스는 Member 클래스와 User클래스 둘 모두 사용 가능한 복합클래스가 되었다.
	}

}
