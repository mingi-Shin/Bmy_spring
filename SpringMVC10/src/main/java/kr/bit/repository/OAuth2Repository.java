package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Member;
import kr.bit.entity.OAuth2Entity;

import java.util.List;


@Repository
public interface OAuth2Repository extends JpaRepository<OAuth2Entity, String> {

	// JpaRepository의 메서드를 오버라이딩 하는 Member테이블용의 메서드 집합 
	
	
	//아이디 중복 로직
	public boolean existsByUsername(String username);
	
	public OAuth2Entity findByUsername(String username);
	
}
