package kr.mingi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.mingi.service.BoardService;

@RestController //  @ResponsBody 생략 가능 
@RequestMapping("/asynchBoard/*")
public class AsyncBoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/list")
	public String getBoardList() {
		return "/board/asynchBoard";
	}
	
	
	
}
