package com.mingi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mingi.entity.AuthVO;
import com.mingi.entity.Member;

@Mapper //- Mybatis API
public interface MemberMapper {	 
	
	public Member memCheckDuple(String memID);
     
	public int register(Member vo); //회원등록(1->성공, 0->실패)
	
	public Member login(String username);
	
    public int memUpdate(Member vo);
    
    public List<Member> getMemberList();
    
    public Member getTheMember(String memID);

	public int updateProfile(Member vo);

	public void insertAuth(AuthVO saveVO);
	
	public List<AuthVO> getAuths(String memID);
    
     
}
