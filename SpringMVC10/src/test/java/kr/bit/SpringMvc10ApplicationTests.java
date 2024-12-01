package kr.bit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;

@SpringBootTest
class SpringMvc10ApplicationTests {

	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	void createMember() {
		Member vo = new Member();
		vo.setUsername("winter@gmail.com");
		vo.setPassword(encoder.encode("ssy4260")); //암호화
		vo.setName("김민정");
		vo.setRole(Role.MEMBER_READ_WRITE);
		memberRepository.save(vo);
	}

}
