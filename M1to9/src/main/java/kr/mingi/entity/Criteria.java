package kr.mingi.entity;

import lombok.Data;

@Data
public class Criteria {
	private int currentPage; // 현재 페이지 번호
	private int perPageNum; // 한 페이지의 가용 게시글 수 
	
	public Criteria() {
		// 생성시 초기값 
		this.currentPage = 1;
		this.perPageNum = 10;
	}
	
	//현재 페이지의 게시글 시작번호 (맵퍼에서 게시물idx를 0번부터 시작하기로)
	public int getPageStart() {					// 1page	2page	3page
		return (currentPage-1) * perPageNum;	// 0~		10~		20~
	}
	
    
}
