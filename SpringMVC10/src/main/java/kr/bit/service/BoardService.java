package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;

public interface BoardService {

	public List<Board> getList();
	public void register(Board vo);
	
}
