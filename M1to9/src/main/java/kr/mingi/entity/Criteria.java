package kr.mingi.entity;

import lombok.Data;

@Data
public class Criteria {
	private int currentPage; // 현재 페이지 번호
	private int perPageNum; // 한 페이지의 가용 게시글 수 
	
	//검색기능에 필요한 변수
	private String type;
	private String keyword;
	
	public Criteria() {
		// 생성시 설정값  
		this.currentPage = 1;
		this.perPageNum = 10;
	}
	
	//페이지의 게시글 시작번호
	public int getPageStart() {					// 1page	2page	3page
		return (currentPage-1) * perPageNum;	// 0~		10~		20~
	}
	
	
	//myBatis 에서 #{pageStart}를 찾고있는데, 해당 변수가 없으면 getPageStart()로 값을 가져온다. 
    
}
