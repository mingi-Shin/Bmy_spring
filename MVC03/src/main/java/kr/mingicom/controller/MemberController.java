package kr.mingicom.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingicom.entity.Member;
import kr.mingicom.mapper.MemberMapper;

@RequestMapping("/member")
@Controller
public class MemberController {

	@Autowired
	private MemberMapper memMapper;
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		
		return "member/join";
	};
	
	@RequestMapping("/checkDuple.do")
	@ResponseBody
	public int memCheckDuple(@RequestParam ("memID") String memID) {
		Member vo = memMapper.memCheckDuple(memID);
		
		if(vo != null || memID.equals("")) {
			//사용 불가능한 아이디
			return 0;
		} else {
			//사용 가능한 아이디
			return 1;
		}
	}
	
	@RequestMapping("/memRegister.do")
	public String memRegister(Member m, RedirectAttributes rttr, HttpSession session) {
		System.out.println("member: " + m);
		// 회원가입 실패 (서버 사이드 검증) 
		if(m.getMemID() == null || m.getMemID().equals("") || 
			m.getMemPassword() == null || m.getMemPassword().equals("") ||
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemAge() == 0 || 
			m.getMemGender() == null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("") ) {
			
			//누락메세지를 가지고 가기 => 객체바인딩(Model, HttpServletRequest, HttpSession)은 jsp에 하는데.. 어떡하지?
			rttr.addFlashAttribute("msgType", "메시지 누락 발생");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/member/memJoin.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		m.setMemProfile(""); //사진이미지는 없다는 의미 -> "" (안그러면 null이 들어가니까 공백으로 넣어주자.)
		
		// 가입성공 : 회원을 테이블에 저장
		int result = memMapper.register(m);
		
		if(result == 1) { //회원가입 성공
			//회원가입 성공하면 바로 로그인 처리해주기
			session.setAttribute("loginM", m); //${!empty loginM}
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "가입 실패");
			rttr.addFlashAttribute("msg", "회원가입에 실패하였습니다");
			return "redirect:/member/memJoin.do";
		}
	}
	
}
