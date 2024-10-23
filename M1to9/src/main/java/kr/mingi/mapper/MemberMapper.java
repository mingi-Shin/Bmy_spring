package kr.mingi.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.mingi.entity.AuthVO;
import kr.mingi.entity.Member;

@Mapper //- Mybatis API
public interface MemberMapper {	 
	
	public void insertMember(Member vo);
	public void insertAuth(AuthVO vo);
	
	public int checkDuplicate(String memID); //Member로 받지않고 유/무 편하게 boolean으로 
	
	public Member login(String username);
    
     
}
