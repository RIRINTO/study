package example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 * 1) tomcat�� chapter17 �� ���ø����̼��� ����
 * 2) WebServlet �ֳ����̼� ����� ���� Ŭ������ ã��
 * 3) ã�Ҵٸ�, ����� �������� ���
 */
@WebServlet(urlPatterns = "/hello")
public class HellowServlet extends HttpServlet {
	//���������� protectd : ���� package ��ü �� ��Ӱ����� ��ü
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws IOException{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		//�� �������� ���۵� ������
		PrintWriter out = response.getWriter();
		out.println("<html><head><title>�ȳ�?����</title></head>");
		out.println("<body>");
		out.println("<h2>�ݰ��� ����!</h2>");
		out.println("</body></html>");
	}
}






