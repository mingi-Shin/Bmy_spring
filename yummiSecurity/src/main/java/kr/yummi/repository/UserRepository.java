package kr.yummi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.yummi.entity.UserEntity;


public interface UserRepository extends JpaRepository<UserEntity, Integer> { // <해당entity, Id의 타입>

	Boolean existByusername(String username);
	
}
