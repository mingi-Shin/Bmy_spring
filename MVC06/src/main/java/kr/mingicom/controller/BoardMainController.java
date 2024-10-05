package kr.mingicom.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class BoardMainController {

	@RequestMapping("/boardMain.do")
	public String boardMain(HttpSession session, RedirectAttributes rttr) {
		System.out.println(session.getAttribute("loginM")); //로그인확인 
		if(session.getAttribute("loginM") == null) {
			rttr.addFlashAttribute("msgType", "게시판 조회 불가");
	        rttr.addFlashAttribute("welcome", "로그인을 진행해주세요.");
	        
	        return "redirect:/member/memLoginForm.do";
		}
		return "/board/boardList01";
	}
	
	@GetMapping("/access-denied")
	public String showAccessDenied() {
		return "access-defnied";
	}
}
