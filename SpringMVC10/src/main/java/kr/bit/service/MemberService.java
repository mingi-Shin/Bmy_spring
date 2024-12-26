package kr.bit.service;

import java.util.List;

import kr.bit.entity.Member;

public interface MemberService {
	
	public void register(Member member, String role);
	public void update(Member member, String role);
	public Member get(Member member);
	public List<Member> getList(Member member);
	public void delete(Member member);
	

}
