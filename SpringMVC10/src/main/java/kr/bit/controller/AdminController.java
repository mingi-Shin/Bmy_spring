package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin/*")
@Controller
public class AdminController {

	@GetMapping("/main")
	public String main() {
		
		return "admin/main"; // view값에/admin하게되면 //가 중복돼서 오류 발생
	}
}
