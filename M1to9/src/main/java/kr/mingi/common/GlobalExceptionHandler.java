package kr.mingi.common;

import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

/**
 글로벌 예외 처리기(@ControllerAdvice)에서 BusinessException을 잡으면, 그 메시지를 클라이언트에게 전달할 수 있습니다.
 */

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    // 모든 요청에 대한 BusinessException 처리
    @ExceptionHandler(BusinessException.class)
    public Object handleBusinessException(BusinessException ex, RedirectAttributes rttr, HttpServletRequest request) {
        log.error("비즈니스 예외 발생: ", ex);
        // AJAX 요청 여부 확인
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        } else {
            rttr.addFlashAttribute("msgBody", ex.getMessage());
            return "redirect:/errorPage"; // 에러 페이지로 리다이렉트
        }
    }
    
    @ExceptionHandler(DataAccessException.class)
    public Object handleDataAccessException(DataAccessException ex, RedirectAttributes rttr, HttpServletRequest request) {
        log.error("데이터베이스 접근 중 오류 발생: ", ex);
        // AJAX 요청 여부 확인
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(ex.getMessage());
        } else {
            rttr.addFlashAttribute("msgBody", "데이터베이스 접근 중 오류가 발생했습니다.");
            return "redirect:/errorPage"; // 에러 페이지로 리다이렉트
        }
    }

    @ExceptionHandler(Exception.class)
    public Object handleGenericException(Exception ex, RedirectAttributes rttr, HttpServletRequest request) {
        log.error("알 수 없는 예외 발생: ", ex);
        // AJAX 요청 여부 확인
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류가 발생했습니다.");
        } else {
            rttr.addFlashAttribute("msgBody", "서버 오류가 발생했습니다.");
            return "redirect:/errorPage"; // 에러 페이지로 리다이렉트
        }
    }
}
	/**
	 
		$.ajax({
		    url: '/your-endpoint',
		    type: 'POST',
		    data: JSON.stringify(yourData),
		    contentType: 'application/json',
		    success: function(response) {
		        // 성공적으로 데이터를 처리했을 때의 로직
		    },
		    error: function(jqXHR) {
		        // 오류 발생 시 서버에서 반환한 메시지를 가져와 처리
		        alert(jqXHR.responseText); // 여기서 서버가 반환한 예외 메시지를 볼 수 있습니다.
		    }
		});
	  
	 * */
	
