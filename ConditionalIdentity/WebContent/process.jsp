<%@page import="java.nio.file.StandardOpenOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="pack.SimpleFTPClient"%>
<%@page import="java.util.Random"%>
<%@page import="pack.mail"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="pack.DbConnector"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		boolean status = false;

		try {
			String[] edits = request.getParameterValues("edit");
			String[] views = request.getParameterValues("view");
			String[] userids = request.getParameterValues("userid");
			
			
			String fileName = request.getParameter("filename");
			
			SimpleFTPClient client = new SimpleFTPClient();
			
			Connection con = DbConnector.getConnection();
			
			ResultSet krs=con.createStatement().executeQuery("select key_ from files where name='"+fileName+"'");
			
			String key="";
			
			while(krs.next())
			{
				key=krs.getString("key_");		
			}
			
			String path = "F:\\venu\\";
			
			client.setHost("ftp.drivehq.com");
			client.setUser("bhavyag18");
			client.setPassword("123456");
			client.setRemoteFile(fileName);
			System.out.println(key);
			
			client.setMykey(key);
		
			client.connect();
			
			Random r = new Random();
			
			String pattern="abcedefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			
			String k ="";
			
			for(int i=0;i<9;i++)
			{
				k=k+pattern.charAt(r.nextInt(60));
			}

			
			if (client.downloadFile(path+"beforeappendencrypt"+fileName)) {
				
				FileInputStream fis=new FileInputStream(path+"beforeappendencrypt"+fileName);
				
				System.out.println("encrypted data:\t "+new String(Files.readAllBytes(Paths.get(path+"beforeappendencrypt"+fileName))));

				FileOutputStream fos=new FileOutputStream(path+"beforeappenddecrypted"+fileName);
				
				try {
					
					client.decrypt(fis, fos);
					
					System.out.println("decrypted data:\t "+new String(Files.readAllBytes(Paths.get(path+"beforeappenddecrypted"+fileName))));
					
					 FileOutputStream append = new FileOutputStream(path+"beforeappenddecrypted"+fileName, true);
				      String strContent = "voidmain"+k;
				     
				       append.write(strContent.getBytes());
				       
				       append.flush();
				       append.close();
				       
				       System.out.println("after append data:\t "+new String(Files.readAllBytes(Paths.get(path+"beforeappenddecrypted"+fileName))));
					
					System.out.println("after flush");
				} catch (Throwable e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			Statement st1 = con.createStatement();
			
			client = new SimpleFTPClient();
			client.setHost("ftp.drivehq.com");
			client.setUser("bhavyag18");
			client.setPassword("123456");
			client.setRemoteFile(fileName);
			client.setMykey(k);

			boolean log = client.connect();
			
			if(log)
			{
			
				FileInputStream fis=new FileInputStream(path+"beforeappenddecrypted"+fileName);
				
				String extension=null;
				
				int i =fileName.lastIndexOf('.');
				if (i > 0) {
				    extension = fileName.substring(i+1);
				}
				
				String newPath="F:\\appuploads\\encrypted."+extension;
				
				FileOutputStream myos=new FileOutputStream(newPath);
				
				try {
					
					client.encrypt(fis, myos);
					
					System.out.println("after append encrypted data:\t "+new String(Files.readAllBytes(Paths.get(newPath))));
					
					System.out.println("in try block after encrypt");
				} catch (Throwable e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				if (client.uploadFile(new FileInputStream(newPath))) {
					
					System.out.println("uploaded to cloud");
				}
			}
			
			
			System.out.println(userids.length+"\t"+fileName+"\t"+k+"\t"+edits.length+"\t"+views.length);


			for (int i = 0; i < edits.length && i < views.length
					&& i < userids.length; i++) {
				
				
				System.out.println(userids[i]+"\t"+fileName+"\t"+k+"\t"+edits[i]+"\t"+views[i]+"\n");
				
				ResultSet rs = st1
						.executeQuery("select * from regpage where userid='"
								+ userids[i] + "'");

				String mails = null;

				if (rs.next()) {

					int count=0;
					
					ResultSet srs=con.createStatement().executeQuery("select count(*) from userfiles where filename='"+fileName+"' and userid='"+userids[i]+"'");
					
					while(srs.next())
					{
						count=srs.getInt(1);
					}
					
					if(count==0)
					{
						con.createStatement().executeUpdate(
								"insert into userfiles values(null,'"
										+ userids[i] + "','" + fileName + "','"
										+ k + "','" + edits[i] + "','"
										+ views[i] + "')");
						con.createStatement().executeUpdate("update files set key_='"+k+"' where name='"+fileName+"'");
					}
					else
					{
						con.createStatement().executeUpdate(
								"update userfiles set filekey='"+k+"',edit='"+edits[i]+"',view='"+views[i]+"' where userid='"+userids[i]+"' and filename='"+fileName+"'");
						con.createStatement().executeUpdate(
								"update files set key_='"+k+"' where name='"+fileName+"'");
						
					}

					mails = rs.getString("mail");
					
					System.out.println("mails checking \t"+mails);

					if(!(edits[i].equals("no") && views[i].equals("no")))
					{		
							mail.mailsend(k, mails, "");
					}
					else
					{
						System.out.println("mails checking failed ");
					}
				}
			}

			status = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (status) {
			
			response.sendRedirect("adminpage.jsp?mail=public key send sucess..!");
		} else {

			response.sendRedirect("adminpage.jsp?mailf=public key send fails..!");
		}
	%>
</body>
</html>