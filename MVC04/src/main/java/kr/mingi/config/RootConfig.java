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
@MapperScan({"kr.mingicom.mapper"})
@PropertySource({"classpath:persistence-mariadb.properties"}) //띄어쓰면 오류난다
public class RootConfig {

	@Autowired
	private Environment env; // 위의 @PropertySource 파일 
	
	
	@Bean
	public DataSource myDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
				
		hikariConfig.setDriverClassName(env.getProperty("jdbc.driver"));
		hikariConfig.setJdbcUrl(env.getProperty("jdbc.url"));
		hikariConfig.setUsername(env.getProperty("jdbc.user"));
		hikariConfig.setPassword(env.getProperty("jdbc.password"));
		
		HikariDataSource myDataSource = new HikariDataSource(hikariConfig);
		
		return myDataSource;
	}
	
	@Bean
	public SqlSessionFactory sessionFactory() throws Exception {
		
		SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean(); //커넥션풀 생성 
		sessionFactory.setDataSource(myDataSource());
		return (SqlSessionFactory)sessionFactory.getObject(); 
		
	}
	
}


/*
 * HIkariConfig 인스턴스를 매개변수로 HIkariDataSource 인스턴스가 생성되고, 
 * 이 인스턴스를 매개변수로 SqlSessionFactoryBean 인스턴스가 생성됨 
 * 
 
  	<!-- API (HikariCP) -->
	<!-- bean : 객체를 생성하는 태그 -->
	<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
		<property name="driverClassName" value="org.mariadb.jdbc.Driver" />
		<property name="jdbcUrl" value="jdbc:mariadb://localhost:3306/bmyspring" />
		<property name="username" value="shinmingi" />
		<property name="password" value="4260" />
	</bean>
	
	<!-- HikariDataSource (Connection POOL 만드는 역할) -->
	<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource" 
	                                                destroy-method="close">
      <constructor-arg ref="hikariConfig" />
    </bean>
    
    <!-- Mapper interface들을 메모리에 올리는 방법(scan) -->
    <mybatis-spring:scan base-package="kr.mingicom.mapper"/>
    
    <!-- BoardMapper interface의 구현클래스 생성
		SqlSessionFactoryBean(SQL을 실행하는 API) -->
    <bean class="org.mybatis.spring.SqlSessionFactoryBean">
       <property name="dataSource" ref="dataSource" />
    </bean>
    		
 * */
 