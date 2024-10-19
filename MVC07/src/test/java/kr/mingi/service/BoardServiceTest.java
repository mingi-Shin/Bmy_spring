package kr.mingi.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.log4j.Log4j2;

@Log4j2
@ExtendWith(SpringExtension.class) //JUnit5에서 스프링 기능 사용하기 
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" //scan 패키지 이름 틀리면 bean 찾을 수 없다고 한당 
}) //테스트 전에 환경설정 실행  
class BoardServiceTest {
	
	@Autowired //보통 인터페이스를 Autowired합니다. 
	private BoardService boardService; 
	
	@Test
	public void getBoardList() {
		boardService.getBoardList().forEach(vo -> log.info(vo));
	}
	


}

