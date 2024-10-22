package kr.mingi.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.mingi.entity.AuthVO;
import kr.mingi.entity.Member;

@Mapper //- Mybatis API
public interface MemberMapper {	 
	
	public void insertMember(Member vo);
	public void insertAuth(AuthVO vo);
	
	public Member checkDuplicate(String memID);
	
	public Member login(String username);
    
     
}
