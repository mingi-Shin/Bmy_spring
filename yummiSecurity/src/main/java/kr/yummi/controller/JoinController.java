package kr.yummi.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.yummi.dto.joinDTO;
import kr.yummi.service.JoinService;


@RestController
public class JoinController {

	private final JoinService joinService; // final: 불변성 보장 
	
	public JoinController(JoinService joinService) {
		this.joinService = joinService;
	}
	
	@PostMapping("/join")
	public String joinProc(joinDTO joinDTO) {
		
		joinService.joinProc(joinDTO);
		
		return "join-ok";
	}
}
