package kr.mingi.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.mingi.entity.Member;

@Repository
public interface UserRepository extends JpaRepository<Member, String>{

	public Boolean existsByUsername(String username);
	
	public Member findByUsername(String username);
	
	
}
