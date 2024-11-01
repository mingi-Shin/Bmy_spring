package kr.mingi.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	private int commentIdx;
	private String memID;
	private String memName;
	private String comment;
	private int boardIdx;
	private Integer commentGroup; //1번 부모 댓글의 idx? 아니면 따로?
	private Integer parentIdx; 
	private Date indate;
	private boolean commentAvailable;
}

/**
 * 1차댓글: parentIdx = null
 * 그 후 댓글들: parentIdx = 부모의 commentIdx
 *
 * int는 NULL 안됨. Integer만 NULL허용 
 */