package kr.mingi.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.mingi.config.RootConfig;
import kr.mingi.config.ServletConfig;
import kr.mingi.entity.Criteria;
import lombok.extern.log4j.Log4j;

@Log4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {RootConfig.class, ServletConfig.class})
public class BoardServiceTest {

	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memService;
	
	@Test
	public void testGetList() {
		//로그인필요 
		Criteria cri = new Criteria();
		cri.setCurrentPage(1);
		cri.setPerPageNum(10);
		boardService.getBoardList(cri)
			.forEach(vo -> log.info(vo));
		
	}
}
