package example;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.net.httpserver.HttpServer;

public class NowServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws IOException {
		//response ��ü�� �̿��ؼ� ����(=page ��Ƽ���� contentType �Ӽ��� ����)
		response.setContentType("text/html;charset=UTF-8");
		//���� �����͸� �����ϰ� ����.
		PrintWriter out = response.getWriter();
		out.println("<html><head><title>����ð�</title></head>");
		out.println("<body>���� �ð���");
		out.println(new Date());
		out.println("�Դϴ�.");
		out.println("</body></html>");
	}
}





