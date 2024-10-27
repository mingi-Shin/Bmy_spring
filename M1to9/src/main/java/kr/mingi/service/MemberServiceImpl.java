package kr.mingi.service;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.mingi.entity.AuthVO;
import kr.mingi.entity.Member;
import kr.mingi.entity.MemberUsers;
import kr.mingi.mapper.MemberMapper;
import kr.mingi.security.MemberUserDetailsService;
import lombok.extern.log4j.Log4j;

/**
 * 기존의 방법 (= controller에서 mapper를 Autowired하여 로직을 구성했단 방법)
 * 	은 유지보수, 가독성, 트랜잭션 관리측면에서 효율이 떨어진다.
 *	따라서 좀더 작게 쪼개서 비즈니스로직을 전담하려고 만든게 Service단 
 *	
 *	보통 구현 순서: DB-> Mapper, XML -> Service, SErviceImpl -> Controller -> jsp 
 * */
@Log4j
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memMapper;

    @Autowired
    private PasswordEncoder pwEncoder;
    
    @Autowired
    private MemberUserDetailsService memberUserDetailsService;

    // 회원가입
    @Override
    public boolean register(Member vo, RedirectAttributes rttr) {
        // 서버사이드 검증(= 2차 검증)
        try {
            validateUserInput(vo); // 입력값 검증
        } catch (IllegalArgumentException e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", e.getMessage());
            return false;  // 예외 발생 시 다음 단계 진행하지 않도록 false 리턴
        }

        // 중복 검사
        try {
            checkDuplicate(vo);
        } catch (IllegalArgumentException e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", e.getMessage());
            return false;
        }

        // 비밀번호 암호화
        if (vo.getMemPwd() != null && !vo.getMemPwd().isEmpty()) {
            String encryptedPw = pwEncoder.encode(vo.getMemPwd());
            vo.setMemPwd(encryptedPw);
        } else {
            rttr.addFlashAttribute("msgBody", "비밀번호가 유효하지 않습니다.");
            return false;
        }

        // 3. DB 저장
        try {
            memMapper.insertMember(vo);
        } catch (Exception e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", "회원 저장 중 문제가 발생했습니다.");
            return false;  // 예외 발생 시 false 리턴
        }

        // 권한 테이블에 회원 권한 n개 저장
        try {
            List<AuthVO> list = vo.getAuthList();
            for (AuthVO authVO : list) {
                if (authVO.getAuth() != null) {
                    AuthVO saveVO = new AuthVO();
                    saveVO.setMemID(vo.getMemID());
                    saveVO.setAuth(authVO.getAuth());
                    memMapper.insertAuth(saveVO);
                }
            }
        } catch (Exception e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", "권한 저장 중 문제가 발생했습니다.");
            return false;  // 예외 발생 시 false 리턴
        }
        rttr.addFlashAttribute("msgBody", "회원가입이 완료되었습니다.");
        log.info(vo);
        return true;  // 성공 시 true 리턴 == 1 
    }

    // 회원가입 - 입력 값 검증 로직
    private void validateUserInput(Member vo) {
        if (vo.getMemID() == null || vo.getMemID().trim().isEmpty() ||
            vo.getMemPwd() == null || vo.getMemPwd().trim().isEmpty() ||
            (vo.getMemPwd().length() < 6 || vo.getMemPwd().length() > 12) ||
            vo.getMemName() == null || vo.getMemName().trim().isEmpty() ||
            vo.getAuthList().isEmpty()) {
            throw new IllegalArgumentException("입력값을 확인해 주세요.");
        }
    }

    // 아이디 중복검사
    private void checkDuplicate(Member vo) {
        int result = memMapper.checkDuplicate(vo.getMemID());
        if (result > 0) {
            throw new IllegalArgumentException("이미 사용 중인 아이디입니다.");
        }
    }

	@Override
	public int checkDuplicate(String memID) {
		int isDuplicate = memMapper.checkDuplicate(memID);
		return isDuplicate > 0 ? 1 : 0;   //중복:1, 아님:0 
	}

	@Override
	public void updateMemImage(HttpServletRequest request, RedirectAttributes rttr) throws IOException {
		// 매개변수를 HttpServletReqeust로 받고있기 땜에 MultipartRequest 객체를 수동으로 생성해주고있따.. 
		// 매개변수 MultipartHttpServletRequest 받고 싶다면 MultipartResolver 설정 (Spring Bean)을 따로 해줘야 한다구요. 시부엉아 이것때문에 2시간을 날렸다고 
	    MultipartRequest multi = null;  
	    int fileMaxSize = 10 * 1024 * 1024; // 10MB
	    String savePath = request.getServletContext().getRealPath("resources/upload"); 
	    
	    try {
	        multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
	    } catch (Exception e) {
	        e.printStackTrace();
	        rttr.addFlashAttribute("msgTitle", "회원사진 업로드 실패");
	        rttr.addFlashAttribute("msgBody", "파일의 크기는 10 MB를 넘을 수 없습니다");
	        // return이 안되는 이유: 톰캣서버가 용량을 처리하지 못하고 인터넷을 끊어버리고 있음 
 			//	-> server.xml에서 maxSwallowSize="-1" 리미트해제 코드 추가 필요
	    }
	    
	    String memID = multi.getParameter("memID"); 
	    File profileFile = multi.getFile("memProfile"); 
	    String newProfile = null; 
        
        if (profileFile.exists()) {
        	log.info("Uploaded file name: " + profileFile.getName());
            log.info("Uploaded file path: " + profileFile.getPath());
            log.info("Uploaded file size: " + profileFile.length());
	        String ext = profileFile.getName().substring(profileFile.getName().indexOf(".") + 1).toUpperCase();//확장자 
            if (ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF") || ext.equals("JPEG")) {
                // 기존 프로필 이름 가져오기
                String oldProfileName = memMapper.login(memID).getMemProfile();
                // 기존 파일 삭제 (경로 수정 필요)
                File oldFile = new File(savePath + "/" + oldProfileName);
                if (oldFile.exists()) {
                    oldFile.delete();
                }

                // 새로운 파일 이름 생성
                String newProfileName = System.currentTimeMillis() + "_" + profileFile.getName();
                File newProfileFile = new File(savePath + "/" + newProfileName);

                // 파일 업로드(:바꿈)
	            // 파일 이름 변경: 동일한 이름의 사진을 업로드할 경우에도 파일 이름이 중복되지 않게 처리(2)
	            if (!profileFile.renameTo(newProfileFile)) {
	                rttr.addFlashAttribute("msgType", "회원사진 업로드 실패");
	                rttr.addFlashAttribute("welcome", "파일 이름 변경에 실패했습니다.");
	            }

                // 새 프로필 인코딩, 저장
                newProfile = URLEncoder.encode(newProfileName, "UTF-8");
                Member newVO = new Member();
                newVO.setMemID(memID);
                newVO.setMemProfile(newProfile);
                memMapper.updateMemImage(newVO);

                // 프로필 수정했으니 새로운 유저정보로 Security 업데이트
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                MemberUsers userAccount = (MemberUsers) authentication.getPrincipal();
                SecurityContextHolder.getContext().setAuthentication(memberUserDetailsService.createNewAuthentication(authentication, userAccount.getMember().getMemID()));

                rttr.addFlashAttribute("msgTitle", "회원사진 업로드 성공");
                rttr.addFlashAttribute("msgBody", "회원 프로필을 성공적으로 업로드 하였습니다");
            } else {
                rttr.addFlashAttribute("msgTitle", "회원사진 업로드 실패");
                rttr.addFlashAttribute("msgBody", "이미지 파일만 업로드가 가능합니다.");
                throw new IllegalArgumentException("Invalid file type");
            }
        } else {
            throw new IllegalArgumentException("File is empty");
        }
    }

	@Override
	public boolean updateMemInfo(Member vo, RedirectAttributes rttr) {
		//입력값 검증 
        try {
            validateUserInput(vo); // 입력값 검증
        } catch (IllegalArgumentException e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", e.getMessage());
            return false;  // 예외 발생 시 다음 단계 진행하지 않도록 false 리턴
        }
        // 비밀번호 암호화
        if (vo.getMemPwd() != null && !vo.getMemPwd().isEmpty()) {
            String encryptedPw = pwEncoder.encode(vo.getMemPwd());
            vo.setMemPwd(encryptedPw);
        } else {
            rttr.addFlashAttribute("msgBody", "비밀번호가 유효하지 않습니다.");
            return false;
        }
        // 회원정보DB 수정 
        try {
            memMapper.updateMemInfo(vo);
        } catch (Exception e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", "회원 수정 중 문제가 발생했습니다.");
            return false;  // 예외 발생 시 false 리턴
        }
        // 권한DB 수정 (전부삭제후 다시 생성)
        try {
        	memMapper.deleteAuth(vo.getMemID());
        	List<AuthVO> authList = vo.getAuthList();
        	for(AuthVO auth : authList) {
        		AuthVO authVO = new AuthVO();
        		authVO.setMemID(vo.getMemID());
        		authVO.setAuth(auth.getAuth());
        		memMapper.insertAuth(authVO);
        	}
        } catch (Exception e) {
        	e.printStackTrace();
            rttr.addFlashAttribute("msgBody", "권한 저장 중 문제가 발생했습니다.");
            return false;  // 예외 발생 시 false 리턴
        }
        rttr.addFlashAttribute("msgBody", "회원정보 수정이 완료되었습니다. 다시 로그인해주시기 바랍니다.");
        
        return true;
	}
	
		


	
	
	
	
}
