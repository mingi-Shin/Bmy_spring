package kr.mingicom.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
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
	public String memRegister(Member m, String memPassword1, String memPassword2, RedirectAttributes rttr, HttpSession session) {
		System.out.println("member: " + m);
		System.out.println("memPassword1: " + memPassword1);
		System.out.println("memPassword2: " + memPassword2);
		
		// 회원가입 실패 (서버 사이드 검증) 
		if(m.getMemID() == null || m.getMemID().equals("") || 
			
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemAge() == 0 || 
			m.getMemGender() == null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("") ) {
			
			//누락메세지를 가지고 가기 => 객체바인딩(Model, HttpServletRequest, HttpSession)은 jsp에 하는데.. 어떡하지?
			rttr.addFlashAttribute("msgType", "회원가입 실패");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/member/memJoin.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		if(m.getMemPassword() == null || m.getMemPassword().equals("") ||
			!memPassword1.equals(memPassword2)  ) {
			
			rttr.addFlashAttribute("msgType", "회원가입 실패");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
			
			return "redirect:/member/memJoin.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		m.setMemProfile(""); //사진이미지는 없다는 의미 -> "" (안그러면 null이 들어가니까 공백으로 넣어주자.)
		
		// 가입성공 : 회원을 테이블에 저장
		int result = memMapper.register(m);
		
		if(result == 1) { //회원가입 성공: ruturn값은 해당 쿼리에 의해 영향받은 행의 수가 반환됨, 따라서 1 
			//회원가입 성공하면 바로 로그인 처리해주기
			session.setAttribute("loginM", m); //${!empty loginM}
			
			rttr.addFlashAttribute("msgType", "회원가입 성공");
			rttr.addFlashAttribute("welcome", m.getMemName() + "님 회원가입을 환영합니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "가입 실패");
			rttr.addFlashAttribute("msg", "회원가입에 실패하였습니다");
			return "redirect:/member/memJoin.do";
		}
	}
	
	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session, RedirectAttributes rttr) {
		session.invalidate(); //세션무효화
		rttr.addFlashAttribute("msgType", "로그아웃 성공");
		rttr.addFlashAttribute("welcome", "로그아웃 되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
		return "member/loginForm";
	}
	
	@RequestMapping("/memLogin.do")
	public String memLogin(HttpSession session, RedirectAttributes rttr, Member m) {
		if(m.getMemID() == null || m.getMemID().equals("") ||
				m.getMemPassword() == null || m.getMemPassword().equals("")) {
			rttr.addFlashAttribute("msgType", "로그인 실패");
			rttr.addFlashAttribute("welcome", "모든 정보를 입력해주세요.");
			return "redirect:/member/memLoginForm.do";
		}
		Member mvo = memMapper.login(m);
		
		if(mvo != null ) {
			session.setAttribute("loginM", mvo);
			rttr.addFlashAttribute("msgType", "로그인 성공");
			rttr.addFlashAttribute("welcome", mvo.getMemName() + "님 로그인을 환영합니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "로그인 실패");
			rttr.addFlashAttribute("welcome", "회원정보를 다시 한번 확인해주세요.");
			return "redirect:/member/memLoginForm.do";
		}
	}
	
	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
		return "member/memUpdateForm";
	}
	
	@RequestMapping("/memUpdate.do")
	public String memUpdate(HttpSession session, Member m, RedirectAttributes rttr, String memPassword1, String memPassword2) {
		if(m.getMemID() == null || m.getMemID().equals("") || 
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemAge() == 0 || 
			m.getMemGender() == null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("") ) {
			
			//누락메세지를 가지고 가기 => 객체바인딩(Model, HttpServletRequest, HttpSession)은 jsp에 하는데.. 어떡하지?
			rttr.addFlashAttribute("msgType", "정보수정 실패");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/member/memUpdateForm.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		if(m.getMemPassword() == null || m.getMemPassword().equals("") ||
			!memPassword1.equals(memPassword2)  ) {
			
			rttr.addFlashAttribute("msgType", "회원가입 실패");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
			
			return "redirect:/member/memUpdateForm.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		m.setMemProfile(""); //사진이미지는 없다는 의미 -> "" (안그러면 null이 들어가니까 공백으로 넣어주자.)
		
		// 수정성공 : 회원을 테이블에 저장
		int result = memMapper.memUpdate(m);
		
		if(result == 1) { 
			//수정 성공하면 바로 로그인 처리해주기
			session.setAttribute("loginM", m); //${!empty loginM}
			
			rttr.addFlashAttribute("msgType", "회원정보 수정 성공");
			rttr.addFlashAttribute("welcome", m.getMemName() + "님 회원정보가 변경되었습니다.");
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "수정 실패");
			rttr.addFlashAttribute("msg", "회원정보 수정에 실패하였습니다");
			return "redirect:/member/memUpdateForm.do";
		}
	}
}
