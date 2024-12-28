package kr.bit.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.bit.entity.CustomUser;
import kr.bit.entity.Member;
import kr.bit.repository.MemberRepository;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	
	@Autowired
	private MemberRepository memberRepository; // 회원 메서드 모음
	
	
	// 아래 메서드는 http.userDetailService함수의 매개변수로 가게 될것이다. 왜? 인증을 위해서 
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// username정보를 이용해서 상세조회 시도(회원이 존해하는지 체크)
		Member member = memberRepository.findById(username).get();
		log.info(member);
		
		if(member == null) {
			throw new UsernameNotFoundException(username + " 존재하지 않음");
		}
		// UserDetails(로그인한 회원의 정보를 저장하는 인터페이스)를->구현한 User객체 생성하여 리턴한다.
		// return new User(member.getUsername(),
		// "{noop}"+member.getPassword(), // 권한목록세팅
		// AuthorityUtils.createAuthorityList("ROLE_"+member.getRole().toString()));
		return new CustomUser(member); // User(3가지 권한정보)+Member(회원의 기타 정보)
	}		// 로그인에 성공하면 CustomUser정보가 메모리에등록: JSP에서 활용
			// CustomUser는 User클래스를 상속받았기에 UserDetails 인터페이스로 return이 가능하다. 
	
}

/**
 *	loadUserByUsername 메서드가 UserDetails에 있는 이유는
 *	 = Spring Security에서 인증(authentication), 권한을 처리하기 위해 존재.. 
 *	사용자 정보를 UserDetails 객체로 변환하여 Security가 이해할 수 있는 형식으로 제공하기 위함. 
 * 
 * */
