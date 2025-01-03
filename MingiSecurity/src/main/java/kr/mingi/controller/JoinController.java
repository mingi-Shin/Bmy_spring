package kr.mingi.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.mingi.DTO.JoinDTO;
import kr.mingi.service.JoinService;

@RestController
public class JoinController {
	
	private final JoinService joinService;
	
	public JoinController(JoinService joinService) {
		this.joinService = joinService;
	}
	
	@PostMapping("/join")
	public String joinProc(JoinDTO joinDTO) {
		
		joinService.joinProc(joinDTO);
		
		return "join-okay";
	}
	
	

}
