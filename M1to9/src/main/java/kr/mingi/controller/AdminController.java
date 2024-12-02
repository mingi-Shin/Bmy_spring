package kr.mingi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("/getMemberList.do")
	public String showMemberList() {
		return "/admin/showMemberList";
	}
	
	@GetMapping("/template")
	public String showTemplate() {
		return "/common/template";
	}
}
