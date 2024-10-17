package kr.mingi.mapper;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.log4j.Log4j;

@Log4j
@ExtendWith(SpringExtension.class) //JUnit5에서 스프링 기능 사용하기 
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-config.xml") //사전 환경설정 실행  
class DataSourceTest {
	
	@Autowired
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		try(Connection conn = dataSource.getConnection()) {
			log.info(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

}
