package kr.mingi.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.mingi.entity.Member;
import kr.mingi.entity.MemberUsers;
import kr.mingi.mapper.MemberMapper;

public class MemberUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException { //변수명 username고정되어있음 
		System.out.println("2. 로그인 요청이 들어오면 실행: UserDetailsService의 loadUserByUsername()실행 ");
		//로그인 처리하기 
		Member mvo = memberMapper.login(username); //user정보 뱉어: memberMap Type
		
		//loadUserByUsername()을 사용하기 위해 내가 만든 로그인 반환클래스를 UserDetails클래스와 통합할 필요가 있음: MemberUsers  
		if(mvo != null) {
				System.out.println("3. return값으로 new MemberUsers(mvo)생성자");
				return new MemberUsers(mvo); // MemberUsers는 UserDetails인터페이스의 구현체인 User를 extends 중이다. 
		} else {
			System.out.println("user with username -" + username + "-does not exist.");
			throw new UsernameNotFoundException("user with username -" + username + "-does not exist.");
		}
	}
	
	
	// 스프링 보안(새로운 세션 생성 메서드)
	// UsernamePasswordAuthenticationToken -> 회원정보 + 권한정보
	public Authentication createNewAuthentication(Authentication currentAuth, String username) {
		UserDetails newPrincipal = this.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken newAuth = 
				new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		newAuth.setDetails(currentAuth.getDetails());
		System.out.println("새로운 세션 생성, 매개변수: " + currentAuth);
		return newAuth;
	}

}
