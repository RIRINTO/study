package jdbc;

import java.sql.DriverManager;

import javax.servlet.http.HttpServlet;

import org.apache.commons.dbcp2.ConnectionFactory;
import org.apache.commons.dbcp2.DriverManagerConnectionFactory;
import org.apache.commons.dbcp2.PoolableConnection;
import org.apache.commons.dbcp2.PoolableConnectionFactory;
import org.apache.commons.dbcp2.PoolingDriver;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;

public class DBCPInit extends HttpServlet {
	
	@Override
	public void init() {
		
	}
	
	private void loadJDBCDriver() {
		try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(ClassNotFoundException ex) {
			throw new RuntimeException("fail to load JDBC Driver", ex);
		}
	}
	
	private void initConnectionPool() {
		try {
			String jdbcUrl = "jdbc:oracle:thin:@localhost:1521/xe";
			String username = "jspexam";
			String pw = "java";
			ConnectionFactory connFactory = 
					new DriverManagerConnectionFactory(jdbcUrl,username,pw);
			PoolableConnectionFactory poolableConnFactory = 
					new PoolableConnectionFactory(connFactory, null);
			//Ŀ�ؼ��� ��ȿ���� ���� �˻� �� ����� Query
			poolableConnFactory.setValidationQuery("select 1");
				//Ŀ�ؼ� Ǯ�� ���� ����
				GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
				//���� Ŀ�ؼ� �˻� �ֱ�
				poolConfig.setTimeBetweenEvictionRunsMillis(1000L*60L*5L);//5��
				//Ǯ�� �������� Ŀ�ؼ��� ��ȿ���� �˻��ϰڴ�(true)
				poolConfig.setTestWhileIdle(true);
				//Ŀ�ؼ� �ּ� ����
				poolConfig.setMinIdle(4);
				//Ŀ�ؼ� �ִ� ����
				poolConfig.setMaxTotal(50);
			//Ŀ�ؼ� Ǯ�� ����*******
			GenericObjectPool<PoolableConnection> connectionPool = 
					new GenericObjectPool<>(poolableConnFactory, poolConfig);
			poolableConnFactory.setPool(connectionPool);
			
			//Ŀ�ؼ� Ǯ�� �����ϴ� JDBC ����̹� ���
			Class.forName("org.apache.commons.dbcp2.PoolingDriver");
			PoolingDriver driver 
				= (PoolingDriver)DriverManager.getDriver("jdbc:apache:commons:dbcp:");
			driver.registerPool("chapter14", connectionPool);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
}





