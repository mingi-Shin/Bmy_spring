package kr.mingi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.mingi.entity.Board;
import kr.mingi.entity.Criteria;
import kr.mingi.entity.Member;

@Mapper //- Mybatis API
public interface BoardMapper {	 
	
     public List<Board> getBoardList(Criteria cri);
     
     public Board getTheBoard(int boardIdx);
     
     public void insertBoard(Board vo);
     
     public void deleteBoard(int boardIdx);
     
     public void updateBoard(Board vo);
     
	 public void updateCount(int boardIdx);
	 
	 public int totalCount(Criteria cri);

     
}
