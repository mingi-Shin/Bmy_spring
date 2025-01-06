package kr.mingi.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

	@GetMapping("/")
	public String main() {
		
		Authentication currentAuthentication = SecurityContextHolder.getContext().getAuthentication();
		
		return "MainController : " + currentAuthentication;
	}
	
	@GetMapping("/admin")
	public String board() {
		
		return "You requested a admin Page. You have ROLE_ADMIN!";
	}
	
	@GetMapping("/auth")
	public String autho() {
		
		return "you have role";
	}
}
