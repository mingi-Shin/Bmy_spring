package kr.bit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.web.server.SecurityWebFiltersOrder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
	
/** 커스텀 로그아웃(Get)
	@GetMapping("/logoutProc")
	public String logout(HttpServletRequest req, HttpServletResponse res) throws Exception {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(authentication != null) {
			new SecurityContextLogoutHandler().logout(req, res, authentication);
		}
		return "rediret:/";
	}
*/	
	
}
