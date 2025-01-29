package kr.bit.service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;

/*
 * 해당 클래스는 OAuth2와 관계없이 내 서비스 자체의 회원관리 로직 클래스입니다. 
 * 
 * */

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberRepository memberRepository; // 실무에서는 생성자 주입방식으로 사용함  
	
	@Autowired
	private PasswordEncoder encoder; // 실무에서는 생성자 주입방식으로 사용함
	
	@Override
	public void register(Member member, String role) {
		/** 정규식 표현 추가 필요.
		  	아이디의 자리수
			아이디의 특수문자 포함 불가
			admin과 같은 아이디 사용 불가
			비밀번호 자리수
			비밀번호 특수문자 포함 필수
		 **/
		
		// 1. 아이디 중복 백엔드 검사
		boolean isUser = memberRepository.existsByUsername(member.getUsername());
		if (isUser) {
			
			return;
		} else {
			
			// 2. 비밀번호 인코드 
			String encodedPassword = encoder.encode(member.getPassword());
			member.setPassword(encodedPassword);
			
			// 3. 건네받은 String타입의 role값을 enum클래스 값으로 변환: Role.valueOf()
			Role roleEnum = Role.valueOf(role);
			member.setRole(roleEnum);
			
			
			// 4. 저장 
			memberRepository.save(member);
		}
		
	}

	@Override
	public void update(Member member, String role) {
		
		memberRepository.save(member); //update도 그냥 save 사
		
	}

	@Override
	public Member get(Member member) {
		Member vo = memberRepository.findByUsername(member.getUsername());
		if(vo != null) {
			return vo;
		} else {
			// vo가 존재하지 않을 경우 처리 : 난 예외 던지기 할거임  
	        throw new NoSuchElementException("Member not found with name: " + member.getName());
		}
	}

	@Override
	public List<Member> getList(Member member) {
		List<Member> list = memberRepository.findAll();
		return list;
	}

	@Override
	public void delete(Member member) {
		memberRepository.delete(member);
	}

}



/**
 * Enum 처리: role 필드는 Role enum 타입인데, 폼에서는 문자열 "ROLE_MANAGER"와 같은 형태로 전송되므로, 
 * 이를 자동으로 Role enum으로 변환하려면 추가적인 설정이 필요합니다.
 * 
 * 
 * 
 * */
