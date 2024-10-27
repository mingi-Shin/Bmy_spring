package kr.mingi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mingi.service.BoardService;
import kr.mingi.service.MemberService;

@Controller
@RequestMapping("/synchBoard/*")
public class SyncBoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/list")
	public String getBoardList() {
		return "/board/synchBoardList";
	}
	
	
	

}
