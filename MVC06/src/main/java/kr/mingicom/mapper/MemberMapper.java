package kr.mingicom.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.RequestParam;

import kr.mingicom.entity.AuthVO;
import kr.mingicom.entity.Board;
import kr.mingicom.entity.Member;

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
