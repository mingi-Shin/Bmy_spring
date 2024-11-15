package kr.mingi.service;

import java.util.List;

import kr.mingi.entity.Comment;

public interface CommentService {
	
	public List<Comment> getCommentList(int boardIdx, String sortOrder); //해당게시판 댓글 
	
	public void insertComment(Comment vo);
	
	public void updateCommentGroup(Comment vo);
	
	public void updateComment(Comment vo);
	
	public void deleteComment(int commentIdx);
	
}
