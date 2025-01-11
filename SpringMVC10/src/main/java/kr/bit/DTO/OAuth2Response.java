package kr.bit.DTO;

public interface OAuth2Response {

    //제공자 (Ex. naver, google, ...)
    public String getProvider();
    //제공자에서 발급해주는 아이디(번호)
    public String getProviderId();
    //이메일
    public String getEmail();
    //사용자 실명 (설정한 이름)
    public String getName();
    
}


//이 공통 인터페이스를 활용해 도메인별로 클래스 생성 