package teamMiniPJ;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JOptionPane;

/**
 * 로그인 이벤트를 처리하는 클래스
 */
public class LoginViewEvt extends WindowAdapter implements ActionListener {

	private LoginView lv;
	private LoginViewEvt lve;
	private Map<String, String> loginData; //로그인 데이터 저장하는 해쉬맵
	
	public LoginViewEvt(LoginView lv) {
		this.lv = lv;
		loginData = new HashMap<>();
		loginData.put("admin","1234");
		loginData.put("root","1111");
		loginData.put("administrator","12345");
		loginData.put("1", "1");
	}

	//로그인 성공시 MainView로 넘어가는 method
	public void openMainView() {
		new MainView(lv);
	}
	
	//로그인 처리하는 method
	public void loginProcess() {
		String id = lv.getIdField().getText();
		String pw = new String(lv.getPwField().getPassword());
		
		if(id.isEmpty()) {
			JOptionPane.showMessageDialog(lv, "아이디를 입력하세요...", "", JOptionPane.ERROR_MESSAGE);
			return;
		}
		
		if(pw.isEmpty()) {
			JOptionPane.showMessageDialog(lv, "비밀번호를 입력하세요...", "", JOptionPane.ERROR_MESSAGE);
			return;
		}
		if(loginData.containsKey(id) && loginData.get(id).equals(pw)) {
			JOptionPane.showMessageDialog(lv, "로그인 성공!");
			openMainView();
			lv.dispose(); //로그인 성공시 로그인창 닫음
		} else {
			JOptionPane.showMessageDialog(lv, "아이디와 비밀번호를 확인하세요", "", JOptionPane.ERROR_MESSAGE);
		}
	}
	
	public void registerProcess() {
		
	}
	
	public void cancelProcess() {
		lv.dispose();
	}
	
	@Override
	public void windowClosing(WindowEvent we) {
		cancelProcess();
	}

	//아이디와 비밀번호가 맞는지 확인하느 클래스
	@Override
	public void actionPerformed(ActionEvent ae) {
		if(ae.getSource() == lv.getLoginBtn()) {
			loginProcess();
		}
		
		if(ae.getSource() == lv.getRegisterBtn()) {
			registerProcess();
		}
		
		if(ae.getSource() == lv.getCancelBtn()) {
			cancelProcess();
		}
	}
}
