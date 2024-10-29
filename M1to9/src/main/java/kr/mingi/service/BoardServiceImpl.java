package kr.mingi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.common.BusinessException;
import kr.mingi.entity.Board;
import kr.mingi.entity.Member;
import kr.mingi.mapper.BoardMapper;
import kr.mingi.mapper.MemberMapper;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<Board> getBoardList() {
		try {
			List<Board> boardList = boardMapper.getBoardList();
			return boardList;
		} catch (DataAccessException e) { // DB관련오류 
			log.error("DB접근 중 오류 발생", e);
			throw new BusinessException("데이터 조회 중 오류가 발생헀습니다.");
		} catch (BusinessException e) {
	        log.error("로직처리 중 오류 발생", e);
	        throw new BusinessException("비지니스 로직 처리 중 오류가 발생헀습니다."); 
		} catch (Exception e) {
			log.error("예기치 못한 오류 발생", e); // 기타 비즈니스 로직 오류: 범용 
	        throw new BusinessException("예기치 못한 오류가 발생했습니다."); // 예외 발생
		}
		
	}

	@Override
	public Board getTheBoard(int boardIdx) {
		try {
			Board boardVO = boardMapper.getTheBoard(boardIdx);
			
			if(boardVO == null) {
				throw new BusinessException("해당 게시글이 존재하지 않습니다.");
			}
			return boardVO;
		} catch (DataAccessException e) { // DB관련오류 
			log.error("DB접근 중 오류 발생", e);
			throw new BusinessException("데이터 조회 중 오류가 발생헀습니다.");
		} catch (BusinessException e) {
	        log.error("로직처리 중 오류 발생", e);
	        throw new BusinessException("비지니스 로직 처리 중 오류가 발생헀습니다."); 
		} catch (Exception e) {
			log.error("예기치 못한 오류 발생", e); // 기타 비즈니스 로직 오류: 범용 
	        throw new BusinessException("예기치 못한 오류가 발생했습니다."); // 예외 발생
		}
	}

	@Override
	public void insertBoard(Board vo) {
		//입력검증
		if(vo.getTitle() == null || vo.getContent() == null) {
			throw new BusinessException("제목과 내용을 모두 입력해야 합니다.");
			//... 더 추가하던가
		}
		try {
			boardMapper.insertBoard(vo);
		} catch (DataAccessException e) { // DB관련오류 
			log.error("DB접근 중 오류 발생", e);
			throw new BusinessException("데이터 조회 중 오류가 발생헀습니다.");
		} catch (BusinessException e) {
	        log.error("로직처리 중 오류 발생", e);
	        throw new BusinessException("비지니스 로직 처리 중 오류가 발생헀습니다."); 
		} catch (Exception e) {
			log.error("예기치 못한 오류 발생", e); // 기타 비즈니스 로직 오류: 범용 
	        throw new BusinessException("예기치 못한 오류가 발생했습니다."); // 예외 발생
		}
	}

	@Override
	public void deleteBoard(int boardIdx) {
		try {
			boardMapper.deleteBoard(boardIdx);
		} catch (DataAccessException e) { // DB관련오류 
			log.error("DB접근 중 오류 발생", e);
			throw new BusinessException("데이터 조회 중 오류가 발생헀습니다.");
		} catch (BusinessException e) {
	        log.error("로직처리 중 오류 발생", e);
	        throw new BusinessException("비지니스 로직 처리 중 오류가 발생헀습니다."); 
		} catch (Exception e) {
			log.error("예기치 못한 오류 발생", e); // 기타 비즈니스 로직 오류: 범용 
	        throw new BusinessException("예기치 못한 오류가 발생했습니다."); // 예외 발생
		}
	}

	@Override
	public void updateBoard(Board vo) {
		try {
			boardMapper.updateBoard(vo);
		} catch (DataAccessException e) { // DB관련오류 
			log.error("DB접근 중 오류 발생", e);
			throw new BusinessException("데이터 조회 중 오류가 발생헀습니다.");
		} catch (BusinessException e) {
	        log.error("로직처리 중 오류 발생", e);
	        throw new BusinessException("비지니스 로직 처리 중 오류가 발생헀습니다."); 
		} catch (Exception e) {
			log.error("예기치 못한 오류 발생", e); // 기타 비즈니스 로직 오류: 범용 
	        throw new BusinessException("예기치 못한 오류가 발생했습니다."); // 예외 발생
		}
	}

	@Override
	public void updateCount(int boardIdx) {
		boardMapper.updateCount(boardIdx);
	}

	@Override
	public void replyProcess(Board vo) {
		// TODO Auto-generated method stub
		
	}
	
	

}
