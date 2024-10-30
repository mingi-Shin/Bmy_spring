package kr.mingi.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	private int commentIdx;
	private String memID;
	private String comment;
	private int boardIdx;
	private int parentIdx;
	private Date indate;
	private boolean commentAvailable;
}
