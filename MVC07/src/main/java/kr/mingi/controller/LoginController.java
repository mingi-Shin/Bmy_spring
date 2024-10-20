package kr.mingi.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.mingi.entity.Member;
import kr.mingi.service.BoardService;

@Controller
@RequestMapping("/login/*")
public class LoginController {

	@Autowired
	private BoardService boardService;
	
	@PostMapping("/loginProcess")
	public String login(Member vo, HttpSession session) {
		Member mvo = boardService.login(vo);
		if(mvo != null) {
			session.setAttribute("loginM", mvo); //객체바인딩 -> ${!empty loginM}
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/logoutProcess")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/board/list";
	}
}
