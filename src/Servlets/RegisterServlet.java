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
 * Description: Servlet responsible for taking user information
 * and sending SQL update statements to the MySQL database
 * to add authorised users.
 */

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException, IOException {


		// Insert registration details into MySQL database
		// Load the driver and connect to database
		try {
			String username = request.getParameter("username").trim();
			String email = request.getParameter("email").trim();
			int nValue = Integer.parseInt(request.getParameter("nvalue"));
			int tValue = Integer.parseInt(request.getParameter("tvalue"));
			String password = request.getParameter("password").trim();
			
			// Password encryption to improve security through message digest
						
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
					            
				

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");
			Statement stat = con.createStatement();

			String sql = "insert into users values ('" + username+ "', '" + email + "', '" + nValue + "', '" + tValue + "', '" + password +  "')";
			stat.executeUpdate(sql);

			// Redirect to login
			request.setAttribute("errMsg", "User Successfully Added");
			RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
			rd.forward(request, response);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// Redirect to login and update error message
			request.setAttribute("errMsg", "Username already exists");
			RequestDispatcher rd = request.getRequestDispatcher("Register.jsp");
			rd.forward(request, response); 
			;
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("errMsg", e.getMessage());
		}		

	}


}
