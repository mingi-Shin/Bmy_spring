package kr.mingi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.mingi.entity.Board;
import kr.mingi.entity.Member;
import kr.mingi.mapper.BoardMapper;

/**
 * 기존의 방법 (= controller에서 mapper를 Autowired하여 로직을 구성했단 방법)
 * 	은 유지보수, 가독성, 트랜잭션 관리측면에서 효율이 떨어진다.
 *	따라서 좀더 작게 쪼개서 비즈니스로직을 전담하려고 만든게 Service단 
 *	
 *	보통 구현 순서: DB-> Mapper, XML -> Service, SErviceImpl -> Controller -> jsp 
 * */

@Service //servlet-context.xml에 없으니까 어노테이션 추가  
public class BoardServiceImpl implements BoardService { // 구현(implementation)
	
	@Autowired
	private BoardMapper boardMapper; //생성했던 mapper 클래스 연결해주구 
	

	@Override
	public List<Board> getBoardList() {
		//반영할 로직~~~ 
		List<Board> boardList = boardMapper.getBoardList();
		
		return boardList; //return 값은 이제 컨트롤러에서 쓰일거에요. 
	}


	@Override
	public void insertBoard(Board vo) {
		boardMapper.insertBoard(vo);
	}


	@Override
	public Member login(Member vo) {
		Member member = boardMapper.login(vo);
		return member;
	}


	@Override
	public void register(Board vo) {
		boardMapper.insertSelectKey(vo);
	} 

	
}

