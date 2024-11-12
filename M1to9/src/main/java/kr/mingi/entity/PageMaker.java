package kr.mingi.entity;

import lombok.Data;

//페이징 처리를 하는 클래스(== VO)
@Data
public class PageMaker {
	
	private Criteria cri;
	
	private int totalCount; //총 게시글의 수 
	private int startPage; //페이지 이동시 보이게 될 맨 앞 페이지 숫자 -> 1 2 3 4 5 or 1 ... 4 5 6 or ... 4 5 6  
	private int endPage; //끝 페이지. 따로 조정코드 필요
	private boolean prev; //이전버튼 (true, false)
	private boolean next; //다음버튼 
	private int displayPageNum = 5; // 1 2 3 4 5 6 7 8 9 10 / ... 보여지게될 페이지 개수: 미리정의  
	
	
	// 1.총 게시글의 수를 구하는 메서드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePaging(); //나머지 변수 값 순서대로 계산 
	}
    

	private void makePaging() {
		// 2.화면에 보여질 마지막 페이지 번호
		// -> 현재 페이지 번호를 보여질 페이지 개수로 나눔. 그 double값을 ceil로 올림함. 그러고 보여질 페이지 개수로 곱함
		endPage = (int)Math.ceil(cri.getCurrentPage()/(double)displayPageNum) * displayPageNum;
		
		// 3.화면에 보여질 시작 페이지 번호 
		startPage = (endPage - displayPageNum) + 1;
		if(startPage <= 0) startPage = 1; //endPage가 마지막에서 일찍 끝날경우 
		
		// 4.전체의 마지막 페이지 번호 계산
		int tempEndPage = (int)Math.ceil(totalCount/(double)cri.getPerPageNum());
		
		// 5.화면에 보여질 마지막 페이지 유효성 체크
		if(tempEndPage < endPage) {
			endPage = tempEndPage;
		}
		
		// 6.이전페이지 버튼(링크)존재 여부
		prev = (startPage == 1)? false : true;
		
		// 7.다음페이지 버튼(링크)존재 여부
		next = (endPage < tempEndPage)? true : false;
		
	}
	
}
