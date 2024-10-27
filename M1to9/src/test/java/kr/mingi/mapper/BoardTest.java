package kr.mingi.mapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.mingi.config.RootConfig;
import kr.mingi.entity.Board;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

@Log4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {RootConfig.class})
public class BoardTest {

	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	public void insertBoard() {
		Board vo = new Board();
		vo.setMemID("winter");
		vo.setTitle("테스트임다");
		vo.setContent("테스트내용임다");
		vo.setWriter("윈터");
		boardMapper.insertBoard(vo);
		log.info(vo);
		
	}
}
