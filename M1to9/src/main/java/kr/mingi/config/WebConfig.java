package kr.mingi.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{
	
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true); //요청(request)뿐만 아니라 응답(response)에도 동일한 인코딩이 적용되도록 강제합니다. 
												//기본적으로는 요청에만 적용되지만, 이 옵션(ForceEncoding)을 통해 응답에도 적용되게 만듭니다.
		return new Filter[] {encodingFilter};
	}

	@Override
	protected Class<?>[] getRootConfigClasses() { //가장 먼저 호출되어야 하는 설정 클래스 
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class,  SecurityConfig.class}; //여기 SecurityConfig.class 도 넣어야됨 
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		// TODO Auto-generated method stub
		return new Class[] {ServletConfig.class}; //java파일은 런타임시 .class로 바뀐다는 기초는 당연히 알고있겠지?? 
	}

	@Override
	protected String[] getServletMappings() {
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}
	
	

}
