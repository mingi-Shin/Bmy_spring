package kr.mingi.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.mingi.config.RootConfig;
import kr.mingi.entity.AuthVO;
import kr.mingi.entity.Member;
import kr.mingi.mapper.MemberMapper;
import lombok.extern.log4j.Log4j2;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {RootConfig.class})
public class MemberTest {

	@Autowired
	private MemberMapper memMapper;
	
	//@Test
	public void insertMemberTest() {
		Member vo = new Member();
		vo.setMemID("ningning");
		vo.setMemPwd("ssy917");
		vo.setMemName("닝닝");
		vo.setMemEmail("ningning@gmail.com");
		vo.setMemAddr("서울시");
		vo.setLatitude(0);
		vo.setLongitude(0);
		memMapper.insertMember(vo);
		
		List<AuthVO> authList = new ArrayList<>();
		AuthVO auth1 = new AuthVO();
		AuthVO auth2 = new AuthVO();
		auth1.setMemID(vo.getMemID());
		auth1.setAuth("ROLE_READ_ESPA");
		auth2.setMemID(vo.getMemID());
		auth2.setAuth("ROLE_READ_BTS");
		authList.add(auth1);
		authList.add(auth2);
		
	/** JAVA9 이상에서 지원: List.of(..) 
		List<AuthVO> authList = List.of(
			new AuthVO(vo.getMemID(), "ROLE_READ_ESPA"),
			new AuthVO(vo.getMemID(), "ROLE_READ_BTS")
		);
	*/
		for(AuthVO authvo : authList) {
			memMapper.insertAuth(authvo);
		}
		log.info(vo);
	}
	
	
	@Test
	public void checkDuplicateMemID() {
		int vo = memMapper.checkDuplicate("karina");
		log.info(vo);
	}
	
	//@Test
	public void login() {
		Member vo = memMapper.login("winter");
		log.info(vo);
	}
	
}
