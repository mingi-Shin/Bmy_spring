package kr.bit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.bit.entity.Member;
import kr.bit.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@GetMapping("/register")
	public String registerPage() {
		return "member/register";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute Member member, @RequestParam("role") String role) {
		memberService.register(member, role);
		System.out.println("회원가입완료 : " + member);
		return "redirect:/member/login";
	}
}
