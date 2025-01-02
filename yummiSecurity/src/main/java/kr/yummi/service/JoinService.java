package kr.yummi.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.yummi.dto.joinDTO;
import kr.yummi.entity.Member;
import kr.yummi.repository.UserRepository;


@Service
public class JoinService {
	
	private final UserRepository userRepository;
	
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public JoinService(UserRepository userRepository, BCryptPasswordEncoder bCryptPasswordEncoder) { //생성자 주입방식 
		this.userRepository = userRepository;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}

	public void joinProc(joinDTO joinDTO) {
		
		String username = joinDTO.getUsername();
		String password = joinDTO.getPassword();
		
		Boolean isExist = userRepository.existByusername(username);
		
		if(isExist) {
			//이미 존재하는 아이디
			return;
		}
		
		//가입 실행
		Member data = new Member();
		data.setUsername(username);
		data.setPassword(bCryptPasswordEncoder.encode(password));
		data.setRole("ROLE_TEST_USER"); //임시저장 
		
		userRepository.save(data);
		
	}
}
