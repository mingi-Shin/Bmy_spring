package kr.mingi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mingi.entity.Comment;
import kr.mingi.service.CommentService;

@RequestMapping("/comment")
@Controller
public class CommentController {

	@Autowired
	private CommentService commService;
	
	@GetMapping("/list/{boardIdx}")
	public String getCommentList(int boardIdx, Model model) {
		List<Comment> commList = commService.getCommentList(boardIdx);
		model.addAttribute("voList", commList);
		return "board/getBoard";
	}
	
	@PutMapping("/register")
	public String insertComment(@ModelAttribute Comment vo) {
		
		return "redirect:/comment/list/" + vo.getBoardIdx();
	}
}
