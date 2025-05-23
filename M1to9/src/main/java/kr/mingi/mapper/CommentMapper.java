package kr.mingi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.mingi.entity.Comment;

@Mapper
public interface CommentMapper {

	public List<Comment> getCommentList(@Param("boardIdx") int boardIdx, @Param("sortOrder") String sortOrder); 
	// 매개변수가 2개 이상일 때, @Param을 안붙이면 xml에서 #{param1}, #{param2}.. 로 받아야 한다. 
	
	public void insertComment(Comment vo);
	
	public void updateCommentGroup(Comment vo); //최상위 부모댓글 Group업뎃 
	
	public void updateComment(Comment vo);
	
	public void deleteComment(int commentIdx);
	
	
	
	
}
