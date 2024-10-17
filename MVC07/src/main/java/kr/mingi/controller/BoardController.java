package kr.mingi.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mingi.entity.Board;
import kr.mingi.service.BoardService;
import kr.mingi.service.BoardServiceImpl;

@Controller //POJO
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService boardService; //부모타입으로 자식타입 메서드 호출 가능하니까.. 상식이지? 

	@GetMapping("/list")
	public String getList(Model model) {
		List<Board> list = boardService.getBoardList();
		model.addAttribute("boardList", list);
		
		return "/board/boardList";
	}
}
