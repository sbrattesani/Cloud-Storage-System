

import java.io.IOException;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 * Description: Servlet responsible for handling communication
 * between the engine and SQL database. Makes use of SQL statements
 * to read and write information provided by the engine and database.
 */

@WebServlet("/Cloudlet")
public class Cloudlet extends HttpServlet implements Serializable {
	private static final long serialVersionUID = 1L;

	public Cloudlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = (String) request.getAttribute("id");

		try {

			// Database connection
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");


			// constructs SQL statement
			String sql = "SELECT * FROM files WHERE id =" + id;
			Statement stat = con.prepareStatement(sql);

			ResultSet rs = stat.executeQuery(sql);            

			// Redirect resultset to engine for unpacking
			request.setAttribute("rSet", rs);
			RequestDispatcher rd = request.getRequestDispatcher("Engine");
			rd.forward(request, response); 
			
			// Error handling
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			request.setAttribute("errMsg", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("Download.jsp");
			rd.forward(request, response); 
			
		}
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Request filename and secret share from Engine
		byte[] sBytes = (byte[]) request.getAttribute("secretFile");
		byte[] fBytes = (byte[]) request.getAttribute("fvalue");
		String fileName = (String) request.getAttribute("fileName");
		String n = request.getParameter("nvalue");
		String t = request.getParameter("tvalue");
	
		try {

			// Database connection
			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager
					.getConnection("jdbc:mysql://localhost/cds?user=root&password=&useSSL=false");


			// constructs SQL statement
			String sql = "INSERT INTO files (ID, filename, N, T, file, F) values (?, ?, ?, ?, ?, ?)";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, 0);
			stat.setString(2, fileName);
			stat.setString(3, n);
			stat.setString(4, t);
			stat.setObject(5, sBytes);
			stat.setBytes(6, fBytes);

			// Execute the SQL statement
			stat.executeUpdate();

			// Redirect to login and update error message
			request.setAttribute("errMsg", "File " + fileName + " has been uploaded successfully");
			RequestDispatcher rd = request.getRequestDispatcher("Upload.jsp");
			rd.forward(request, response); 

			// Error handling
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			request.setAttribute("errMsg", e.getMessage());
			RequestDispatcher rd = request.getRequestDispatcher("Upload.jsp");
			rd.forward(request, response); 
		}
	}
}
