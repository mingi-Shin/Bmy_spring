package kr.mingicom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.mingicom.entity.Board;
import kr.mingicom.mapper.BoardMapper;

@RequestMapping("/board") //컨트롤러 클레스에도 RequestMapping어노테이션 부착 가능 
@RestController //  @ResponsBody 생략 가능 
public class BoardRestController {

	@Autowired
	private BoardMapper mapper;
	
	// @ResponsBody -> jackson-databind 모듈(Java객체 -> JSON)
	@GetMapping("/all")
	public List<Board> boardList() {
		List<Board> list = mapper.getLists();
		
		return list; // JSON 데이터 형식으로 변환(jackson API)할 것이다.
	}
	
	@PostMapping("new")
	public void boardInsert(Board vo) {
		mapper.boardInsert(vo); // 등록성공
		
		//view생성없이 데이터가 success로 넘어감
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) { // @PathVariable : 경로변수를 받겠다는 의미 
		mapper.boardDelete(idx);
		
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board vo) { //@RequestBody : 클라이언트가 보낸 HTTP 요청 본문에 있는 데이터를 자바 객체로 변환하는 데 사용됩니다. 이는 주로 JSON, XML 등의 형식으로 전송된 데이터를 자바 객체로 매핑할 때 사용됩니다.
		mapper.boardUpdate(vo);
	}
	
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {
		
		mapper.boardCount(idx); //1. 조회수 증가 
		Board vo = mapper.boardContent(idx); //2. 게시물 가져오기 
		
		return vo;
	}
}
