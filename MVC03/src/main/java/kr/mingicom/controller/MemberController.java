package kr.mingicom.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
	
	@RequestMapping("/memImageForm.do")
	public String memImageform() {
		return "member/memImageForm";
	}
	
	
	//파일 업로드 API ( 강의에서는 cos.jar 사용. 하지만 요즘 추세는 스프링 내장 라이브러리 사용  )
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr, HttpSession session) throws IOException {
		
		MultipartRequest multi = null; //MultipartRequest : 서버가 받아와서 개별 파트로 분리하여 처리
		int fileMaxSize = 10*1024*1024; //10MB
		// 우리가 생각하는 경로가 아니라 이클립스가 프로젝트를 따로 관리하는 폴더가 있다. 그 폴더의 경로를 RealPath로 정의한다.
		String savePath = request.getRealPath("resources/upload"); 
		System.out.println(savePath); //경로찾아줘봐 어휴 
				
		try {
			//프로필을 폴더에 업로드
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
			// MultipartRequest 객체 생성
			
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "회원사진 업로드 실패");
			rttr.addFlashAttribute("welcome", "파일의 크기는 10	MB를 넘을 수 없습니다"); //이거는 onKey()를 쓰는게 나을지도? 
			return "redirect:/member/memImageForm.do";
			// return이 안되는 이유: 톰캣서버가 용량을 처리하지 못하고 인터넷을 끊어버리고 있음 
			//	-> server.xml에서 maxSwallowSize="-1" 리미트해제 코드 추가 필요  
		}
		
		//폴더에 저장
		String memID = multi.getParameter("memID"); //request에서 id뽑고.. 안돼! multi쓰는 이상 request에서 파라미터 못가져와!!
		
		File file = multi.getFile("memProfile"); // multi에서 memProfile 뽑아서, file객체에 포인터 
		
		String newProfile = null; 
		
		if(file != null) { //업로드가 된 상태
			
			//확장자 체크: .png .jpg .gif, 이미지파일이 아니면 삭제 
			String ext = file.getName().substring(file.getName().indexOf(".")+1);
			ext = ext.toUpperCase();
			System.out.println(ext);
			if((ext.equals("PNG")) || (ext.equals("JPG")) || (ext.equals("GIF")) || (ext.equals("JPEG"))) {
				//새로 업로드된 이미지와 DB의 기존이미지 교환
				// 1. DB의 예전프로필 조회, 삭제 
				String oldProfile = memMapper.showTheMember(memID).getMemProfile(); //DB에 저장된 이름 
				File oldFile = new File(savePath + "/" + oldProfile); //해당 명의 파일 객체 생성 
				System.out.println(oldFile);
				
				if(oldFile.exists()) {
					oldFile.delete();
				}
				// URL로 인코딩된 새 파일 이름 저장 ()
		        newProfile = URLEncoder.encode(file.getName(), "UTF-8");
		        System.out.println("newProfile: " + newProfile);
				
			} else {
				if(file.exists()) { //이미지아니다! 도로 삭제: 혹시 개발자가 실수로 지워버렸을 수도 있어서 if문 돌림 
					file.delete();
				}
				rttr.addFlashAttribute("msgType", "회원사진 업로드 실패");
		        rttr.addFlashAttribute("welcome", "이미지 파일만 업로드가 가능합니다. ");
		        return "redirect:/member/memImageForm.do";
			}
			
			
		}
		//2. DB에 새프로필 저장 
		Member vo = new Member();
		vo.setMemID(memID);
		vo.setMemProfile(newProfile);
		memMapper.updateProfile(vo);
		
		//세션을 갱신
		Member newVo = memMapper.showTheMember(memID);
		session.setAttribute("loginM", newVo);
		
        rttr.addFlashAttribute("msgType", "회원사진 업로드 성공");
        rttr.addFlashAttribute("welcome", "회원 프로필을 성공적으로 업로드 하였습니다");
		return "redirect:/";
		
	}
	
	
	
}
