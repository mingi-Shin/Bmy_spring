package kr.mingi.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan({"kr.mingi.mapper"})
@PropertySource({"classpath:persistence-postgresql.properties"})
public class RootConfig {

	@Autowired
	private Environment env; // 설정값을 동적으로 가져오기 위한: 환경변수나 프로퍼티 파일 값을 접근할수 있게 해주는 기능을 제공해주는 인터페이스 
	
	@Bean
	public DataSource myDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		
		hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikariConfig.setUsername(env.getProperty("jdbc.username"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource = new HikariDataSource(hikariConfig); 
		
		return myDataSource;
	}
	
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean(); //커넥션풀 생성
		sqlSessionFactory.setDataSource(myDataSource());
		
		return (SqlSessionFactory)sqlSessionFactory.getObject();
	}
	
	
}

/*
 * HIkariConfig 인스턴스를 매개변수로 HIkariDataSource 인스턴스가 생성되고, 
 * 이 인스턴스를 매개변수로 SqlSessionFactoryBean 인스턴스가 생성됨 
 */
