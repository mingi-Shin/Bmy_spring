package kr.bit.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.Data;

@Entity
@Data
@Table(
	    uniqueConstraints = @UniqueConstraint(columnNames = {"memberIdx", "providerId"}) // memberIdx와 providerId를 합쳐 유니크 설정
	)
public class OAuth2Entity {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE) //자동증가
	private Long oAuth2Idx;
	
	@ManyToOne // 여러 OAuth2Entity가 하나의 Member에 속함
	@JoinColumn(name = "memberIdx", referencedColumnName = "memberIdx")//name: OAuth2Entity스키마에 생성될 외래키 컬럼, referenced는 참조할 테이블의 컬럼이름 
	private Member memberIdx; // JPA는 Member 테이블과 연결됨, 변수는 상징성있게 임의대로 짓기?
	
	//name으로 하면 갖고오기 허용해야 되고, 해도 이름이 다르게 중복가입이 될수도 있으니까 핸드폰 인증까지 해야되네?
	
	private String username;
	private String name;
	private String email;
	private String profile;
	
	@Column(nullable = false)
    private String provider;

    @Column(nullable = false)
    private String providerId;

    //@Column(nullable = false)
    //private String accessToken;

    //@Column
    //private String refreshToken; //리프레시 기능 도입 후 생성 

}
/*	@Table(
 *	    uniqueConstraints = @UniqueConstraint(columnNames = {"memberIdx", "providerId"}) 
 *	)
 *
 * 	memberIdx와 providerId의 조합이 유니크해야 하므로, 같은 값의 조합이 두 개 이상 존재할 수 없도록 합니다.
 * 
 * 	OAuth2Entity에서는 Role, email등 공통사항은 필요 없다구 
 * 	
 * */

