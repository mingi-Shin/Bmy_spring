package kr.bit.entity;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

/**
ORM 기술을 통한 데이터베이스 테이블 매핑(Entity, ORM)
	: VO 객체(엔티티) 기반으로 데이터베이스 테이블 자동 생성

starategy전략 
GenerationType. AUTO/ SEQUENCE/ IDENTITY 에 대한 설명:
	https://www.notion.so/Idx-GeneratedValue-144e2244683d8062a284f20b0f7708e3?pvs=4
요약= AUTO: DB언어에따라/ SEQUENCE: postgresql/ IDENTITY: MySql


*/

@Entity // -> DB의 Table
@Data
public class Board { // VO <-- ORM --> Table
	
	@Id //PK
	@GeneratedValue(strategy = GenerationType.SEQUENCE) //자동증가
	private Long boardIdx; //자동증가 
	
	@Column(length = 100)
	private String title;
	private String content;
	
	//updatable = false: update할 땐 값 안넣을거야.
	@Column(updatable = false) 
	private String writer;
	
	//insertable = false: insert할 땐 값 안넣을 거야, default했으니까 생략해도 되지만 명시적으로 하면 더 정확하니까..
	@Column(insertable = false, updatable = false ,columnDefinition = "TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP") 
	private Date indate; // CURRENT_TIMESTAMP == now()
	@Column(insertable = false, updatable = false , columnDefinition = "INT DEFAULT 0")
	private int count;
	
}
