package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Board;

@Repository // 생략가능
public interface BoardRepository extends JpaRepository<Board, Long>{ //entity, primaryKey Type.. 
											//-> CRUD, 페이징처리 메서드 내장되어 있음
	
	
	//내장x, 커스텀메서드 => 쿼리메서드!
	public Board findByWriter(String writer); //find + 엔티티 이름 + By + 변수 이름

	
}

/**
 * 	JPA는.. 
 *	Repository 에서 JpaRepository<entity, primaryKey Type>을 extends 해서,  
 * 	내장함수를 가져오거나, 쿼리메서드를 정의해서 Service에서 호출.
 * 
 * 
 * */