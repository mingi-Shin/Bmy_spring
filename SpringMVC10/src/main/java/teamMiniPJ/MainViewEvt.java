package teamMiniPJ;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;

/**
 * 메인뷰의 이벤트를 처리하는 클래스
 */
public class MainViewEvt extends WindowAdapter implements ActionListener {

	private MainView mv;
	private LoginView lv;
	private LogAnalyzeEvt lae;
	
	private File file;
	private ArrayList<LogVO> lvoList = new ArrayList<LogVO>();
	
	private StringTokenizer stk;
	private String[] strArr;
	
	public MainViewEvt(MainView mv, LoginView lv) {
		this.mv = mv;
		this.lv = lv;
	}

	//파일 불러오기 method
	public void openFile() throws IOException {
		
		//기존 불러왔던 파일이 남아있을 수 있으니 테이블 초기화
		mv.getDtm().setRowCount(0);
		
		JFileChooser jfc = new JFileChooser("c:/dev");
		jfc.showOpenDialog(mv);
		file = jfc.getSelectedFile();

		if (file == null || !file.exists()) {
			JOptionPane.showMessageDialog(mv, "파일이 존재하지 않습니다");
		    return;  
		}
		
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
		String msg;
		int startLine = 0;
		try {
			while ((msg = br.readLine()) != null) {
				lvoList.add(new LogVO(msg));
				setLogTable(startLine++, msg);
				
			}
		} finally {
			if (br != null)
				br.close();
		}
		mv.getOpenFileLabel().setText(file.getAbsolutePath());
	}
	
	//로그 분석 이벤트 클래스 생성
	public void logAnalyze() {
		if(file == null) {
			JOptionPane.showMessageDialog(mv, "파일을 먼저 불러와주세요");
			return;
		}
		try {
			lae = new LogAnalyzeEvt(mv, file, lvoList);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//로그 테이블을 채우는 method(LogAnalyzeEvt에서 재사용)
	public void setLogTable(int startLine, String line) {
		int i = 0;
		stk = new StringTokenizer(line, "[]");
		strArr = new String[stk.countTokens()];
		while(stk.hasMoreTokens()) {
			strArr[i++] = stk.nextToken();
		}
		
		String[] newData = {String.valueOf(startLine + 1), strArr[0], strArr[1], strArr[2], strArr[3]};
		mv.getDtm().addRow(newData);
	}
	//리포트 생성 클래스
	public void generateReport() {
		String id = lv.getIdField().getText();
		if(id.equals("root")) { //만약 아이디가 root면 실행 거부 후 return
			JOptionPane.showMessageDialog(mv, "권한이 없습니다.");
			return;
		}
		
		//로그 파일을 안누르고 리포트 버튼을 누룰시
		if( lae == null) {
			JOptionPane.showMessageDialog(mv,"우선 로그 분석을 완료하세요");
			return;
		}
		
		//로그 분석을 완료한 객체를 넘겨주고 GenerateReportEvt 클래스 생성
		try {
			new GenerateReportEvt(mv, lae);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//윈도우 종료
	@Override
	public void windowClosing(WindowEvent we) {
		mv.dispose();
	}


	@Override
	public void actionPerformed(ActionEvent ae) {
		//불러오기 버튼을 누르면
		if(ae.getSource() == mv.getOpenFileBtn()){
			try {
				openFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		//로그파일 분석 버튼을 누르면
		if(ae.getSource() == mv.getLogAnalyzeBtn()) {
			logAnalyze();
		}
		
		//리포트 생성 버튼을 누르면
		if(ae.getSource() == mv.getGenerateReportBtn()) {
			generateReport();
		}
		
		//로그아웃 버튼을 누르면
		if(ae.getSource() == mv.getLogoutBtn()) {
			mv.dispose();
			new LoginView();
		}
	}
}
