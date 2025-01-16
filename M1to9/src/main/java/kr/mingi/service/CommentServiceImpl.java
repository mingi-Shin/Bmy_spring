package kr.mingi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import kr.mingi.common.BusinessException;
import kr.mingi.entity.Comment;
import kr.mingi.mapper.CommentMapper;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private CommentMapper commMapper;

	//해당 게시물 댓글 리스트 
	@Override
	public List<Comment> getCommentList(int boardIdx, String sortOrder) {
		try {
			List<Comment> commList= commMapper.getCommentList(boardIdx, sortOrder);
			return commList;
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
	public void insertComment(Comment vo) {
		try {
			if(vo.getParentIdx() == null) { //최상위 부모 댓글: parentIdx=null, Group에 CommentIdx 대입 for 댓글리스트 묶음 정렬
				commMapper.insertComment(vo);
				// mapper에서 RETURNING 된 commentIdx 확인
				System.out.println("Generated commentIdx: " + vo.getCommentIdx());
				commMapper.updateCommentGroup(vo);
			} else {
				// 최상위 댓글이 아닌 자손댓글들 
				commMapper.insertComment(vo); //2차 이후 댓글 
			}
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
	public void updateComment(Comment vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteComment(int commentIdx) {
		// TODO Auto-generated method stub
		
	}


}
