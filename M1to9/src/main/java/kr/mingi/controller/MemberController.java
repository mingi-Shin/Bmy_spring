package kr.mingi.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
	
	@GetMapping("/memImageForm.do")
	public String memImageFrom() {
		return "member/memImageForm";
	}
	
	//multipart/form-data 형식의 요청에서는 파일을 처리하기 위해서는 MultipartHttpServletRequest로 형변환하여 사용하는 것이 일반적
	@PostMapping("/updateMemImage.do")
	public String updateMemImage(HttpServletRequest request, RedirectAttributes rttr) {
		System.out.println("controller 실행 ");
       try {
            memberService.updateMemImage(request, rttr);
    		System.out.println("controller 종료 ");
            return "redirect:/";
        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("msgTitle", "프로필 업로드 실패");
            rttr.addFlashAttribute("msgBody", "파일 업로드 중 오류가 발생했습니다.");
            return "redirect:/member/memImageForm.do";
        }
	}
	
	
	
}
