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
		vo.setUsername("shinmingi@gmail.com");
		vo.setPassword(encoder.encode("ssy917")); //암호화
		vo.setName("신민기");
		vo.setRole(Role.ADMIN);
		memberRepository.save(vo);
	}

}
