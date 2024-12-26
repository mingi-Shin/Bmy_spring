package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;

public interface BoardService {

	public List<Board> getList();
	public void register(Board vo);
	public Board get(Long boardIdx);
	public void delete(Long boardIdx);
	public void update(Board vo);
	public List<Board> getList(String writer);
	
}
