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
  
  //댓글기능관련
  private int boardGroup; //원글과 댓글 묶기, 1씩 증가할거임
  private int boardSequence; //댓글 순
  private int boardLevel; //들여쓰기 속성 
  private boolean boardAvailable; //원글이 삭제되었는지 여부 
  
}
