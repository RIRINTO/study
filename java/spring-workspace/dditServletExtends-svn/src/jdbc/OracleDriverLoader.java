package jdbc;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
//HttpServlet? ������ ���� ���� Ŭ����
public class OracleDriverLoader extends HttpServlet {
	//JDBC����̹��� �� ���� �ε��ϸ� ��� ����� �� ����
	//���� Ŭ���� ���(OracleDriverLoader)
	//������ �ʱ�ȭ�� �� ȣ��Ǵ� �޼���. ������ �ʱ�ȭ�� �� ���� 1ȸ ����
	@Override
	public void init(ServletConfig config) throws ServletException{
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex) {
			throw new ServletException(ex);
		}
	}
	
}
