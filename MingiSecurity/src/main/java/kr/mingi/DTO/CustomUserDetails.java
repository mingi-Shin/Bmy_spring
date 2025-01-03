package kr.mingi.DTO;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import kr.mingi.entity.Member;

public class CustomUserDetails implements UserDetails {

	// CustomUserDetails 객체를 사용하기 위해서는 UserDetailsService를 Spring Security에 등록해야
	
    private final Member member;

    public CustomUserDetails(Member member) {
    	System.out.println("1. CustomUserDetails 객체 생성");
        this.member = member;
        System.out.println("2. 로그인 처리할 member: " + member);
        
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
    	
    	System.out.println("getAuthorities() 실행 ");
    	
        Collection<GrantedAuthority> collection = new ArrayList<>();

        collection.add(new GrantedAuthority() {

            @Override
            public String getAuthority() {
            	
            	System.out.println("getAuthority() 실행: member.getRole()를 retur함 ");
                return member.getRole();
            }
        });

        return collection;
    }

    @Override
    public String getPassword() {
    	System.out.println("CustomUserDetails 비밀번호: " + member.getPassword());
        return member.getPassword();
    }

    @Override
    public String getUsername() {
        return member.getUsername();
    }

    // `UserDetails`의 메서드를 반드시 구현해야 함
    @Override
    public boolean isAccountNonExpired() {
        return true;  // 필요시 추가 논리 구현
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;  // 필요시 추가 논리 구현
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;  // 필요시 추가 논리 구현
    }

    @Override
    public boolean isEnabled() {
        return true;  // 필요시 추가 논리 구현
    }
}
