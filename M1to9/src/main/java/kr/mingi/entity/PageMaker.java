package kr.mingi.entity;

//페이징 처리를 하는 클래스(== VO)
public class PageMaker {
	
	private Criteria cri;
	private int totalCount; //총 게시글의 수 
	private int startPage; //페이지 이동시 보이게 될 맨 앞 페이지 숫자 -> 1 2 3 4 5 or 1 ... 4 5 6 or ... 4 5 6  
	private int endPage; //끝 페이지. 따로 조정코드 필요
	private boolean prev; //이전버튼 (true, false)
	private boolean next; //다음버튼 
	private int displayPageNum = 5; // 1 2 3 4 5 / 6 7 8 9 10 / ... 보여지게될 페이지 개수 
	
}
