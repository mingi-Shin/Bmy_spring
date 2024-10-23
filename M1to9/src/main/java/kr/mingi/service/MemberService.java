package kr.mingi.service;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.entity.Member;

public interface MemberService {

	public boolean register(Member vo, RedirectAttributes rttr); 
	
	public int checkDuplicate(String memID); 
	
}
