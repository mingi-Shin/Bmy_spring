package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, String> {

	// JpaRepository의 메서드를 오버라이딩 하는 Member테이블용의 메서드 집합 
}
