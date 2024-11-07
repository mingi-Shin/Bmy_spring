package kr.mingi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.common.BusinessException;
import kr.mingi.entity.Board;
import kr.mingi.entity.Criteria;
import kr.mingi.entity.PageMaker;
import kr.mingi.mapper.BoardMapper;
import kr.mingi.service.BoardService;
import kr.mingi.service.MemberService;

@Controller
@RequestMapping("/synchBoard/*")
public class SyncBoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/list")
	public String getBoardList(Criteria cri, Model model, RedirectAttributes rttr ) {
		List<Board> boardList = boardService.getBoardList(cri);
		model.addAttribute("vo", boardList);
		rttr.addFlashAttribute("msgBody", "동기 게시판 입장");
		
		//페이징 처리에 필요한 부분
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(boardService.totalCount());//전체 페이지의 수, makePaging()실행됨  
		model.addAttribute("pageMaker", pageMaker);
		
		
		return "/board/synchBoardList";
	}
	
	@GetMapping("/register")
	public String registerForm() {
		return "/board/register";
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
		boardService.updateCount(boardIdx); //조회수 증가 
		model.addAttribute("vo", board);
		return "/board/getBoard";
	}
	
	@DeleteMapping("/delete/{boardIdx}")
	public ResponseEntity<String> deleteBoard(@PathVariable("boardIdx") int boardIdx) {
	    try {
	        boardService.deleteBoard(boardIdx);
	        return ResponseEntity.ok("게시물이 정상적으로 삭제되었습니다.");
	    } catch (Exception e) {
	        // 예외 로깅  진짜진짜 이거 꼭 로그 표시 해야한다. 안그러면 원인 찾는데 너무 시간이 많이 들어.. 
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("게시물 삭제 중 오류 발생");
	    }
	}
	
	@GetMapping("/modify/{boardIdx}")
	public String modifyForm(@PathVariable int boardIdx, Model model) {
		Board board = boardService.getTheBoard(boardIdx);
		model.addAttribute("vo", board);
		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modifyBoard(@ModelAttribute Board vo, RedirectAttributes rttr) { //객체의 필드에 n개의 요청 파라미터 값을 자동으로 할당
		System.out.println("ModelAttribute vo: " +  vo);	
		boardService.updateBoard(vo);
		int boardIdx = vo.getBoardIdx();
		rttr.addFlashAttribute("msgBody", "게시물이 정상적으로 수정되었습니다.");
		return "redirect:/synchBoard/get/" + boardIdx;
	}
	
	
	

}
