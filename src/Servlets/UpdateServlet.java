package Servlets;


import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Author: Shaun Mutch
 * Description: Servlet implementation UpdateServlet
 * responsible for sending SQL update statements to the MySQL 
 * database when issued by UserProfile.jsp requests.
 */
@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Insert registration details into MySQL database
		// Load the driver and connect to database
		try {
			String username = request.getParameter("username").trim();
			String email = request.getParameter("email").trim();
			int nvalue = Integer.parseInt(request.getParameter("nvalue"));
			int tvalue = Integer.parseInt(request.getParameter("tvalue"));
			String password = request.getParameter("password").trim();

			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");
			Statement stat = con.createStatement();
			
			// Encrypt password before SQL update.
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			 byte[] bytes = md.digest();
			 
			 //Convert it to hexadecimal format and return string
	            StringBuilder sb = new StringBuilder();
	            for(int i=0; i< bytes.length ;i++)
	            {
	                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	            }
	            
	            password = sb.toString();

			String sql = "update users set username='"+username+"', email='"+email+"', n='"+nvalue+"',t='"+tvalue+"',password='"+password+"' where username='"+username+"'";
			stat.executeUpdate(sql);

			// Redirect 
			request.setAttribute("errMsg", "User Information Successfully Updated");
			RequestDispatcher rd = request.getRequestDispatcher("GetUser");
			rd.forward(request, response);


		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// Redirect to login and update error message
			request.setAttribute("errMsg", "Username already exists");
			RequestDispatcher rd = request.getRequestDispatcher("UserProfile.jsp");
			rd.forward(request, response); 
			e.printStackTrace();

		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		

	}
}

