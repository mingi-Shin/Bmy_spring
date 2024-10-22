package kr.mingi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j2;

@Controller
public class MainController {

	@GetMapping("/")
	public String main() {
		return "index";
	}
	
}
