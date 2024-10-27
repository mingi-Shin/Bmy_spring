package kr.mingi.service;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.entity.Board;

public interface BoardService {
	
	public List<Board> getBoardList(Model model);
	
	public Board getTheBoard(int boardIdx);
	
	public void insertBoard(Board vo);
	
	public boolean deleteBoard(int boardIdx);
	
	public boolean updateBoard(Board vo);

	/**
	 * 	위의 경우는 사실 좋지 않다고 한다.
	 * 	서비스계층에서는 예외처리를 최소한으로 해주고, 대부분 예외를 상위계층으로 전달하여 날려 
	 * 	컨트롤러나 글로벌 예외 처리에서 관리하는게 좋다구한다. (Spring의 경우, @ControllerAdvice와 @ExceptionHandler를 사용)
	 * */


}
