package kr.mingi.mapper;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.mingi.config.RootConfig;
import lombok.extern.log4j.Log4j;

@Log4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {RootConfig.class})
public class CommentTest {

	@Autowired
	private CommentMapper commMapper;
	
	@Test
	public void insert() {
		
	}
}
