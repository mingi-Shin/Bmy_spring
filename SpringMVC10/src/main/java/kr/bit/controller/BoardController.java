package kr.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.bit.entity.Board;
import kr.bit.service.BoardService;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public String list(Model model) {
		List<Board> list = boardService.getList();
		model.addAttribute("list", list);
		return "board/list";     // /WEB-INF/board/list.jsp
	}
	
	@GetMapping("/register")
	public String register() {
		return "register";
	}
	
	@PostMapping("/register")
	public String register(Board vo) {
		boardService.register(vo);
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	@ResponseBody
	public Board get(Long boardIdx) {
		Board vo = boardService.get(boardIdx);
		return vo;
	}
	
	@GetMapping("/remove")
	public String remove(Long boardIdx) {
		boardService.delete(boardIdx);
		return "redirect:/list";
	}
	
	@PostMapping("/modify")
	public String modify(@ModelAttribute Board vo) {
		boardService.update(vo);
		return "redirect:/board/list";
	}
	
}
