package kr.mingicom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardMainController {

	@RequestMapping("/boardMain.do")
	public String boardMain() {
		return "/board/boardList01";
	}
}
