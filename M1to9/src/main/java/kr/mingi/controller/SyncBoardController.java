package kr.mingi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.common.BusinessException;
import kr.mingi.entity.Board;
import kr.mingi.service.BoardService;
import kr.mingi.service.MemberService;

@Controller
@RequestMapping("/synchBoard/*")
public class SyncBoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/list")
	public String getBoardList(Model model, RedirectAttributes rttr ) {
		List<Board> boardList = boardService.getBoardList(model);
		return "/board/synchBoardList";
	}
	
	@GetMapping("/registerForm")
	public String registerForm() {
		return "/board/registerForm";
	}
	
	@PostMapping("/register")
	public String registerBoard(@ModelAttribute Board vo, RedirectAttributes rttr) {
		boardService.insertBoard(vo);
		rttr.addFlashAttribute("msgBody", "게시물이 성공적으로 작성되었습니다.");
		return "redirect:/synchBoard/list";
	}
	
	@GetMapping("/get/{boardIdx}") // URL 경로에 boardIdx를 포함시킴
	public String getTheBoard(@PathVariable int boardIdx, RedirectAttributes rttr, Model model ) {
		Board board = boardService.getTheBoard(boardIdx);
		model.addAttribute("vo", board);
		return "/board/getBoard";
	}
	
	
	
	
	

}
