package kr.mingi.service;

import java.util.List;

import kr.mingi.entity.Board;
import kr.mingi.entity.Member;


public interface BoardService {

	public List<Board> getBoardList(); 
	
	public void insertBoard(Board vo);
	
	public Member login(Member vo);
	
	public void register(Board vo);
	
}
