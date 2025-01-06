package kr.mingi.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CosrsMvcConfig implements WebMvcConfigurer {
    
    @Override
    public void addCorsMappings(CorsRegistry corsRegistry) {
        
        corsRegistry.addMapping("/**") // 모든 엔드포인트에 대해 적용
                .allowedOrigins("http://localhost:3000"); // 특정 Origin 허용
    }
}
/**
 * 	프론트엔드와 백엔드의 도메인이 다를 경우, 통신을 위해 CORS설정이 필요.
 * 
 * */
