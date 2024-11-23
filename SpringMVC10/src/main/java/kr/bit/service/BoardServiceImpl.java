package kr.bit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardRepository boardRepository;

	@Override
	public List<Board> getList() {
		List<Board> list = boardRepository.findAll();
		return list;
	}

	@Override
	public void register(Board vo) {
		boardRepository.save(vo);
	}

	@Override
	public Board get(Long boardIdx) {
		Optional<Board> vo =  boardRepository.findById(boardIdx);
		return vo.get(); // Optional은 뭐고 왜 get이 붙지?
				
	}

	@Override
	public void delete(Long boardIdx) {
		boardRepository.deleteById(boardIdx);
	}

}
