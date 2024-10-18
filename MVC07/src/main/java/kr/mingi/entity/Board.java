package kr.mingi.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	private int boardIdx;
	private String memID;
	private String title;
	private String content;
	private String writer;
	private Date indate;
	private int count;
	private int boardGroup; // 원글과 댓글 묶는 역할 
	private int boardSequence; // 답글의 순서 
	private int boardLevel; // 답글의 레벨(들여쓰기)
	private int boardAvailable; // 삭제된 글인지 여부 
	
}

