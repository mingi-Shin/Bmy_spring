package kr.bit.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * 유미의 Security 강의를 토대로 코딩 
 * 
 * */
@RequestMapping("/yummi")
@Controller
public class YummiController {

	@GetMapping("/main")
	public String yummiMain(Model model) {
		
		Authentication userInfo = SecurityContextHolder.getContext().getAuthentication();
		
		model.addAttribute("userInfo", userInfo);
		
		return "yummi/yummiMain";
	}
	
	
}
