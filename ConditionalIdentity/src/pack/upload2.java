/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pack;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.mysql.jdbc.Statement;

/**
 *
 * @author jp
 */
public class upload2 extends HttpServlet {

	SimpleFTPClient client;
	File file;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();

		String my = request.getSession().getAttribute("me").toString();

		try {

			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DbConnector.getConnection();

			String fileName=request.getParameter("filename");
			String fileData=request.getParameter("filedata");
			String userId=request.getParameter("userid");

			InputStream stream = new ByteArrayInputStream(fileData.getBytes(StandardCharsets.UTF_8));

			PreparedStatement pstm = null;

			client = new SimpleFTPClient();
			client.setHost("ftp.drivehq.com");
			client.setUser("bhavyag18");
			client.setPassword("123456");
			client.setRemoteFile(fileName);

			boolean log = client.connect();

			Random r = new Random();
			
			String pattern="abcedefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			
			String k ="";
			
			for(int i=0;i<9;i++)
			{
				k=k+pattern.charAt(r.nextInt(60));
			}

			String l = "1";
			
			client.setMykey(k);
			
			java.sql.Statement s=con.createStatement();
			
			String email="";
			
			ResultSet rs1=s.executeQuery("select * from regpage where userid='"+userId+"'");
			
			if(rs1.next())
			{
				email=rs1.getString("mail");
				
			}	
			
			String sql = "update userfiles set filekey='"+k+"' where filename='"+fileName+"'";

			pstm = con.prepareStatement(sql);
			
			pstm.executeUpdate();
			con.createStatement().executeUpdate("update files set key_='"+k+"' where name='"+fileName+"'");
			
			
			mail.mailsend(k, email, fileName);

			String path="F:\\appuploads\\"+fileName;

			FileOutputStream myos=new FileOutputStream(path);

			try {
				client.encrypt(stream, myos);
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if (client.uploadFile(new FileInputStream(path))) {

				response.sendRedirect("userpage.jsp?msg= sucess..!");
			} else {
				response.sendRedirect("userpage.jsp?msgg= NOT sucess..!");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Handles the HTTP
	 * <code>POST</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	/**
	 * Returns a short description of the servlet.
	 *
	 * @return a String containing servlet description
	 */
	@Override
	public String getServletInfo() {
		return "Short description";
	}// </editor-fold>
}
