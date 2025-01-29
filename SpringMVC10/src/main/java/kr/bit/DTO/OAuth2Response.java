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
    
  //nickName과 Name중 하나만 선택해야 하는 도메인도 있음. 
    public String getNickname();
    
    public String getProfile_image();
    
    public String username(); //CustomOAuth2UserService에서 OAuth2의 username값으로 memberIdx찾기위해 작성 
}


//이 공통 인터페이스를 활용해 도메인별로 클래스 생성 
// 현재 네이버의 경우 정보제공에, 이름, 이메일, 별명, 프로필사진을 필수 항목으로 받아오고 있다.