/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pack;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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

/**
 *
 * @author jp
 */
public class upload1 extends HttpServlet {

	SimpleFTPClient client;
	File file;

	/**
	 * Processes requests for both HTTP
	 * <code>GET</code> and
	 * <code>POST</code> methods.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		
		PrintWriter out = response.getWriter();

		String my = request.getSession().getAttribute("me").toString();

		try {

			Class.forName("com.mysql.jdbc.Driver");
			
			Connection con = DbConnector.getConnection();

			DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
			
			diskFileItemFactory.setRepository(file);
			diskFileItemFactory.setSizeThreshold(1 * 1024 * 1024);

			ServletFileUpload newHUpload = new ServletFileUpload(diskFileItemFactory);
			List items = newHUpload.parseRequest(request);
			
			Iterator iterator = items.iterator();
			FileItem fileItem = (FileItem) iterator.next();

			PreparedStatement pstm = null;
			
			client = new SimpleFTPClient();
			client.setHost("ftp.drivehq.com");
			client.setUser("bhavyag18");
			client.setPassword("123456");
			client.setRemoteFile(fileItem.getName());
			

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

			Iterator itr = items.iterator();
			
			String sql = "insert into files (fileid,name,rank_,key_,userid)values(null,?,?,?,?)";

			pstm = con.prepareStatement(sql);

			FileItem item = (FileItem) itr.next();

			System.out.println("getD "+item.getName());

			String itemName=item.getName();

			ResultSet rs=con.createStatement().executeQuery("select count(*) from files where name='"+itemName+"'");


			boolean isHaving=false;

			while(rs.next())
			{
				isHaving=true;
			}

			if(isHaving)
			{
				System.out.println("in if---------");

				pstm.setString(1,itemName);
				pstm.setString(2,l );
				pstm.setString(3,k );
				pstm.setString(4,my);
				pstm.execute();

				HttpSession session = request.getSession(true);
				session.setAttribute("nn", k);
				System.out.println("Values inserted");

				if (log) {
					
					InputStream myis=fileItem.getInputStream();
					
					String extension=null;
					
					int i = itemName.lastIndexOf('.');
					if (i > 0) {
					    extension = itemName.substring(i+1);
					}
					
					String path="F:\\appuploads\\original."+extension;
					
					FileOutputStream myos=new FileOutputStream(path);
					
					try {
						client.encrypt(myis, myos);
					} catch (Throwable e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					if (client.uploadFile(new FileInputStream(path))) {
						
					response.sendRedirect("adminpage.jsp?msg= sucess..!");
					} else {
						response.sendRedirect("adminpage.jsp?msgg= NOT sucess..!");
					}
				} else {
					out.println("not connected");
				}

			}
			else
			{
				pstm.setString(1,itemName);
				pstm.setString(2,l );
				pstm.setString(3,k );
				pstm.setString(4,my);
				pstm.execute();

				HttpSession session = request.getSession(true);
				session.setAttribute("nn", k);
				System.out.println("Values inserted");

				response.sendRedirect("setkeyword.jsp?msg= sucess..!");
			}

		} catch (SQLException ex) {
			Logger.getLogger(upload1.class.getName()).log(Level.SEVERE, null, ex);
		} catch (ClassNotFoundException ex) {
			Logger.getLogger(upload1.class.getName()).log(Level.SEVERE, null, ex);
		} catch (FileUploadException ex) {
			Logger.getLogger(upload1.class.getName()).log(Level.SEVERE, null, ex);
		} finally {
			out.close();
		}
	}

	// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
	/**
	 * Handles the HTTP
	 * <code>GET</code> method.
	 *
	 * @param request servlet request
	 * @param response servlet response
	 * @throws ServletException if a servlet-specific error occurs
	 * @throws IOException if an I/O error occurs
	 */
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
