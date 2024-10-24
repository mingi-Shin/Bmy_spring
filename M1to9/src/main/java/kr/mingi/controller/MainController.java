package kr.mingi.controller;

import javax.ws.rs.POST;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j2;

@Controller
public class MainController {

	@GetMapping("/")
	public String main() {
		return "index";
	}
	
	@PostMapping("/m019/access-denied")
	public String accessDenied() {
	    return "accessDenied"; 
	}
	
	
}
