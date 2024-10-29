package kr.mingi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.mingi.entity.Board;
import kr.mingi.service.BoardService;

@RestController //  @ResponsBody 생략 가능 
@RequestMapping("/asynchBoard/*")
public class AsyncBoardController {
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/viewPage") //RestController라서 view를 수동생성해서 return해줬다. 
	public ModelAndView viewPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/asynchBoard");
		//mav.addObject("msgBody", "비동기 게시판에 접속하셨습니다." );
		return mav;
	}

	@GetMapping("/list")
	public List<Board> getBoardList() {
		List<Board> boardList = boardService.getBoardList();
		return boardList;
	}
	
	@PostMapping("board/new")
	public void insertBoard(@ModelAttribute Board vo) {
		boardService.insertBoard(vo);
	}
	
	//상세보기
	@GetMapping("/board/{boardIdx}")
	public Board getTheBoard(@PathVariable int boardIdx) {
		boardService.updateCount(boardIdx);
		Board vo = boardService.getTheBoard(boardIdx);
		return vo;
	}
	
	@PutMapping("/board/update")
	public void updateBoard(@RequestBody Board vo) {
		// @RequestBody : 클라이언트가 보낸 HTTP 요청 본문에 있는 데이터를 자바 객체로 변환하는 데 사용됩니다. 
		//   이는 주로 JSON, XML 등의 형식으로 전송된 데이터를 자바 객체로 매핑할 때 사용됩니다.
		boardService.updateBoard(vo);
	}
	
	
	@DeleteMapping("board/{boardIdx}")
	public void deleteBoard(@PathVariable int boardIdx) {
		boardService.deleteBoard(boardIdx);
	}
	
	
	/**
	 * Form의 serialize() 방식
		serialize()를 사용하여 데이터를 넘기는 경우, 기본적으로 application/x-www-form-urlencoded 형태로 인코딩된 데이터를 전송합니다. 
		이런 경우 Spring Controller에서 별도의 @RequestBody 어노테이션 없이 @ModelAttribute나 개별 파라미터로 받을 수 있습니다. 
		생성 메서드에서는 이런 방식으로 주로 데이터를 전달하므로 @RequestBody가 필요하지 않습니다.
	  
	  
	  JSON.stringify() 방식
		수정 요청에서 "title" : newTitle 형식으로 JSON을 직렬화(JSON.stringify())하여 전송하면, 이는 application/json 형태의 데이터가 됩니다. 이 경우, Spring에서 해당 JSON 데이터를 매핑하기 위해 @RequestBody가 필요합니다. @RequestBody를 붙여야 JSON 데이터를 Java 객체로 매핑할 수 있기 때문에 수정 메서드에는 @RequestBody가 필요한 것입니다.
	 * */
}
