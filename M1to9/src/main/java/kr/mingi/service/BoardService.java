package kr.mingi.service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.entity.Board;
import kr.mingi.entity.Criteria;
import kr.mingi.entity.Member;

public interface BoardService {
	
	public List<Board> getBoardList(Criteria cri);
	
	public Board getTheBoard(int boardIdx);
	
	public void insertBoard(Board vo);
	
	public void deleteBoard(int boardIdx);
	
	public void updateBoard(Board vo);

	public void updateCount(int boardIdx);
	
	public void replyProcess(Board vo);
	
	public int totalCount();

}
