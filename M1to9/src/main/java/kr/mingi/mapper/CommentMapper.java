package kr.mingi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.mingi.entity.Comment;

@Mapper
public interface CommentMapper {

	public List<Comment> getCommentList(int boardIdx); //테이블 하나에 대한 모든 댓글 
	
	public int getCommentLevel(int commentIdx); //대댓글 작성시 부모댓글 Level확인 겸
	
	public void insertComment(Comment vo);
	
	public void updateComment(Comment vo);
	
	public void deleteComment(int commentIdx);
	
	
}
