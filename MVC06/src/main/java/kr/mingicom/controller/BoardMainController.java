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
	public String boardMain(RedirectAttributes rttr) {
		return "/board/mainBoard";
	}
	
	@GetMapping("/access-denied")
	public String showAccessDenied() {
		return "access-denied";
	}
}
