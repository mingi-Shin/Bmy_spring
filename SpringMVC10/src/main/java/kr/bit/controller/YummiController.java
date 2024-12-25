package kr.bit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 유미의 Security 강의를 토대로 코딩 
 * 
 * */
@RequestMapping("/yummi/*")
@Controller
public class YummiController {

	@GetMapping("/main")
	public String yummiMain() {
		return "yummi/yummiMain";
	}
}
