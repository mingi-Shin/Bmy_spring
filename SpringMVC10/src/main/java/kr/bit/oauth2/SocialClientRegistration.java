package kr.bit.oauth2;

import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.oidc.IdTokenClaimNames;
import org.springframework.stereotype.Component;

/*
 * properties에 적는대신 클래스로 생성: 이점 -> 커스텀어블
 * 
 * */
@Component
public class SocialClientRegistration {

	public ClientRegistration naverClientRegistration() {
		
		return ClientRegistration.withRegistrationId("naver")
				.clientId("eOakuPX1wTPdf1jzdK5C")
				.clientSecret("e5socuQTGQ")
				.redirectUri("http://localhost:8081/boot/login/oauth2/code/naver")
				.authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
				.scope("name", "email", "nickname", "profile_image", "gender", "birthday", "birthyear", "mobile")
				.authorizationUri("https://nid.naver.com/oauth2.0/authorize")
				.tokenUri("https://nid.naver.com/oauth2.0/token")
				.userInfoUri("https://openapi.naver.com/v1/nid/me")
				.userNameAttributeName("response")
				.build();
	}
	
	public ClientRegistration googleClientRegistration() {

        return ClientRegistration.withRegistrationId("google")
                .clientId("1090461121782-raatin1kv6g61kfjsr4itcnl8n2u8gcm.apps.googleusercontent.com")
                .clientSecret("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")
                .redirectUri("http://localhost:8081/boot/login/oauth2/code/google")
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .scope("profile", "email")
                .authorizationUri("https://accounts.google.com/o/oauth2/v2/auth")
                .tokenUri("https://www.googleapis.com/oauth2/v4/token")
                .jwkSetUri("https://www.googleapis.com/oauth2/v3/certs")
                .issuerUri("https://accounts.google.com")
                .userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo")
                .userNameAttributeName(IdTokenClaimNames.SUB)
                .build();
    }
	// 페북, 애플 등등 
}
