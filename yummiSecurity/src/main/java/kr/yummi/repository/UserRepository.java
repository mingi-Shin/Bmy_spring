package kr.yummi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.yummi.entity.Member;


public interface UserRepository extends JpaRepository<Member, Integer> { // <해당entity, Id의 타입>

	Boolean existByusername(String username);
	
}
