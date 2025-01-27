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
	
	@Test
	public void insert() {
		Comment commVO = new Comment();
		commVO.setMemID("winter");
		commVO.setMemName("윈터");
		commVO.setBoardIdx(2);
		commVO.setCommentGroup(2);
		commVO.setComment("2번 댓글의 댓글: 아이브는 잘 모르겠어"); //parentIdx = null
		commVO.setParentIdx(3); //null을 넣으려면 int가 아니라 integer해야함 
		commMapper.insertComment(commVO);
		log.info(commVO);
	}
	
	//@Test
	public void list() {
		List<Comment> commList = commMapper.getCommentList(2, "DESC");
		for(Comment vo : commList) {
			log.info(vo);
		}
		
	}
}
