package Servlets;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Author: Shaun Mutch
 * Description: Servlet responsible for terminating
 * the users session and redirecting to login screen.
 */

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response)
					throws ServletException, IOException {

		// Invalidate session
		HttpSession session = request.getSession();
		session.invalidate();

		// Redirect to login page
		response.sendRedirect("Login.jsp");


	}
}
