package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class HelloController {
	
	@RequestMapping("/")
	public String hello() {
		return "index";
	}
	
	@RequestMapping("/custom-error")
	public String handlerError(HttpServletRequest request) {
		//403오류 페이지로 리디렉션
		return "error/403"; // error/403.jsp 
	}

}
