package kr.mingi.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import kr.mingi.DTO.CustomUserDetails;
import kr.mingi.Repository.UserRepository;
import kr.mingi.entity.Member;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	private final UserRepository userRepository;
	
	public CustomUserDetailsService(UserRepository repository) {
		
		this.userRepository = repository;
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		System.out.println("loadUserByUsername 실행, 받은 username : " + username);
		
		System.out.println("DB에 username존재 유무 확인 쿼리 작동");
		Member userData = userRepository.findById(username).get();
		//Member userData = userRepository.findByUsername(username);
		
		if(userData == null) {
			throw new UsernameNotFoundException(username + " 존재하지 않음");
		}
		
		System.out.println("조회결과 완료. 이제 userData를 CustomUserDetails로 넘기겠음 -> " + userData);
		return new CustomUserDetails(userData);
	}

}

/**
 * 	UserDetailsService (구현체)가 UserDetails를 return해야 함. 
 * 
 * */
