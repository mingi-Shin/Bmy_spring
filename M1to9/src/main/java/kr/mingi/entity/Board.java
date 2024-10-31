package kr.mingi.entity;

import java.util.Date;

import lombok.Data;

@Data //lombok API
public class Board {
  private int boardIdx; // 번호
  private String memID; //작성자 id
  private String title; // 제목
  private String content; // 내용
  private String writer; // 작성자
  private Date indate; // 작성일 (java.util.Date)
  private int count; // 조회수
  private boolean boardAvailable; //원글이 삭제되었는지 여부 
  
}
