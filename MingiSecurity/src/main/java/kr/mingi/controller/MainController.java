package kr.mingi.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MainController {

	@GetMapping("/")
	public String main() {
		
		return "You requested a Main Page";
	}
	
	@GetMapping("/admin")
	public String board() {
		
		return "You requested a admin Page. You have ROLE_ADMIN!";
	}
}
