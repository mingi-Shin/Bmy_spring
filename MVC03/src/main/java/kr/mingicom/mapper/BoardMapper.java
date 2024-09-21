package kr.mingicom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.mingicom.entity.Board;
import kr.mingicom.entity.Member;

@Mapper //- Mybatis API
public interface BoardMapper {	 
	
     public List<Board> getLists();
     
     public void boardInsert(Board vo);
     
     public Board boardContent(int idx);
     
     public void boardCount(int idx);
     
     public void boardDelete(int idx);
     
     public void boardUpdate(Board vo);

     
}
