package kr.bit.controller;

import java.util.Collection;
import java.util.Iterator;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



/**
 * 유미의 Security 강의를 토대로 코딩 
 * 
 * */
@RequestMapping("/yummi")
@Controller
public class YummiController {

	@GetMapping("/main")
	public String yummiMain(Model model) {
		
		Authentication userInfo = SecurityContextHolder.getContext().getAuthentication();
		model.addAttribute("userInfo", userInfo);

		Collection<? extends GrantedAuthority> authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		Iterator<? extends GrantedAuthority> iter = authorities.iterator();
		GrantedAuthority auth = iter.next();
		String role = auth.getAuthority();
		model.addAttribute("role", role);

		Object Credentials = SecurityContextHolder.getContext().getAuthentication().getCredentials();
		model.addAttribute("Credentials", Credentials);
		
		Object details = SecurityContextHolder.getContext().getAuthentication().getDetails();
		model.addAttribute("details", details);
		
		String name = SecurityContextHolder.getContext().getAuthentication().getName();
		model.addAttribute("name", name);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		model.addAttribute("principal", principal);
		
		
		return "yummi/yummiMain";
	}
	
	
}
