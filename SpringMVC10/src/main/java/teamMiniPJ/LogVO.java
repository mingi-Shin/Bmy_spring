package teamMiniPJ;

public class LogVO {

	private String logMsg;
	private String service;
	private String browserName;
	private String keyName;
	private String time;
	private boolean isBooks = false;
	
	public LogVO(String line) {

		// 기존 문자열을 쪼개기 전 원본 상태로 저장
		logMsg = line;

		// ']' 기분으로 라인 분리
		String[] lineArr = line.split("]");

		// 서비스 추출
		service = lineArr[0].substring(1);
		
		// 키 이름 추출
		int startIdx = lineArr[1].indexOf("key=") + 4;
		int endIdx = lineArr[1].indexOf("&");
		if (startIdx != -1 && endIdx != -1) {
			keyName = lineArr[1].substring(startIdx, endIdx);
		}

		// 브라우저 추출
		browserName = lineArr[2].substring(1);

		// 시간 추출
		startIdx = lineArr[3].indexOf(" ") + 1;
		endIdx = lineArr[3].indexOf(":");
		time = lineArr[3].substring(startIdx, endIdx);

		// books 인지 체크
		startIdx = lineArr[1].indexOf("find/") + 5;
		endIdx = lineArr[1].indexOf("?");
		if (endIdx != -1 && lineArr[1].substring(startIdx, endIdx).equals("books")) {
			isBooks = true;
		}

	}

	public String getLogMsg() {
		return logMsg;
	}

	public String getService() {
		return service;
	}

	public String getBrowserName() {
		return browserName;
	}

	public String getKeyName() {
		return keyName;
	}

	public String getTime() {
		return time;
	}

	public boolean isBooks() {
		return isBooks;
	}

}
