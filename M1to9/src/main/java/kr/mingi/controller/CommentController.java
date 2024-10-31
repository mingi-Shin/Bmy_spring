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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.mingi.entity.Comment;
import kr.mingi.service.CommentService;
import kr.mingi.service.MemberService;

@RequestMapping("/comment")
@RestController
public class CommentController {

	@Autowired
	private CommentService commService;
	
	@Autowired
	private MemberService memService;
	
	// 댓글 리스트 (sortOrder에 따라 오름,내림차순) 
// 댓글은 SSR보다는 CSR으로 하자
/**
	@GetMapping("/list/{boardIdx}")
	public String getCommentList(@RequestParam(defaultValue="ASC")String sortOrder, @PathVariable int boardIdx, Model model) {
		List<Comment> commList = commService.getCommentList(boardIdx, sortOrder);
		model.addAttribute("commList", commList);
		return "board/getBoard";
		}
*/

	@GetMapping("/list")
	//@ResponseBody //Spring MVC가 서버에서 처리한 Java 객체를 JSON 형식으로 변환하여 클라이언트(예: AJAX 요청을 보내는 JavaScript)에게 반환
	public List<Comment> getCommentList(@RequestParam(defaultValue="ASC")String sortOrder, @RequestParam int boardIdx){
		List<Comment> commList = commService.getCommentList(boardIdx, sortOrder);
		return commList;
	}
	
	@PutMapping("/register")
	public String insertComment(@ModelAttribute Comment vo) {
		
		return "redirect:/comment/list/" + vo.getBoardIdx();
	}
}
