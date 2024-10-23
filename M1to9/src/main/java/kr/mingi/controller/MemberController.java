package kr.mingi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.entity.Member;
import kr.mingi.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/memRegister.do")
	public String memRegisterForm() {
		return "/member/registerForm";
	}

	@PostMapping("/register")
	public String register(Member member, RedirectAttributes rttr) {
		boolean isRegistered = memberService.register(member, rttr);
		if(isRegistered) {
			return "redirect:/";
		} else {
			return "redirect:/member/memRegister.do";
		}
	}
	
	@GetMapping("/memLoginForm.do")
	public String login() {
		return "/member/loginForm";
	}
	
	@GetMapping("/checkRegisterDuple.do")
	@ResponseBody
	public int checkRegisterDuple( @RequestParam("memID") String memID) {
		int result = memberService.checkDuplicate(memID);
		return result;
	}
}
