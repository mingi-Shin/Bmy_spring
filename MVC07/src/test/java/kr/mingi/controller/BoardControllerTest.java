package kr.mingi.controller;


import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j2;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration // 뷰리졸버, 핸들러매핑 등 Spring MVC 구성요소들이 포함된 WebApplicationContext를 가상으로 설정해주는 역할 
public class BoardControllerTest {
	
	@Autowired
	private WebApplicationContext ctx; //Spring Container 메모리공간 확보 
	
	private MockMvc mockMvc; // 가상의 MVC환경을 만들어준다 
	
	@BeforeEach //Junit4의 Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				);
	}
	
	@Test
	public void testIndex() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/"))
				.andReturn()
				.getModelAndView()
				);
		
	}
	

}

/**
 * perform() -> 컨트롤러에게 요청 날리는 메서드 
 * MockMvcRequestBuilders. -> 가상의 HTTP 요청을 생성 (get, post, 등등)
 * */
