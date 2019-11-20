package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ProfileBean;

/**
 * Handles submissions from the Edit Profile modal, writing them to the DB and redirecting back to the Profile View page.
 */
@WebServlet("/profile_edit")
public class ProfileEditServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProfileBean p = new ProfileBean( request.getParameter("id").toString(), request.getParameter("name").toString(), request.getParameter("bio").toString(), request.getParameter("site").toString(), request.getParameter("skills").toString() );
		p.writeChanges();
		response.sendRedirect("profile?id=" + p.getId());
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
