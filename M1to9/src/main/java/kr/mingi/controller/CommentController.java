package kr.mingi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.mingi.entity.Comment;
import kr.mingi.service.CommentService;

@RequestMapping("/comment")
@Controller
public class CommentController {

	@Autowired
	private CommentService commService;
	
	// 댓글 리스트 (sortOrder에 따라 오름,내림차순) 
	@GetMapping("/list/{boardIdx}")
	public String getCommentList(@RequestParam(defaultValue="ASC")String sortOrder, @PathVariable int boardIdx, Model model) {
		List<Comment> commList = commService.getCommentList(boardIdx, sortOrder);
		model.addAttribute("voList", commList);
		return "board/getBoard";
	}
	
	@PutMapping("/register")
	public String insertComment(@ModelAttribute Comment vo) {
		
		return "redirect:/comment/list/" + vo.getBoardIdx();
	}
}
