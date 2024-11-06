package kr.mingi.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.entity.Member;

public interface MemberService {

	public boolean register(Member vo); 
	
	public int checkDuplicate(String memID); 
	
	public void updateMemImage(HttpServletRequest request, RedirectAttributes rttr) throws IOException;
	
	public boolean updateMemInfo(Member vo, RedirectAttributes rttr);
	
	
	
	
}
