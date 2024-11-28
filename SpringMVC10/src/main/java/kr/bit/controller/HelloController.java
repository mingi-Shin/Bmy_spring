package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HelloController {
	
	@RequestMapping("/hello")
	public @ResponseBody String hello() {
		return "Hello Spring Boot";
	}
	
	@GetMapping("/")
    public String home() {
        return "index"; // index.html 또는 index.jsp 등
    }
	
}
