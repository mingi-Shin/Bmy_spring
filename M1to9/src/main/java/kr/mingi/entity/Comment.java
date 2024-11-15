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
	private Integer commentGroup; //1번 부모 댓글의 idx, 그의 자손들(댓글들)을 묶어 정렬하기 위함 
	private Integer parentIdx; 
	private Date indate;
	private boolean commentAvailable; //댓글삭제여부 
}

/**
 * 첫댓글의 CommentGroup은 본인의 commentIdx 이고, 그 뒤의 자손댓글들의 commentGroup은 최상위 부모 댓글의 commentGroup을 따라간다.
 * 
 *
 * 1차댓글: parentIdx = null
 * 그 후 댓글들: parentIdx = 부모의 commentIdx
 *
 * int는 NULL 안됨. Integer만 NULL허용 
 */