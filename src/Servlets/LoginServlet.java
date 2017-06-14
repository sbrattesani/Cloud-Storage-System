package Servlets;


import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Author: Shaun Mutch
 * Description: Servlet responsible for authenticating
 * usernames and passwords againts the SQL database
 * and creating a session on success.
 */

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException, IOException {
		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();


		try {
			// Database connection	
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");
			Statement stat = con.createStatement();
			

			// Password encryption to improved security.
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

			ResultSet rs = stat.executeQuery("SELECT * FROM users WHERE username = '" + username +
					"'AND password = '" + password + "'");
			if (rs.next()){

				// Create new session
				HttpSession session = request.getSession(true);
				session.setAttribute("username", username);
				session.setAttribute("password", password);
				session.setAttribute("nvalue", rs.getInt("N"));
				session.setAttribute("tvalue", rs.getInt("T"));
				session.setMaxInactiveInterval(600); // Log user out if inactive, improving security.
        
				response.sendRedirect("Interface.jsp");
				con.close();
			} else {
				// Redirect to login and update error message
				request.setAttribute("errMsg", "Username or password is incorrect");
				RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
				rd.forward(request, response); 
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		

	}


}
