package kr.mingi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.mingi.entity.Board;
import kr.mingi.entity.Member;

//@Mapper: 생략이유? root-config에서 scan중이니까. 만약 .java에서 읽는거 할거면 MVC06 참조 
public interface BoardMapper {
	
	public List<Board> getBoardList();
	
	public void insertBoard(Board vo);
	
	public void insertSelectKey(Board vo);
	
	public Member login(Member vo);
	
	
}
