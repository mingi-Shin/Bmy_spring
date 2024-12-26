package kr.bit.service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberRepository memberRepository; // 실무에서는 생성자 주입방식으로 사용함  
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public void register(Member member, String role) {
		
		String encodedPassword = bCryptPasswordEncoder.encode(member.getPassword());
		member.setPassword(encodedPassword);
		
		//건네받은 String타입 role값을 enum클래스 값으로 변환하는 코드: Role.valueOf()
		Role roleEnum = Role.valueOf(role);
		member.setRole(roleEnum);
		
		memberRepository.save(member);
	}

	@Override
	public void update(Member member, String role) {
		
		memberRepository.save(member); //update도 그냥 save 사
		
	}

	@Override
	public Member get(Member member) {
		Optional<Member> memberOptional = memberRepository.findById(member.getUsername());
		if(memberOptional.isPresent()) {
			Member vo = memberOptional.get();
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
