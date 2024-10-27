package kr.mingi.service;

import java.util.List;

import kr.mingi.entity.Board;

public interface BoardService {
	
	public List<Board> getBoardList();
	
	public Board getTheBoard();

}
