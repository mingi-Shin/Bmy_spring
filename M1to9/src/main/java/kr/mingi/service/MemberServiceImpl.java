package kr.mingi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.mingi.entity.AuthVO;
import kr.mingi.entity.Member;
import kr.mingi.mapper.MemberMapper;
import kr.mingi.security.MemberUserDetailsService;

/**
 * 기존의 방법 (= controller에서 mapper를 Autowired하여 로직을 구성했단 방법)
 * 	은 유지보수, 가독성, 트랜잭션 관리측면에서 효율이 떨어진다.
 *	따라서 좀더 작게 쪼개서 비즈니스로직을 전담하려고 만든게 Service단 
 *	
 *	보통 구현 순서: DB-> Mapper, XML -> Service, SErviceImpl -> Controller -> jsp 
 * */

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memMapper;

    @Autowired
    private PasswordEncoder pwEncoder;

    // 회원가입
    @Override
    public boolean register(Member vo, RedirectAttributes rttr) {
        // 서버사이드 검증(= 2차 검증)
        try {
            validateUserInput(vo); // 입력값 검증
        } catch (IllegalArgumentException e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage());
            return false;  // 예외 발생 시 다음 단계 진행하지 않도록 false 리턴
        }

        // 중복 검사
        try {
            checkDuplicate(vo);
        } catch (IllegalArgumentException e) {
            rttr.addFlashAttribute("errorMessage", e.getMessage());
            return false;
        }

        // 비밀번호 암호화
        if (vo.getMemPwd() != null && !vo.getMemPwd().isEmpty()) {
            String encryptedPw = pwEncoder.encode(vo.getMemPwd());
            vo.setMemPwd(encryptedPw);
        } else {
            rttr.addFlashAttribute("errorMessage", "비밀번호가 유효하지 않습니다.");
            return false;
        }

        // 3. DB 저장
        try {
            memMapper.insertMember(vo);
        } catch (Exception e) {
            rttr.addFlashAttribute("errorMessage", "회원 저장 중 문제가 발생했습니다.");
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
            rttr.addFlashAttribute("errorMessage", "권한 저장 중 문제가 발생했습니다.");
            return false;  // 예외 발생 시 false 리턴
        }

        return true;  // 성공 시 true 리턴
    }

    // 회원가입 - 입력 값 검증 로직
    private void validateUserInput(Member vo) {
        if (vo.getMemID() == null || vo.getMemID().trim().isEmpty() ||
            vo.getMemPwd() == null || vo.getMemPwd().trim().isEmpty() ||
            (vo.getMemPwd().length() < 6 || vo.getMemPwd().length() > 12) ||
            vo.getMemName() == null || vo.getMemName().trim().isEmpty() ||
            vo.getMemPhone() == null || vo.getMemPhone().trim().isEmpty() ||
            vo.getAuthList().isEmpty()) {
            throw new IllegalArgumentException("입력값을 확인해 주세요.");
        }
    }

    // 아이디 중복검사
    private void checkDuplicate(Member vo) {
        Member result = memMapper.checkDuplicate(vo.getMemID());
        if (result.getMemID() != null) {
            throw new IllegalArgumentException("이미 사용 중인 아이디입니다.");
        }
    }
}
