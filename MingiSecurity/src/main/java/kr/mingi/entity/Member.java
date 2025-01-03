package kr.mingi.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Entity
@Data
public class Member {
	
	@Id
	@Column(unique = true)
	private String username; 
	
	private String password;
	private String name;
	
	private String role;
	
	private String phone;
	
}