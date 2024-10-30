package kr.mingi.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import kr.mingi.config.RootConfig;
import kr.mingi.entity.Comment;
import lombok.extern.log4j.Log4j;

@Log4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {RootConfig.class})
public class CommentTest {

	@Autowired
	private CommentMapper commMapper;
	
	//@Test
	public void insert() {
		Comment commVO = new Comment();
		commVO.setMemID("ningning");
		commVO.setBoardIdx(1);
		commVO.setComment("첫번째 댓글: 과일");
		commMapper.insertComment(commVO);
		log.info(commVO);
	}
	
	//@Test
	public void list() {
		List<Comment> commList = commMapper.getCommentList(1, "DESC");
		for(Comment vo : commList) {
			log.info(vo);
		}
		
	}
}
