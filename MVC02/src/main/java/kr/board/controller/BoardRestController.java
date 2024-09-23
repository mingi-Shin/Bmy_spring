package kr.board.controller;

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

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RequestMapping("/board") //컨트롤러 클레스에도 RequestMapping어노테이션 부착 가능 
@RestController //  @ResponsBody 생략 가능 
public class BoardRestController {

	@Autowired
	private BoardMapper mapper;
	
	// @ResponsBody -> Spring의 jackson라이브러리(반환값 Java객체 -> JSON으로 변환)
	@GetMapping("/all")
	public List<Board> boardList() {
		List<Board> list = mapper.getLists();
		
		return list; // list는 RestController에 의해 JSON으로 변환되어 HTTP응답의 body에 담겨 전송된다 
	}
	
	@PostMapping("new")
	public void boardInsert(Board vo) {
		mapper.boardInsert(vo); // 등록성공
		
		//return으로 JSON값을 넘긴다면, ajax에서 dataType을 명시해줘야 해요. 
		/**
		 Spring MVC에서 데이터 바인딩:
			Spring MVC는 폼 데이터를 처리할 때, 
			POST 요청에 담긴 파라미터 이름과 Board 클래스의 필드명이 동일할 경우, Spring MVC는 이를 자동으로 바인딩
		 * */
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) { // @PathVariable : 경로변수를 받겠다는 의미 
		mapper.boardDelete(idx);
		
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board vo) { 
		mapper.boardUpdate(vo);
		//ajax에서 JS데이터를 JSON으로 바꿔서 보내줬기 때문에, 비즈니스 처리를 위해 @RequestBody를 통해 JSON을 JAVA의 Board객체로 변경 해줌 
		//@RequestBody : 클라이언트가 보낸 HTTP 요청 본문에 있는 JSON, XML 등의 형식으로 전송된 데이터를 자바 객체로 매핑할 때 사용됩니다.
	}
	
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int numb) {
		
		mapper.boardCount(numb); //1. 조회수 증가 
		Board vo = mapper.boardContent(numb); //2. 게시물 가져오기 
		
		return vo;
		//@PathVariable("idx") int numb는 URL 경로의 {idx} 값을 가져와서, 해당 값을 numb 변수에 초기화 => '경로변수' 
	}
}
