package teamMiniPJ;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.Label;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableModel;
import javax.swing.text.DefaultCaret;

/**
 * 로그 분석과 리포트 생성을 할 수 있는 버튼이 있는 mainview 클래스
 */
@SuppressWarnings("serial")
public class MainView extends JFrame {

	private JTextField inputLineFrom, inputLineTo;
	private JButton logAnalyzeBtn, generateReportBtn, openFileBtn, logoutBtn;
	private JTextArea jta;
	private JLabel openFileLabel, nameLabel;
	private JScrollPane jsp;
	private DefaultTableModel dtm;
	private JTable jt;
	private JLabel q1Label, q2Label, q3Label, q4Label, q5Label, q6Label;
	private JLabel a1Label, a2Label, a3Label, a4Label, a5Label, a6Label;

	private LoginView lv;
	private LoginViewEvt lve;

	public MainView(LoginView lv) { // 로그인뷰를 매개변수로 받음

		super("로그 파일 분석");
		this.lv = lv;

//------------------------상단 설정---------------------------
		logAnalyzeBtn = new JButton("로그파일 분석");
		generateReportBtn = new JButton("레포트 생성");
		
		nameLabel = new JLabel(lv.getIdField().getText() + "님 안녕하세요?");
		logoutBtn = new JButton("로그아웃");
		openFileBtn = new JButton("불러오기");
		openFileLabel = new JLabel("");
		openFileLabel.setPreferredSize(new Dimension(700, 30));
		openFileLabel.setBorder(new LineBorder(Color.black));
		
		inputLineFrom = new JTextField(10); // 원하는 라인 입력
		inputLineTo = new JTextField(10); // 원하는 라인 입력

		// 파일 불러오기 및 정보, 로그아웃 라벨
		JPanel topPanel = new JPanel();
		topPanel.add(nameLabel);
		topPanel.add(logoutBtn);
		topPanel.add(openFileLabel);
		topPanel.add(openFileBtn);

		// 라인 요청 라벨
		JPanel lineNumText = new JPanel();
		lineNumText.add(inputLineFrom);
		lineNumText.add(new Label(" to "));
		lineNumText.add(inputLineTo);
		lineNumText.setBorder(new TitledBorder("Line 입력"));

		// 로그분석 & 레포트 생성 버튼 라벨
		JPanel logBtnPanel = new JPanel();
		logBtnPanel.setLayout(new GridLayout(1, 2));
		logBtnPanel.add(logAnalyzeBtn);
		logBtnPanel.add(generateReportBtn);

		// 라인 요청 라벨과 로그&레포트 라벨 합치기
		JPanel lineLogPanel = new JPanel();
		lineLogPanel.setLayout(new GridLayout(1, 2));
		lineLogPanel.add(lineNumText);
		lineLogPanel.add(logBtnPanel);

		// 상단 패널 합치기
		JPanel logAnalysisPanel = new JPanel();
		logAnalysisPanel.setLayout(new GridLayout(2,1));
		logAnalysisPanel.add(topPanel);
		logAnalysisPanel.add(lineLogPanel);

		add(logAnalysisPanel, "North");

//------------------------중앙 설정-------------------------------

		JPanel centerPanel = new JPanel();
		centerPanel.setLayout(new BorderLayout());

		dtm = new DefaultTableModel();
		jt = new JTable(dtm);
		jsp = new JScrollPane(jt);
		
		String[] columnNames = { "Index", "응답코드", "URL", "Browser", "Time" };
	    dtm.setColumnIdentifiers(columnNames);
//		jta = new JTextArea(60, 80);
//		//스크롤바가 자동으로 밑으로 안내려가게 설정(원리는 모르지만 구글에 검색하니 나왔음...)
//		DefaultCaret caret = (DefaultCaret)jta.getCaret();
//		caret.setUpdatePolicy(DefaultCaret.NEVER_UPDATE);
//		jsp = new JScrollPane(jta);

		centerPanel.add(jsp, "Center");

		add(centerPanel, "Center");

//----------------------하단 설정----------------------------------		

		JPanel southPanel = new JPanel();
		southPanel.setLayout(new GridLayout(6, 1));
		southPanel.setBorder(new TitledBorder("분석 결과"));
		southPanel.setPreferredSize(new Dimension(800, 300));

		JPanel q1Panel = new JPanel();
		q1Panel.setLayout(new GridLayout(1, 2));
		q1Label = new JLabel("최다 사용키와 횟수:", JLabel.CENTER);
		a1Label = new JLabel("", JLabel.CENTER);
		q1Panel.add(q1Label);
		q1Panel.add(a1Label);

		JPanel q2Panel = new JPanel();
		q2Panel.setLayout(new GridLayout(1, 2));
		q2Label = new JLabel("브라우저별 접속 횟수, 비율:", JLabel.CENTER);
		a2Label = new JLabel("", JLabel.CENTER);
		q2Panel.add(q2Label);
		q2Panel.add(a2Label);

		JPanel q3Panel = new JPanel();
		q3Panel.setLayout(new GridLayout(1, 2));
		q3Label = new JLabel("200응답 횟수, 404응답 횟수:", JLabel.CENTER);
		a3Label = new JLabel("", JLabel.CENTER);
		q3Panel.add(q3Label);
		q3Panel.add(a3Label);

		JPanel q4Panel = new JPanel();
		q4Panel.setLayout(new GridLayout(1, 2));
		q4Label = new JLabel("요청이 가장 많은 시간:", JLabel.CENTER);
		a4Label = new JLabel("", JLabel.CENTER);
		q4Panel.add(q4Label);
		q4Panel.add(a4Label);

		JPanel q5Panel = new JPanel();
		q5Panel.setLayout(new GridLayout(1, 2));
		q5Label = new JLabel("403응답 횟수, 비율:", JLabel.CENTER);
		a5Label = new JLabel("", JLabel.CENTER);
		q5Panel.add(q5Label);
		q5Panel.add(a5Label);

		JPanel q6Panel = new JPanel();
		q6Panel.setLayout(new GridLayout(1, 2));
		q6Label = new JLabel("books에 대한 요청 URL중 에러(500)가 발생한 횟수, 비율:", JLabel.CENTER);
		a6Label = new JLabel("", JLabel.CENTER);
		q6Panel.add(q6Label);
		q6Panel.add(a6Label);

		southPanel.add(q1Panel);
		southPanel.add(q2Panel);
		southPanel.add(q3Panel);
		southPanel.add(q4Panel);
		southPanel.add(q5Panel);
		southPanel.add(q6Panel);

		add(southPanel, "South");

		// 이벤트 생성
		MainViewEvt mve = new MainViewEvt(this, lv);
		addWindowListener(mve);

		openFileBtn.addActionListener(mve);
		logAnalyzeBtn.addActionListener(mve);
		generateReportBtn.addActionListener(mve);
		logoutBtn.addActionListener(mve);

		// 화면 설정
		setVisible(true);
		setBounds(400, 10, 1200, 1020);
	}

	public JTextField getInputLineFrom() {
		return inputLineFrom;
	}

	public JTextField getInputLineTo() {
		return inputLineTo;
	}

	public JButton getLogAnalyzeBtn() {
		return logAnalyzeBtn;
	}

	public JButton getGenerateReportBtn() {
		return generateReportBtn;
	}

	public JButton getOpenFileBtn() {
		return openFileBtn;
	}

	public JButton getLogoutBtn() {
		return logoutBtn;
	}

	public JTextArea getJta() {
		return jta;
	}

	public JLabel getOpenFileLabel() {
		return openFileLabel;
	}

	public JLabel getNameLabel() {
		return nameLabel;
	}

	public JScrollPane getJsp() {
		return jsp;
	}

	public DefaultTableModel getDtm() {
		return dtm;
	}

	public JTable getJt() {
		return jt;
	}

	public JLabel getQ1Label() {
		return q1Label;
	}

	public JLabel getQ2Label() {
		return q2Label;
	}

	public JLabel getQ3Label() {
		return q3Label;
	}

	public JLabel getQ4Label() {
		return q4Label;
	}

	public JLabel getQ5Label() {
		return q5Label;
	}

	public JLabel getQ6Label() {
		return q6Label;
	}

	public JLabel getA1Label() {
		return a1Label;
	}

	public JLabel getA2Label() {
		return a2Label;
	}

	public JLabel getA3Label() {
		return a3Label;
	}

	public JLabel getA4Label() {
		return a4Label;
	}

	public JLabel getA5Label() {
		return a5Label;
	}

	public JLabel getA6Label() {
		return a6Label;
	}

	public LoginView getLv() {
		return lv;
	}

	public LoginViewEvt getLve() {
		return lve;
	}

	
}
