package kr.mingi;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import kr.mingi.Repository.UserRepository;
import kr.mingi.entity.Member;
import kr.mingi.service.JoinService;



@SpringBootTest
class MingiSecurityApplicationTests {
	
	@Autowired
	private JoinService joinService;
	@Autowired
	private UserRepository repository;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	

	@Test
	void contextLoads() {
		
		Member vo = new Member();
		vo.setUsername("winter");
		vo.setPassword(bCryptPasswordEncoder.encode("ssy917"));
		vo.setName("윈터");
		vo.setRole("ROLE_ADMIN");
		repository.save(vo);

	}

}
