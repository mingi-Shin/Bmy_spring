package kr.mingicom.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.mingicom.entity.AllMixedVO;
import kr.mingicom.entity.AuthVO;
import kr.mingicom.entity.Member;
import kr.mingicom.mapper.MemberMapper;

@RequestMapping("/member")
@Controller
public class MemberController {

	@Autowired
	MemberMapper memMapper;
	
	// mvc05 추가
	@Autowired
	PasswordEncoder pwEncoder;
	
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
			m.getMemEmail() == null || m.getMemEmail().equals("")  ||
			m.getAuthList().size() == 0	) {
			
			//누락메세지를 RedirectAttributes 인스턴스에 add => 
			rttr.addFlashAttribute("msgType", "회원가입 실패");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/member/memJoin.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		if(m.getMemPassword() == null || m.getMemPassword().equals("") ||
			!memPassword1.equals(memPassword2)  ) {
			
			rttr.addFlashAttribute("msgType", "회원가입 실패");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
			
			return "redirect:/member/memJoin.do"; 
		}
		m.setMemProfile(""); //사진이미지는 없다는 의미 -> "" (안그러면 null이 들어가니까 공백으로 넣어주자.)
		
		// 가입조건 완료 -> 테이블에 저장: 
		// mvc05추가: 비밀번호를 암호화 해주기 (spring API: PasswordEncoder())
		String encryptedPw = pwEncoder.encode(m.getMemPassword());
		m.setMemPassword(encryptedPw);
		
		int result = memMapper.register(m);
		
		if(result == 1) { //회원가입 성공: ruturn값은 해당 쿼리에 의해 영향받은 행의 수가 반환됨, 따라서 1 .. 
			
			//mvc05추가: 권한테이블에 회원권한 n개 저장
			List<AuthVO> list = m.getAuthList(); //authList[0].auth 로 넘겨받았음 
			for(AuthVO authVO : list) {
				if(authVO.getAuth() != null) {
					AuthVO saveVO = new AuthVO();
					saveVO.setMemID(m.getMemID());
					saveVO.setAuth(authVO.getAuth());
					memMapper.insertAuth(saveVO);
				}
			}
			
			
			//회원가입 성공하면 => 가입정보 다시 가져와서 로그인처리 
			//mvc05추가: 로그인에 회원정보 + 권한정보까지 설정 (getTheMember()의 mapper를 수정함)
			m = memMapper.getTheMember(m.getMemID());
			System.out.println("m: " + m);
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
		Member mvo = memMapper.login(m.getMemID()); //mvc05수정: memID로 회원정보+권한정보를 mvo에 대입
		System.out.println("mvo: " + mvo);
		
		//mvc05 추가: 암호화된 비밀번호 일치여부 체크 -> .matches(입력값, DB저장값)
		if(mvo != null && pwEncoder.matches(m.getMemPassword(), mvo.getMemPassword())) {
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
	public String memUpdateForm(HttpSession session, RedirectAttributes rttr) {
		System.out.println(session.getAttribute("loginM")); //로그인확인 
		if(session.getAttribute("loginM") == null) {
			rttr.addFlashAttribute("msgType", "회원 정보 수정 불가");
	        rttr.addFlashAttribute("welcome", "로그인을 진행해주세요.");
	        
	        return "redirect:/member/memLoginForm.do";
		}
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
			
			rttr.addFlashAttribute("msgType", "정보수정 실패");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
			
			return "redirect:/member/memUpdateForm.do"; // ${smgType}, ${msg} 사용가능, Flash니까 한번만 가능
		}
		
		// 수정성공 : 회원을 테이블에 저장
		int result = memMapper.memUpdate(m);
		
		if(result == 1) { 
			//수정 성공하면 바로 로그인 처리
			//Member vo = memMapper.showTheMember(m.getMemID());
			//위에서 업데이트 했으니까 그냥 가져오자, BUT 프로필사진을 위해 따로 맵퍼를 또 부르면 리소스낭비. 차라리 input에 hidden으로 받아오자. 중요한 정보는 아니니까. 
			
			session.setAttribute("loginM", m); //${!empty loginM}
			System.out.println("m: " + m);
			
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
	public String memImageform(HttpSession session, RedirectAttributes rttr) {
		System.out.println(session.getAttribute("loginM")); //로그인확인 
		if(session.getAttribute("loginM") == null) {
			rttr.addFlashAttribute("msgType", "프로필 사진 수정 불가");
	        rttr.addFlashAttribute("welcome", "로그인을 진행해주세요.");
	        
	        return "redirect:/member/memLoginForm.do";
		}
		return "member/memImageForm";
	}
	
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr, HttpSession session) throws IOException {
	    MultipartRequest multi = null; 
	    int fileMaxSize = 10 * 1024 * 1024; // 10MB
	    String savePath = request.getRealPath("resources/upload"); 
	    System.out.println(savePath); 
	    
	    try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
	    } catch (Exception e) {
	        e.printStackTrace();
	        rttr.addFlashAttribute("msgType", "회원사진 업로드 실패");
	        rttr.addFlashAttribute("welcome", "파일의 크기는 10 MB를 넘을 수 없습니다");
	        // return이 안되는 이유: 톰캣서버가 용량을 처리하지 못하고 인터넷을 끊어버리고 있음 
 			//	-> server.xml에서 maxSwallowSize="-1" 리미트해제 코드 추가 필요
	        return "redirect:/member/memImageForm.do";
	    }
	    
	    //폴더에 저장
	    String memID = multi.getParameter("memID"); 
	    File file = multi.getFile("memProfile"); 
	    String newProfile = null; 
	    
	    if (file != null) { 
	        String ext = file.getName().substring(file.getName().indexOf(".") + 1).toUpperCase();
	        if (ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF") || ext.equals("JPEG")) {
	        	//새로 업로드된 이미지와 DB의 기존이미지 교환
				// 1. DB의 예전프로필 조회, 삭제 
	        	String oldProfile = memMapper.getTheMember(memID).getMemProfile(); 
	            File oldFile = new File(savePath + "/" + oldProfile); 
	            
	            if (oldFile.exists()) {
	                oldFile.delete();
	            }
	            
	            // 새로운 파일 이름 생성: 동일한 이름의 사진을 업로드할 경우에도 파일 이름이 중복되지 않게 처리(1)
	            String newFileName = System.currentTimeMillis() + "_" + file.getName(); 
	            File newFile = new File(savePath + "/" + newFileName);
	            
	            // 파일 이름 변경: 동일한 이름의 사진을 업로드할 경우에도 파일 이름이 중복되지 않게 처리(2)
	            if (!file.renameTo(newFile)) {
	                rttr.addFlashAttribute("msgType", "회원사진 업로드 실패");
	                rttr.addFlashAttribute("welcome", "파일 이름 변경에 실패했습니다.");
	                return "redirect:/member/memImageForm.do";
	            }
	            // 파일 이름 변경: 동일한 이름의 사진을 업로드할 경우에도 파일 이름이 중복되지 않게 처리(2)
	            
	            // URL로 인코딩된 파일 이름 저장 	
	            newProfile = URLEncoder.encode(newFileName, "UTF-8");
	        } else {
	            if (file.exists()) { //이미지아니다! 도로 삭제
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
	    Member newVo = memMapper.getTheMember(memID);
	    session.setAttribute("loginM", newVo);
	    
	    rttr.addFlashAttribute("msgType", "회원사진 업로드 성공");
	    rttr.addFlashAttribute("welcome", "회원 프로필을 성공적으로 업로드 하였습니다");
	    return "redirect:/";
	}



	
	
	
	
}
