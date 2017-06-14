package Servlets;

/**
 * Author: Shaun Mutch
 * Description: Servlet responsible for retrieving
 * user information from the SQL database and
 * forwarding it to the user settings page for edit.
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/GetUser")
public class GetUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GetUser() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Database connection
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");
			Statement stat = con.createStatement();

			String user = (String) request.getSession().getAttribute("username");;
			String sql = "SELECT * FROM users WHERE username = '"+user+"'";
			ResultSet results  = stat.executeQuery(sql);

			while (results.next()) {
				String username = results.getString(1);
				String email = results.getString(2);
				int nValue = results.getInt(3);
				int tValue = results.getInt(4);
				
				// Forward SQL attributes to user settings page
				request.getSession().setAttribute("username", username);
				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("nvalue", nValue);
				request.getSession().setAttribute("tvalue", tValue);

			}
			request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}
}



