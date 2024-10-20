package kr.mingi.mapper;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.mingi.entity.Board;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Log4j
@ExtendWith(SpringExtension.class) //JUnit5에서 스프링 기능 사용하기 
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //사전 환경설정 실행  
class BoardMapperTest {
	
	@Autowired
	private BoardMapper boardMapper; //root-config에 스캔되고 있는지 확인 
	
	//@Test
	public void testGetList() {
		List<Board> boardList = boardMapper.getBoardList();
		for(Board vo : boardList) {
			log.info(vo);
		}
	}
	
	@Test
	public void insertBoard() {
		Board vo = new Board();
		vo.setMemID("jijel");
		vo.setTitle("testTitleJijel");
		vo.setContent("testContentJijel");
		vo.setWriter("지젤");
		boardMapper.insertSelectKey(vo);
		log.info(vo);
	}
	
	

}
