package kr.mingi.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.mingicom.entity.Member;
import kr.mingicom.entity.MemberUsers;
import kr.mingicom.mapper.MemberMapper;

public class MemberUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException { //변수명 username고정되어있음 
		System.out.println("-로그인 요청이 들어오면 실행-");
		//로그인 처리하기 
		Member mvo = memberMapper.login(username); //user정보 뱉어 
		
		//loadUserByUsername()을 사용하기 위해 내가 만든 로그인 반환클래스를 UserDetail클래스와 통합할 필요가 있음: MemberUsers  
		if(mvo != null) {
				return new MemberUsers(mvo);
		} else {
			System.out.println("user with username " + username + "does not exist.");
			throw new UsernameNotFoundException("user with username " + username + "does not exist.");
		}
	}
}
