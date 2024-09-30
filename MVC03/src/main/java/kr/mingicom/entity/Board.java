package kr.mingicom.entity;

import lombok.Data;

@Data //lombok API
public class Board {
  private int idx; // 번호
  private String memID; //작성자 id
  private String title; // 제목
  private String content; // 내용
  private String writer; // 작성자
  private String indate; // 작성일
  private int count; // 조회수
  // setter , getter 
}
