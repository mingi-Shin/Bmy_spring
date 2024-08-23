package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.security.auth.login.LoginContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController{	// new BoardController();
	
	@Autowired
	private BoardMapper mapper; //DI
	
	@RequestMapping("/")
	public String main() {
		 
		return "main";
	}
//	
//	// @ResponsBody -> jackson-databind 모듈(Java객체 -> JSON)
//	@RequestMapping("/boardList.do")
//	public @ResponseBody List<Board> boardList() {
//		List<Board> list = mapper.getLists();
//		
//		return list; // JSON 데이터 형식으로 변환(jackson API)할 것이다.
//	}
//	
//	@PostMapping("/boardInsert.do")
//	public @ResponseBody void boardInsert(Board vo) {
//		mapper.boardInsert(vo); // 등록성공
//		
//		//return 할 거 없고 @ResponseBody가 있으므로 제어권이 success로 넘어감
//	}
//	
//	@GetMapping("/boardDelete.do")
//	public @ResponseBody void boardDelete(int idx) {
//		mapper.boardDelete(idx);
//		
//	}
//	
//	@PostMapping("/boardUpdate.do")
//	public @ResponseBody void boardUpdate(Board vo) {
//		mapper.boardUpdate(vo);
//	}
//	
//	@GetMapping("/boardContent.do")
//	public @ResponseBody Board boardContent(int idx) {
//		
//		mapper.boardCount(idx); //1. 조회수 증가 
//		Board vo = mapper.boardContent(idx); //2. 게시물 가져오기 
//		
//		return vo;
//	}
//	
}
