package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Member;
import kr.bit.entity.OAuth2Entity;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long>{

	//아이디 중복 로직
	public boolean existsByUsername(String username);
	
	public Member findByUsername(String username);
	
}
