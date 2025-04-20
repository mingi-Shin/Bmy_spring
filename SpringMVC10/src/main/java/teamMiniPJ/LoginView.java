package teamMiniPJ;

import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;

/**
 * 로그인 창 클래스
 */
@SuppressWarnings("serial")
public class LoginView extends JFrame {

	private JTextField idField;
	private JPasswordField pwField;
	private JButton loginBtn, cancelBtn, registerBtn;
	
	public LoginView() {
		super("로그인");
		
		//타이틀바 설정
		JLabel jlblTitle = new JLabel("로그인", JLabel.CENTER);
		jlblTitle.setFont(new Font("맑은 고딕", Font.BOLD, 30));
		
		//폰트 설정
		Font font=new Font("맑은 고딕", Font.BOLD, 20);
		
		//아이디와 비밀번호 필드 설정
		JPanel jpCenter = new JPanel();
		jpCenter.setLayout(new GridLayout(3,1));
		jpCenter.setBorder(new TitledBorder("입력정보"));
		
		idField = new JTextField();
		pwField = new JPasswordField();
		idField.setFont(font);
		pwField.setFont(font);
		idField.setBorder(new TitledBorder("아이디"));
		pwField.setBorder(new TitledBorder("비밀번호"));
		
		jpCenter.add(idField);
		jpCenter.add(pwField);
		
		//버튼 설정
		JPanel jpButton = new JPanel(new FlowLayout(FlowLayout.CENTER));
		loginBtn = new JButton("로그인");
		registerBtn = new JButton("회원가입");
		cancelBtn = new JButton("취소");
		
		jpButton.add(loginBtn);
		jpButton.add(registerBtn);
		jpButton.add(cancelBtn);
		
		//컴포넌트 배치
		add(jlblTitle,"North");
		add(jpCenter,"Center");
		add(jpButton,"South");
		
		LoginViewEvt lve = new LoginViewEvt(this);
		addWindowListener(lve);
		loginBtn.addActionListener(lve);
		registerBtn.addActionListener(lve);
		cancelBtn.addActionListener(lve);
		
		setBounds(100,100,500,300);
		setVisible(true);
	
	}

	public JTextField getIdField() {
		return idField;
	}

	public JPasswordField getPwField() {
		return pwField;
	}

	public JButton getLoginBtn() {
		return loginBtn;
	}

	public JButton getCancelBtn() {
		return cancelBtn;
	}

	public JButton getRegisterBtn() {
		return registerBtn;
	}
	

}
