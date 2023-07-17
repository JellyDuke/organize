package dto;

public class Board {
	
	private int BNO;       // 글 번호
	private String BWRITER;   // 글 작성자
	private String BTITLE;    // 글 제목
	private String BCONTENTS; // 글 내용
	private int BHITS;     // 조회수
	private String BSTATE;    // 상태
	
	
	
	public int getBNO() {
		return BNO;
	}
	public void setBNO(int bNO) {
		BNO = bNO;
	}
	public String getBWRITER() {
		return BWRITER;
	}
	public void setBWRITER(String bWRITER) {
		BWRITER = bWRITER;
	}
	public String getBTITLE() {
		return BTITLE;
	}
	public void setBTITLE(String bTITLE) {
		BTITLE = bTITLE;
	}
	public String getBCONTENTS() {
		return BCONTENTS;
	}
	public void setBCONTENTS(String bCONTENTS) {
		BCONTENTS = bCONTENTS;
	}
	public int getBHITS() {
		return BHITS;
	}
	public void setBHITS(int bHITS) {
		BHITS = bHITS;
	}
	public String getBSTATE() {
		return BSTATE;
	}
	public void setBSTATE(String bSTATE) {
		BSTATE = bSTATE;
	}

}
