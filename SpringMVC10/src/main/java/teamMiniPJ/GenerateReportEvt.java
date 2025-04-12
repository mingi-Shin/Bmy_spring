package teamMiniPJ;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.swing.JOptionPane;

public class GenerateReportEvt {

	private MainView mv;
	private LogAnalyzeEvt lae;
	private StringBuilder[] sb;
	
	public GenerateReportEvt(MainView mv, LogAnalyzeEvt lae) throws IOException {
		this.mv = mv;
		this.lae = lae;
		sb = lae.getSb();
		//디렉토리 생성
		File dir = new File("c:/dev/report");
		if( !dir.exists() ) {
			dir.mkdirs();
		}
		
		File file = new File(dir.getAbsolutePath() + File.separator + System.currentTimeMillis() + ".dat");
		BufferedWriter bw = null;
		try {
			bw = new BufferedWriter(new FileWriter(file));
			
			bw.write("-----------------------------------------------------------------------------------\n");
			bw.write("파일명 (" + lae.getFile().getAbsolutePath() + ") log\n");
			bw.write("-----------------------------------------------------------------------------------\n");
			bw.write("최다 사용키와 횟수: " + sb[0] + "\n\n");
			bw.write("브라우저별 접속 횟수, 비율: " + sb[1] + "\n\n");
			bw.write("200응답 횟수, 400응답 횟수: " + sb[2] + "\n\n");
			bw.write("요청이 가장 많은 시간: " + sb[3] + "\n\n");
			bw.write("403응답 횟수, 비율: " + sb[4] + "\n\n");
			bw.write("books에 대한 요청 URL중 에러(500)가 발생한 횟수, 비율: " + sb[5] + "\n");
			
			JOptionPane.showMessageDialog(mv, "레포트 생성 완료");
		} finally {
			if(bw != null) bw.close();
		}
		
	}
}
