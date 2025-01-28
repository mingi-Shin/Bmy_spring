package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import kr.bit.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long> {

	UserEntity findByUsername(String username);
}
