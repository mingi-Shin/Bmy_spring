package kr.mingicom.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.mingicom.entity.Board;
import kr.mingicom.entity.Member;

@Mapper //- Mybatis API
public interface MemberMapper {	 
	
	public Member memCheckDuple(String memID);
     
	public int register(Member vo); //회원등록(1->성공, 0->실패)
     
}
