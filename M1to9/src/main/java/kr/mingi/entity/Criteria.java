package kr.mingi.entity;

public class Criteria {
	private int page; // 현재 페이지 번호
	private int perPageNum; // 한 페이지의 가용 게시글 수 
	
	public Criteria() {
		// 생성시 초기값 
		this.page = 1;
		this.perPageNum = 8;
	}
	
	//현재 페이지의 게시글 시작번호 
	public int getPageStart() {			// 1page	2page	3page
		return (page-1) * perPageNum;	// 0~		8~		16~
	}
	

}
